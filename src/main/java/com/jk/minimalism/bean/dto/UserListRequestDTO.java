package com.jk.minimalism.bean.dto;

import com.jk.minimalism.bean.common.Pager;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author admin-jk
 * @date 19-12-6
 */
@Data
@ApiModel(value = "用户列表请求对象")
public class UserListRequestDTO {

    @ApiModelProperty(value = "模糊查询条件")
    private String condition;

    @ApiModelProperty(value = "模糊查询条件")
    private String roleId;

    @ApiModelProperty(value = "状态标识")
    private Integer state;

    private Pager pager;
}
