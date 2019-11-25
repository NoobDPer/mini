package com.jk.minimalism.bean.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jk.minimalism.bean.entity.Permission;
import com.jk.minimalism.bean.entity.User;
import lombok.Data;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.StringUtils;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author admin-jk
 * @date 19-8-12
 */
@Data
public class LoginUser extends User implements UserDetails {
    /**
     * 权限列表
     */
    private List<Permission> permissions;

    /**
     * 角色id
     */
    private Integer roleId;

    /**
     * token
     */
    private String token;

    /**
     * 登陆时间戳（毫秒）
     */
    private Long loginTime;

    /**
     * 过期时间戳
     */
    private Long expireTime;

    @Override
    @JsonIgnore
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return CollectionUtils.isEmpty(permissions) ? new HashSet<>() :
                permissions.parallelStream().filter(p -> !StringUtils.isEmpty(p.getPermission()))
                        .map(p -> new SimpleGrantedAuthority(p.getPermission())).collect(Collectors.toSet());
    }

    public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
        // do nothing
    }

    /**
     * 账户是否未过期
     */
    @JsonIgnore
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    /**
     * 账户是否未锁定
     */
    @JsonIgnore
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    /**
     * 密码是否未过期
     */
    @JsonIgnore
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    /**
     * 账户是否激活
     */
    @JsonIgnore
    @Override
    public boolean isEnabled() {
        return getState() != Status.DISABLED && getState() != Status.FROZEN;
    }

}
