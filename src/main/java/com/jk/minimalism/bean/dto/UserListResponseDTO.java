package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.util.Date;

/**
 * @author admin-jk
 * @date 19-12-6
 */
@Data
@ApiModel(value = "用户列表响应对象")
public class UserListResponseDTO {

    private Long id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 姓名
     */
    private String nickname;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 当次登录时间
     */
    private Date currentLoginTime;

    /**
     * 上次登录时间
     */
    private Date lastLoginTime;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 1:启用 0:停用
     */
    private Integer state;

    /**
     * 状态描述
     */
    private String stateDesc;

    /**
     * 角色名称
     */
    private String roleName;

}
