package com.jk.minimalism.bean.entity;

import lombok.Data;
import org.springframework.data.annotation.Transient;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.List;

@Data
@Table(name = "sys_permission")
public class Permission implements Serializable {
    /**
     * 角色ID
     */
    @Id
    @Column(name = "ID")
    private Long id;

    /**
     * 上级权限ID
     */
    @Column(name = "PARENT_ID")
    private Long parentId;

    /**
     * 权限名称
     */
    @Column(name = "NAME")
    private String name;

    /**
     * 样式
     */
    @Column(name = "CSS")
    private String css;

    /**
     * 路由路径
     */
    @Column(name = "HREF")
    private String href;

    /**
     * 菜单类型
     */
    @Column(name = "TYPE")
    private Integer type;

    /**
     * 权限描述符
     */
    @Column(name = "PERMISSION")
    private String permission;

    /**
     * 排序
     */
    @Column(name = "SORT")
    private Integer sort;

    @Transient
    private List<Permission> child;

}