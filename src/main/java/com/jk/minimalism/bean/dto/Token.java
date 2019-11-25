package com.jk.minimalism.bean.dto;

import java.io.Serializable;

/**
 * Restful方式登陆token
 *
 * @author jiaokai
 * <p>
 * 2017年8月4日
 */
public class Token implements Serializable {

    private static final long serialVersionUID = 6314027741784310221L;

    private String token;
    /**
     * 登陆时间戳（毫秒）
     */
    private Long loginTime;

    private Long userId;

    private Integer roleId;

    public Token(String token, Long loginTime, Long userId, Integer roleId) {
        super();
        this.token = token;
        this.loginTime = loginTime;
        this.userId = userId;
        this.roleId = roleId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Long getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Long loginTime) {
        this.loginTime = loginTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }
}
