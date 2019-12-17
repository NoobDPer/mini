package com.jk.minimalism.auth;

import com.jk.minimalism.bean.constant.SysConstants;
import com.jk.minimalism.bean.dto.LoginUser;
import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.exception.ValidateException;
import com.jk.minimalism.service.TokenService;
import com.jk.minimalism.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;


/**
 * @author admin-jk
 * @date 19-6-25
 */
@Component
public class TokenFilter extends OncePerRequestFilter {

    public static final String TOKEN_KEY = "token";

    @Autowired
    private TokenService tokenService;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private UserService userService;

    @Autowired
    private AuthenticationEntryPoint authenticationEntryPoint;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    private static final Long MINUTES_10 = 10 * 60 * 1000L;

    private static final String USERNAME_PARAMTER = "username";

    private static final String PASSWORD_PARAMTER = "password";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        try {
            String username = request.getParameter(USERNAME_PARAMTER);
            String password = request.getParameter(PASSWORD_PARAMTER);

            String token = getToken(request);
            if (StringUtils.isNotBlank(token)) {
                LoginUser loginUser = tokenService.getLoginUser(token);
                if (loginUser != null) {
                    loginUser = checkLoginTime(loginUser);
                    UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(loginUser,
                            null, loginUser.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                } else {
                    throw new CredentialsExpiredException("未登录或登录已过期，请重新登录。");
                }
            }

            if (org.springframework.util.StringUtils.pathEquals(SysConstants.LOGIN_URL, request.getRequestURI())
                    && RequestMethod.POST.name().equalsIgnoreCase(request.getMethod())) {
                User user = userService.findUserByName(username);
                if (Objects.nonNull(user) && user.getPassword().equals(passwordEncoder.encode(password))) {
                    userService.updateLoginTime(user.getId());
                }
            }
            filterChain.doFilter(request, response);
        } catch (CredentialsExpiredException | ValidateException e) {
            logger.info("登录校验错误！错误信息：{}", e);
            SecurityContextHolder.clearContext();
            this.authenticationEntryPoint.commence(request, response, e);
        }
    }

    /**
     * 校验时间<br>
     * 过期时间与当前时间对比，临近过期10分钟内的话，自动刷新缓存
     *
     */
    private LoginUser checkLoginTime(LoginUser loginUser) {
        long expireTime = loginUser.getExpireTime();
        long currentTime = System.currentTimeMillis();
        if (expireTime - currentTime <= MINUTES_10) {
            String token = loginUser.getToken();
            loginUser = (LoginUser) userDetailsService.loadUserByUsername(loginUser.getUsername());
            loginUser.setToken(token);
            tokenService.refresh(loginUser);
        }
        return loginUser;
    }

    /**
     * 根据参数或者header获取token
     *
     */
    public static String getToken(HttpServletRequest request) {
        String token = request.getParameter(TOKEN_KEY);
        if (StringUtils.isBlank(token)) {
            token = request.getHeader(TOKEN_KEY);
        }

        return token;
    }

}
