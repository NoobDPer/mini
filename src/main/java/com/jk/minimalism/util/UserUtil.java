package com.jk.minimalism.util;

import com.jk.minimalism.auth.TokenFilter;
import com.jk.minimalism.bean.dto.LoginUser;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Objects;

import static com.jk.minimalism.bean.constant.SysConstants.DEFAULT_USER;


/**
 * 用户工具类
 *
 * @author admin-jk
 */
public class UserUtil {

    /**
     * 获取当前登录用户
     *
     * @return 当前登录用户信息
     */
    public static LoginUser getLoginUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            if (authentication instanceof AnonymousAuthenticationToken) {
                throw new IllegalArgumentException("loginUser can not be null");
            }
            if (authentication instanceof UsernamePasswordAuthenticationToken) {
                return (LoginUser) authentication.getPrincipal();
            }
        }
        throw new IllegalArgumentException("loginUser can not be null");
    }

    /**
     * 获取用户ID, 如果已经登录返回登录用户ID, 如果没有登录返回默认用户ID
     *
     * @return 用户ID
     */
    public static long getUserId() {
        if (Objects.nonNull(SpringContextUtils.getRequest())
                && Objects.nonNull(TokenFilter.getToken(SpringContextUtils.getRequest()))) {
            return UserUtil.getLoginUser().getId();
        }
        return DEFAULT_USER;
    }

}
