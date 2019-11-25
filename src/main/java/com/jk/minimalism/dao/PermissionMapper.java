package com.jk.minimalism.dao;

import com.jk.minimalism.bean.entity.Permission;
import com.jk.minimalism.dao.base.BaseMapper;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface PermissionMapper extends BaseMapper<Permission> {

    /**
     * 列取全部账号的权限
     * @return 全部账号的权限
     */
    List<Permission> listAll();

    /**
     * 根据用户ID 获取权限列表
     * @param userId 用户ID
     * @return 权限列表
     */
    List<Permission> listByUserId(@Param("userId") Long userId);

    @Select("SELECT * FROM sys_permission T WHERE T.TYPE = 1 ORDER BY T.SORT")
    List<Permission> listParents();

    @Select("SELECT P.* FROM sys_permission P INNER JOIN sys_role_permission RP ON P.ID = RP.PERMISSION_ID WHERE RP.ROLE_ID = #{roleId} ORDER BY P.SORT")
    List<Permission> listByRoleId(Long roleId);

    @Select("SELECT * FROM sys_permission T WHERE T.ID = #{id}")
    Permission getById(Long id);

    @Insert("INSERT INTO sys_permission(PARENT_ID, NAME, CSS, HREF, TYPE, PERMISSION, SORT) VALUES(#{parentId}, #{name}, #{css}, #{href}, #{type}, #{permission}, #{sort})")
    int save(Permission permission);

    @Update("UPDATE sys_permission T SET PARENT_ID = #{parentId}, NAME = #{name}, CSS = #{css}, HREF = #{href}, TYPE = #{type}, PERMISSION = #{permission}, SORT = #{sort} WHERE T.ID = #{id}")
    int update(Permission permission);

    @Delete("DELETE FROM sys_permission WHERE ID = #{id}")
    int deleteById(Long id);

    @Delete("DELETE FROM sys_permission WHERE PARENT_ID = #{id}")
    int deleteByParentId(Long id);

    @Delete("DELETE FROM sys_role_permission WHERE PERMISSION_ID = #{permissionId}")
    int deleteRolePermission(Long permissionId);

    @Select("SELECT RU.USER_ID FROM sys_role_permission RP INNER JOIN sys_role_user RU ON RU.ROLE_ID = RP.ROLE_ID WHERE RP.PERMISSION_ID = #{permissionId}")
    Set<Long> listUserIds(Long permissionId);

}