package com.jk.minimalism.bean.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "sys_user_role")
public class UserRole {
    /**
     * 用户ID
     */
    @Id
    @Column(name = "USER_ID")
    private Long userId;

    /**
     * 角色ID
     */
    @Id
    @Column(name = "ROLE_ID")
    private Integer roleId;

}