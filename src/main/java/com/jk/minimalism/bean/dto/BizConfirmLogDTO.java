package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author auto-generate
 */
@Data
public class BizConfirmLogDTO implements Serializable {

    @ApiModelProperty(value = "ID")
    private Long id;

    @ApiModelProperty(value = "内容ID")
    private Long contentId;

    @ApiModelProperty(value = "审核人")
    private Long confirmUser;

    @ApiModelProperty(value = "审核时间")
    private Date confirmTime;

    @ApiModelProperty(value = "审核前状态")
    private String confirmStateOrigin;

    @ApiModelProperty(value = "审核完成状态")
    private String confirmStateNew;


}
