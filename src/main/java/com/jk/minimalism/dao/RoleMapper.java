package com.jk.minimalism.dao;


import com.jk.minimalism.bean.entity.Role;
import com.jk.minimalism.dao.base.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface RoleMapper extends BaseMapper<Role> {

    @Options(useGeneratedKeys = true, keyProperty = "id")
    @Insert("INSERT INTO sys_role(NAME, DESCRIPTION) VALUES(#{name}, #{description})")
    int save(Role role);

    int count(@Param("params") Map<String, Object> params);

    List<Role> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset,
                    @Param("limit") Integer limit);

    @Select("SELECT * FROM sys_role T WHERE T.ID = #{id}")
    Role getById(Long id);

    @Select("SELECT * FROM sys_role T WHERE T.NAME = #{name}")
    Role getRole(String name);

    @Update("UPDATE sys_role T SET T.NAME = #{name}, T.DESCRIPTION = #{description} where T.ID = #{id}")
    int update(Role role);

    @Select("SELECT * FROM sys_role R INNER JOIN sys_role_user RU ON R.ID = RU.ROLE_ID WHERE RU.USER_ID = #{userId}")
    List<Role> listByUserId(Long userId);

    @Delete("DELETE FROM sys_role_permission WHERE ROLE_ID = #{roleId}")
    int deleteRolePermission(Long roleId);

    int saveRolePermission(@Param("roleId") Long roleId, @Param("permissionIds") List<Long> permissionIds);

    @Delete("DELETE FROM sys_role WHERE ID = #{id}")
    int deleteById(Long id);

    @Delete("DELETE FROM sys_role_user WHERE ROLE_ID = #{roleId}")
    int deleteRoleUser(Long roleId);

}