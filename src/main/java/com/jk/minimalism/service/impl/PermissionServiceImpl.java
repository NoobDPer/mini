package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.entity.Permission;
import com.jk.minimalism.dao.PermissionMapper;
import com.jk.minimalism.service.PermissionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author admin-jk
 * @date 19-8-13
 */
@Service
@Slf4j
public class PermissionServiceImpl implements PermissionService {

    private final PermissionMapper permissionMapper;

    @Autowired
    public PermissionServiceImpl(PermissionMapper permissionMapper) {
        this.permissionMapper = permissionMapper;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<Permission> listAll() {
        return permissionMapper.listAll();
    }

    @Override
    public List<Permission> listByUserId(Long userId) {
        return permissionMapper.listByUserId(userId);
    }

    @Override
    public void save(Permission permission) {
        permissionMapper.save(permission);
    }

    @Override
    public void update(Permission permission) {
        permissionMapper.update(permission);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(Long id) {
        permissionMapper.deleteRolePermission(id);
        permissionMapper.deleteById(id);
        permissionMapper.deleteByParentId(id);
    }

    @Override
    public List<Permission> listByRoleId(Long roleId) {
        return permissionMapper.listByRoleId(roleId);
    }

    @Override
    public List<Permission> listParents() {
        return permissionMapper.listParents();
    }

    @Override
    public Permission getById(Long id) {
        return permissionMapper.getById(id);
    }
}
