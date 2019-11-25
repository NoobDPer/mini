package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.dto.RoleDTO;
import com.jk.minimalism.bean.entity.Role;
import com.jk.minimalism.dao.RoleMapper;
import com.jk.minimalism.service.RoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

	private static final Logger log = LoggerFactory.getLogger("adminLogger");

	@Autowired
	private RoleMapper roleMapper;

	@Override
	@Transactional
	public void saveRole(RoleDTO roleDto) {
		Role role = roleDto;
		List<Long> permissionIds = roleDto.getPermissionIds();
		permissionIds.remove(0L);

		if (role.getId() != null) {// 修改
			updateRole(role, permissionIds);
		} else {// 新增
			saveRole(role, permissionIds);
		}
	}

	private void saveRole(Role role, List<Long> permissionIds) {
		Role r = roleMapper.getRole(role.getName());
		if (r != null) {
			throw new IllegalArgumentException(role.getName() + "已存在");
		}

		roleMapper.save(role);
		if (!CollectionUtils.isEmpty(permissionIds)) {
			roleMapper.saveRolePermission(role.getId(), permissionIds);
		}
		log.debug("新增角色{}", role.getName());
	}

	private void updateRole(Role role, List<Long> permissionIds) {
		Role r = roleMapper.getRole(role.getName());
		if (r != null && !r.getId().equals(role.getId())) {
			throw new IllegalArgumentException(role.getName() + "已存在");
		}

		roleMapper.update(role);

		roleMapper.deleteRolePermission(role.getId());
		if (!CollectionUtils.isEmpty(permissionIds)) {
			roleMapper.saveRolePermission(role.getId(), permissionIds);
		}
		log.debug("修改角色{}", role.getName());
	}

	@Override
	@Transactional
	public void deleteRole(Long id) {
		roleMapper.deleteRolePermission(id);
		roleMapper.deleteRoleUser(id);
		roleMapper.deleteById(id);

		log.debug("删除角色id:{}", id);
	}

	@Override
	public int count(Map<String, Object> params) {
		return roleMapper.count(params);
	}

	@Override
	public List<Role> list(Map<String, Object> params, Integer offset, Integer limit) {
		return roleMapper.list(params, offset, limit);
	}

	@Override
	public Role getById(Long id) {
		return roleMapper.getById(id);
	}

	@Override
	public List<Role> listByUserId(Long userId) {
		return roleMapper.listByUserId(userId);
	}
}
