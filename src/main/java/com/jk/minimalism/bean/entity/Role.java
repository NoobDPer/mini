package com.jk.minimalism.bean.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "sys_role")
public class Role {
    @Id
    @Column(name = "ID")
    private Long id;

    /**
     * 角色名称
     */
    @Column(name = "NAME")
    private String name;

    /**
     * 描述
     */
    @Column(name = "DESCRIPTION")
    private String description;

}