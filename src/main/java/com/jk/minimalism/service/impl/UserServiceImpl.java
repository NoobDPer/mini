package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.bean.entity.UserRole;
import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.dao.UserMapper;
import com.jk.minimalism.dao.UserRoleMapper;
import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import com.jk.minimalism.service.TokenService;
import com.jk.minimalism.service.UserService;
import com.jk.minimalism.util.BeanFillUtils;
import com.jk.minimalism.util.UserUtil;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * 用户服务实现类
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/08/09
 */
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    private final UserRoleMapper userRoleMapper;


    private BCryptPasswordEncoder passwordEncoder;

    private TokenService tokenService;


    @Autowired
    public UserServiceImpl(UserMapper userMapper,
                           UserRoleMapper userRoleMapper,
                           BCryptPasswordEncoder passwordEncoder,
                           TokenService tokenService) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
        this.userRoleMapper = userRoleMapper;
        this.tokenService = tokenService;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public User find(Long id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public User insert(User user, Integer roleId) {
        if (userMapper.existsWithUsername(user.getUsername())) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_USERNAME_EXISTS_ERROR, String.format("用户名已经存在: username: [%s]", user.getUsername()));
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        BeanFillUtils.setCreateAttr(user);
        userMapper.insertSelective(user);
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRole.setRoleId(roleId);
        userRoleMapper.insert(userRole);
        return user;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public User update(User user) {
        if (userMapper.existsWithUsernameWithoutId(user.getUsername(), user.getId())) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_USERNAME_EXISTS_ERROR, String.format("用户名已经存在: username: [%s]", user.getUsername()));
        }

        if (StringUtils.isNotEmpty(user.getPassword())) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        BeanFillUtils.setUpdateAttr(user);
        userMapper.updateByPrimaryKeySelective(user);
        return user;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updatePassword(Long id, String oldPassword, String newPassword) {
        User user = userMapper.selectByPrimaryKey(id);
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_PASSWORD_ERROR, String.format("更新密码失败, 密码错误: oldPassword:[%s]", oldPassword));
        }
        if (passwordEncoder.matches(newPassword, user.getPassword())) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_NEW_PASSWORD_REPEATED_ERROR);
        }

        User updateParam = new User();
        updateParam.setId(id);
        updateParam.setPassword(passwordEncoder.encode(newPassword));
        BeanFillUtils.setUpdateAttr(user);
        userMapper.updateByPrimaryKeySelective(updateParam);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateStates(List<Long> ids, int state) {
        if (state != User.Status.VALID && state != User.Status.DISABLED && state != User.Status.FROZEN) {
            throw new MinimalismBizRuntimeException(ResultCode.PARAM_ERROR, String.format("错误的用户状态: ids:[%s], state:[%s]", ids, state));
        }

        userMapper.updateStates(ids, state, UserUtil.getUserId());

        if (state == User.Status.DISABLED || state == User.Status.FROZEN) {
            // 踢出用户
            List<String> userNames = userMapper.selectUserNamesByIds(ids);
            for (String username : userNames) {
                tokenService.deleteTokenByUsername(username);
            }
        }
    }

    @Override
    public User findUserByName(String username) {
        return userMapper.findByUsername(username);
    }

    @Override
    public Integer count(Map<String, Object> params) {
        return userMapper.count(params);
    }

    @Override
    public List<User> list(Map<String, Object> params, Integer offset, Integer limit) {
        return userMapper.list(params, offset, limit);
    }

    @Override
    public void deleteUser(Long id) {
        userMapper.deleteUser(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resetPassword(List<Long> ids, String password) {
        userMapper.updatePassword(ids, passwordEncoder.encode(password), UserUtil.getUserId());
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean existsDisabled(List<Long> ids) {
        return userMapper.existsDisabled(ids);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUsername(long id, String username) {
        if (userMapper.existsWithUsernameWithoutId(username, id)) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_USERNAME_EXISTS_ERROR, String.format("用户名已经存在: username: [%s]", username));
        }

        User user = userMapper.selectByPrimaryKey(id);
        if (null == user) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_NOT_EXISTS_ERROR);
        }

        if (user.getState() == User.Status.DISABLED) {
            throw new MinimalismBizRuntimeException(ResultCode.USER_DISABLED_ERROR);
        }

        user.setUsername(username);
        BeanFillUtils.setUpdateAttr(user);
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateLoginTime(long id) {
        userMapper.updateLoginTime(id);
    }

    @Override
    public List<User> findByIds(List<Long> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return new ArrayList<>();
        }
        return userMapper.selectByIds(ids);
    }
}
