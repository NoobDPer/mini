package com.jk.minimalism.bean.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "sys_role_permission")
public class RolePermission {
    /**
     * 角色ID
     */
    @Id
    @Column(name = "ROLE_ID")
    private Integer roleId;

    /**
     * 权限ID
     */
    @Id
    @Column(name = "PERMISSION_ID")
    private Integer permissionId;

}