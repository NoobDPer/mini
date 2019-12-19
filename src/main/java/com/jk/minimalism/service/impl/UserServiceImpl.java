package com.jk.minimalism.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jk.minimalism.bean.common.PageResult;
import com.jk.minimalism.bean.dto.UserDTO;
import com.jk.minimalism.bean.dto.UserListRequestDTO;
import com.jk.minimalism.bean.dto.UserListResponseDTO;
import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.bean.entity.UserRole;
import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.bean.enums.UserStatus;
import com.jk.minimalism.dao.UserMapper;
import com.jk.minimalism.dao.UserRoleMapper;
import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import com.jk.minimalism.service.TokenService;
import com.jk.minimalism.service.UserService;
import com.jk.minimalism.util.Base64Util;
import com.jk.minimalism.util.BeanFillUtils;
import com.jk.minimalism.util.IdUtils;
import com.jk.minimalism.util.PageHandleUtils;
import com.jk.minimalism.util.UserUtil;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;


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

    private ModelMapper modelMapper;

    @Autowired
    public UserServiceImpl(UserMapper userMapper,
                           UserRoleMapper userRoleMapper,
                           BCryptPasswordEncoder passwordEncoder,
                           TokenService tokenService,
                           ModelMapper modelMapper) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
        this.userRoleMapper = userRoleMapper;
        this.tokenService = tokenService;
        this.modelMapper = modelMapper;
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

        user.setState(User.Status.VALID);
        user.setId(IdUtils.nextId());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setPswCode(Base64Util.encode(user.getPassword()));
        BeanFillUtils.setCreateAttr(user);
        if (StringUtils.isEmpty(user.getNickname())) {
            user.setNickname(IdUtils.generateShortUuid());
        }
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
            user.setPswCode(Base64Util.encode(user.getPassword()));
        } else {
            user.setPassword(null);
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
        updateParam.setPswCode(Base64Util.encode(newPassword));
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
    public PageResult<UserListResponseDTO> list(UserListRequestDTO params) {
        PageInfo<UserListResponseDTO> pageInfo = PageHelper.startPage(params.getPager().getPage(), params.getPager().getSize())
                .doSelectPageInfo(() -> userMapper.list(params));
        pageInfo.getList().forEach(l -> l.setStateDesc(UserStatus.getDescByState(l.getState())));
        PageResult<UserListResponseDTO> pageResult = PageHandleUtils.convertToPageResult(pageInfo);
        if (CollectionUtils.isNotEmpty(pageInfo.getList())) {
            pageResult.setData(pageInfo.getList());
        }
        return pageResult;
    }

    @Override
    public void deleteUser(Long id) {
        this.updateStates(Collections.singletonList(id), User.Status.DISABLED);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateLoginTime(long id) {
        userMapper.updateLoginTime(id);
    }

}
