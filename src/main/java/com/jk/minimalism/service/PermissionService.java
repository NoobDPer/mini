package com.jk.minimalism.service;


import com.jk.minimalism.bean.entity.Permission;

import java.util.List;

/**
 * 权限相关服务
 *
 * @author admin-jk
 * @date 19-8-13
 */
public interface PermissionService {

    /**
     * 查询所有权限
     *
     * @return 权限
     */
    List<Permission> listAll();

    /**
     * 根据用户ID 获取权限列表
     * @param userId 用户ID
     * @return 权限列表
     */
    List<Permission> listByUserId(Long userId);

    void save(Permission permission);

    void update(Permission permission);

    void delete(Long id);

    List<Permission> listByRoleId(Long roleId);

    List<Permission> listParents();

    Permission getById(Long id);
}
