package com.jk.minimalism.service;


import com.jk.minimalism.bean.dto.RoleDTO;
import com.jk.minimalism.bean.entity.Role;

import java.util.List;
import java.util.Map;

public interface RoleService {

	void saveRole(RoleDTO roleDto);

	void deleteRole(Long id);

	int count(Map<String, Object> params);

	List<Role> list(Map<String, Object> params, Integer offset, Integer limit);

	List<Role> listAll();

	Role getById(Long id);

	List<Role> listByUserId(Long userId);
}
