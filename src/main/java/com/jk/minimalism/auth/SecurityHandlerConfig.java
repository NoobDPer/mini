package com.jk.minimalism.auth;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.dto.LoginUser;
import com.jk.minimalism.bean.dto.Token;
import com.jk.minimalism.service.TokenService;
import com.jk.minimalism.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;


/**
 * spring security处理器
 *
 * @author jiaokai
 * <p>
 * 2017年10月16日
 */
@Configuration
public class SecurityHandlerConfig {

    private final TokenService tokenService;

    @Autowired
    public SecurityHandlerConfig(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    /**
     * 登陆成功，返回Token
     */
    @Bean
    public AuthenticationSuccessHandler loginSuccessHandler() {
        return (request, response, authentication) -> {
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();

            Token token = tokenService.saveToken(loginUser);
            ResponseUtil.responseJson(response, HttpStatus.OK.value(), token);
        };
    }

    /**
     * 登陆失败
     */
    @Bean
    public AuthenticationFailureHandler loginFailureHandler() {
        return (request, response, exception) -> {
            String msg;
            if (exception instanceof BadCredentialsException) {
                msg = "密码错误";
            } else {
                msg = exception.getMessage();
            }
            AjaxResult info = new AjaxResult(HttpStatus.UNAUTHORIZED.value() + "", msg);
            ResponseUtil.responseJson(response, HttpStatus.UNAUTHORIZED.value(), info);
        };

    }

    /**
     * 未登录，返回401
     */
    @Bean
    public AuthenticationEntryPoint authenticationEntryPoint() {
        return (request, response, authException) -> {
            AjaxResult info = new AjaxResult(HttpStatus.UNAUTHORIZED.value() + "", "请先登录");
            ResponseUtil.responseJson(response, HttpStatus.UNAUTHORIZED.value(), info);
        };
    }

    /**
     * 退出处理
     */
    @Bean
    public LogoutSuccessHandler logoutSussHandler() {
        return (request, response, authentication) -> {
            AjaxResult info = new AjaxResult(HttpStatus.OK.value() + "", "退出成功");

            String token = TokenFilter.getToken(request);
            tokenService.deleteToken(token);

            ResponseUtil.responseJson(response, HttpStatus.OK.value(), info);
        };

    }

}
