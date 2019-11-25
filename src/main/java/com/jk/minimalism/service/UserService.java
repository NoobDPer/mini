package com.jk.minimalism.service;

import com.jk.minimalism.bean.entity.User;

import java.util.List;
import java.util.Map;

/**
 * 用户服务
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/08/09
 */
public interface UserService {

    /**
     * 根据用户id获取id
     *
     * @param id 用户id
     * @return 获取到则返回用户对象, 否则返回null
     */
    User find(Long id);

    /**
     * 新增用户
     *
     * @param user 需要新增的用户
     */
    User insert(User user, Integer roleId);

    /**
     * 更新用户
     * 如果password字段有值, 会加密后保存
     *
     * @param user 需要更新的用户
     */
    User update(User user);

    /**
     * 更新密码
     *
     * @param id          用户id
     * @param oldPassword 新密码
     * @param newPassword 新密码
     */
    void updatePassword(Long id, String oldPassword, String newPassword);

    /**
     * 批量更新状态
     *
     * @param ids   批量用户id
     * @param state 状态
     */
    void updateStates(List<Long> ids, int state);

    /**
     * 根据用户名和类型查找用户
     *
     * @param username 用户名
     * @return 用户信息
     */
    User findUserByName(String username);

    Integer count(Map<String, Object> params);

    List<User> list(Map<String, Object> params, Integer offset, Integer limit);

    void deleteUser(Long id);

    /**
     * 重置密码
     *
     * @param ids      需要重置密码的用户id
     * @param password 重置后的密码
     */
    void resetPassword(List<Long> ids, String password);

    /**
     * 是否存在停用的
     *
     * @param ids 用户ids
     * @return true: 存在停用的 false: 不存在
     */
    boolean existsDisabled(List<Long> ids);

    /**
     * 修改用户名
     *
     * @param id       用户id
     * @param username 手机号
     */
    void updateUsername(long id, String username);

    /**
     * 更新登录时间
     *
     * @param id 用户ID
     */
    void updateLoginTime(long id);

    /**
     * 批量查询用户
     *
     * @param ids 用户id
     * @return 用户
     */
    List<User> findByIds(List<Long> ids);
}
