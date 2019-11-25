package com.jk.minimalism.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.jk.minimalism.bean.dto.LoginUser;
import com.jk.minimalism.bean.entity.Permission;
import com.jk.minimalism.interceptor.LogAnnotation;
import com.jk.minimalism.service.PermissionService;
import com.jk.minimalism.util.UserUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 权限相关接口
 * 
 * @author jiaokai
 *
 */
@Api(tags = "权限")
@RestController
@RequestMapping("/permissions")
public class PermissionController {

	@Autowired
	private PermissionService permissionService;

	@ApiOperation(value = "当前登录用户拥有的权限")
	@GetMapping("/current")
	public List<Permission> permissionsCurrent() {
		LoginUser loginUser = UserUtil.getLoginUser();
		List<Permission> list = loginUser.getPermissions();
		final List<Permission> permissions = list.stream().filter(l -> l.getType().equals(1))
				.collect(Collectors.toList());

        List<Permission> firstLevel = permissions.stream().filter(p -> p.getParentId().equals(0L)).collect(Collectors.toList());
        firstLevel.parallelStream().forEach(p -> setChild(p, permissions));

        return firstLevel;
	}

	/**
	 * 设置子元素
	 * 2018.06.09
	 */
	private void setChild(Permission p, List<Permission> permissions) {
		List<Permission> child = permissions.parallelStream().filter(a -> a.getParentId().equals(p.getId())).collect(Collectors.toList());
		p.setChild(child);
		if (!CollectionUtils.isEmpty(child)) {
			child.parallelStream().forEach(c -> {
				//递归设置子元素，多级菜单支持
				setChild(c, permissions);
			});
		}
	}

	/**
	 * 菜单列表
	 */
	private void setPermissionsList(Long pId, List<Permission> permissionsAll, List<Permission> list) {
		for (Permission per : permissionsAll) {
			if (per.getParentId().equals(pId)) {
				list.add(per);
				if (permissionsAll.stream().anyMatch(p -> p.getParentId().equals(per.getId()))) {
					setPermissionsList(per.getId(), permissionsAll, list);
				}
			}
		}
	}

	@GetMapping
	@ApiOperation(value = "菜单列表")
	@PreAuthorize("hasAuthority('sys:menu:query')")
	public List<Permission> permissionsList() {
		List<Permission> permissionsAll = permissionService.listAll();

		List<Permission> list = Lists.newArrayList();
		setPermissionsList(0L, permissionsAll, list);

		return list;
	}

	@GetMapping("/all")
	@ApiOperation(value = "所有菜单")
	@PreAuthorize("hasAuthority('sys:menu:query')")
	public JSONArray permissionsAll() {
		List<Permission> permissionsAll = permissionService.listAll();
		JSONArray array = new JSONArray();
		setPermissionsTree(0L, permissionsAll, array);

		return array;
	}

	@GetMapping("/parents")
	@ApiOperation(value = "一级菜单")
	@PreAuthorize("hasAuthority('sys:menu:query')")
	public List<Permission> parentMenu() {
		return permissionService.listParents();
	}

	/**
	 * 菜单树
	 */
	private void setPermissionsTree(Long pId, List<Permission> permissionsAll, JSONArray array) {
		for (Permission per : permissionsAll) {
			if (per.getParentId().equals(pId)) {
				String string = JSONObject.toJSONString(per);
				JSONObject parent = (JSONObject) JSONObject.parse(string);
				array.add(parent);

				if (permissionsAll.stream().anyMatch(p -> p.getParentId().equals(per.getId()))) {
					JSONArray child = new JSONArray();
					parent.put("child", child);
					setPermissionsTree(per.getId(), permissionsAll, child);
				}
			}
		}
	}

	@GetMapping(params = "roleId")
	@ApiOperation(value = "根据角色id获取权限")
	@PreAuthorize("hasAnyAuthority('sys:menu:query','sys:role:query')")
	public List<Permission> listByRoleId(Long roleId) {
		return permissionService.listByRoleId(roleId);
	}

	@LogAnnotation
	@PostMapping
	@ApiOperation(value = "保存菜单")
	@PreAuthorize("hasAuthority('sys:menu:add')")
	public void save(@RequestBody Permission permission) {
		permissionService.save(permission);
	}

	@GetMapping("/{id}")
	@ApiOperation(value = "根据菜单id获取菜单")
	@PreAuthorize("hasAuthority('sys:menu:query')")
	public Permission get(@PathVariable Long id) {
		return permissionService.getById(id);
	}

	@LogAnnotation
	@PutMapping
	@ApiOperation(value = "修改菜单")
	@PreAuthorize("hasAuthority('sys:menu:add')")
	public void update(@RequestBody Permission permission) {
		permissionService.update(permission);
	}

	/**
	 * 校验权限
	 */
	@GetMapping("/owns")
	@ApiOperation(value = "校验当前用户的权限")
	public Set<String> ownsPermission() {
		List<Permission> permissions = UserUtil.getLoginUser().getPermissions();
		if (CollectionUtils.isEmpty(permissions)) {
			return Collections.emptySet();
		}

		return permissions.parallelStream().filter(p -> !StringUtils.isEmpty(p.getPermission()))
				.map(Permission::getPermission).collect(Collectors.toSet());
	}

	@LogAnnotation
	@DeleteMapping("/{id}")
	@ApiOperation(value = "删除菜单")
	@PreAuthorize("hasAuthority('sys:menu:del')")
	public void delete(@PathVariable Long id) {
		permissionService.delete(id);
	}
}
