package com.jk.minimalism.dao;


import com.jk.minimalism.base.mapper.BaseMapper;
import com.jk.minimalism.bean.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoleMapper extends BaseMapper<Role> {

    int save(Role role);

    int count(@Param("params") Map<String, Object> params);

    List<Role> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset,
                    @Param("limit") Integer limit);

    Role getById(@Param("id") Long id);

    Role getRole(@Param("name") String name);

    int update(Role role);

    List<Role> listByUserId(@Param("userId") Long userId);

    int deleteRolePermission(@Param("roleId") Long roleId);

    int saveRolePermission(@Param("roleId") Long roleId, @Param("permissionIds") List<Long> permissionIds);

    int deleteById(@Param("id") Long id);

    int deleteRoleUser(@Param("roleId") Long roleId);

}