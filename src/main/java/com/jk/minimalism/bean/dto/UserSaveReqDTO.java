package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author admin-jk
 * @date 19-12-17
 */
@Data
@ApiModel(value = "用户保存对象")
public class UserSaveReqDTO {

    @ApiModelProperty(value = "ID")
    private Long id;

    /**
     * 用户名
     */
    @ApiModelProperty(value = "用户名")
    private String username;

    /**
     * 密码
     */
    @ApiModelProperty(value = "密码")
    private String password;

    /**
     * 姓名
     */
    @ApiModelProperty(value = "姓名")
    private String nickname;

    /**
     * 手机号
     */
    @ApiModelProperty(value = "手机号")
    private String phone;

    /**
     * 角色ID
     */
    @ApiModelProperty(value = "角色ID")
    private Integer roleId;
}
