package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.dto.LoginUser;
import com.jk.minimalism.bean.entity.Permission;
import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.dao.PermissionMapper;
import com.jk.minimalism.dao.UserMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;


/**
 * spring security登陆处理<br>
 * <p>
 * 密码校验请看文档（02 框架及配置），第三章第4节
 *
 * @author jiaokai
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private final PermissionMapper permissionMapper;

    private final UserMapper userMapper;

    @Autowired
    public UserDetailsServiceImpl(PermissionMapper permissionMapper,
                                  UserMapper userMapper) {
        this.permissionMapper = permissionMapper;
        this.userMapper = userMapper;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userMapper.findByUsername(username);
        if (Objects.isNull(user)) {
            throw new AuthenticationCredentialsNotFoundException("用户名不存在");
        } else if (user.getState() == User.Status.DISABLED || user.getState() == User.Status.FROZEN) {
            throw new LockedException("当前账号已冻结，无法登录");
        }

        LoginUser loginUser = new LoginUser();
        BeanUtils.copyProperties(user, loginUser);

        // 权限
        List<Permission> permissions = permissionMapper.listByUserId(user.getId());
        loginUser.setPermissions(permissions);
        // 角色
        Integer role = userMapper.findRoleByUserId(loginUser.getId());
        loginUser.setRoleId(role);
        return loginUser;
    }

}
