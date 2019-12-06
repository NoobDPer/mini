package com.jk.minimalism.dao;

import com.jk.minimalism.base.mapper.BaseMapper;
import com.jk.minimalism.bean.entity.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

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

    List<Permission> listParents();

    List<Permission> listByRoleId(@Param("roleId") Long roleId);

    Permission getById(@Param("id") Long id);

    int save(Permission permission);

    int update(Permission permission);

    int deleteById(@Param("id") Long id);

    int deleteByParentId(@Param("id") Long id);

    int deleteRolePermission(@Param("permissionId") Long permissionId);

    Set<Long> listUserIds(@Param("permissionId") Long permissionId);

}