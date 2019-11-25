package com.jk.minimalism.dao;

import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.dao.base.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface UserMapper extends BaseMapper<User> {

    /**
     * 根据用户名获取用户
     *
     * @param username 用户名
     * @return 用户信息
     */
    @Select("SELECT * FROM sys_user WHERE BINARY USERNAME = #{username}")
    User findByUsername(@Param("username") String username);

    @Select("SELECT R.ROLE_ID FROM sys_user U " +
            "INNER JOIN sys_user_role R ON U.ID = R.USER_ID " +
            "WHERE U.ID = #{id} LIMIT 1")
    Integer findRoleByUserId(@Param("id") Long id);

    Integer count(@Param("params") Map<String, Object> params);

    List<User> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset,
                       @Param("limit") Integer limit);

    @Delete("DELETE T1, T2 FROM sys_user T1 " +
            "INNER JOIN sys_role_user T2 ON T1.id = T2.userId " +
            "WHERE T1.id = #{userId}")
    void deleteUser(@Param("userId") Long userId);
    /**
     * 批量更新状态
     *
     * @param ids   需要更新状态的id
     * @param state 状态
     * @return 影响行数
     */
    Long updateStates(@Param("ids") List<Long> ids, @Param("state") int state, @Param("updateUserId") long updateUserId);

    /**
     * 更新密码
     *
     * @param ids          用户id
     * @param newPassword  新密码
     * @param updateUserId 更新用户id
     * @return 影响行数
     */
    Long updatePassword(@Param("ids") List<Long> ids, @Param("newPassword") String newPassword, @Param("updateUserId") long updateUserId);

    /**
     * 检查用户名是否已经存在
     *
     * @param username 用户名
     * @return true: 存在 false: 不存在
     */
    boolean existsWithUsername(@Param("username") String username);

    /**
     * 排除指定的用户之后用户名是否已经存在
     *
     * @param username 用户名
     * @param id       用户id
     * @return true: 存在 false: 不存在
     */
    boolean existsWithUsernameWithoutId(@Param("username") String username, @Param("id") Long id);

    /**
     * 是否存在停用的
     *
     * @param ids 用户ids
     * @return true: 存在停用的 false: 不存在
     */
    boolean existsDisabled(@Param("ids") List<Long> ids);

    /**
     * 更新登录时间
     *
     * @param id 用户ID
     * @return 影响行数
     */
    int updateLoginTime(@Param("id") Long id);

    /**
     * 根据用户id获取用户名
     *
     * @param ids 用户id
     * @return 用户id
     */
    List<String> selectUserNamesByIds(@Param("ids") List<Long> ids);

    /**
     * 批量查询用户
     *
     * @param ids 用户id
     * @return 用户
     */
    List<User> selectByIds(@Param("ids") List<Long> ids);
}