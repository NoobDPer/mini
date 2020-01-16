package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author admin-jk
 * @date 19-12-3
 */
@Data
public class BizContentResponseDTO implements Serializable {

    @ApiModelProperty(value = "ID")
    private Long id;

    @ApiModelProperty(value = "类型")
    private String type;

    @ApiModelProperty(value = "中文内容")
    private String contentCn;

    @ApiModelProperty(value = "英文内容")
    private String contentEn;

    @ApiModelProperty(value = "内容类型 1-单行 2-对话 3-多行")
    private String contentType;

    @ApiModelProperty(value = "提交人QQ")
    private String commitQq;

    @ApiModelProperty(value = "是否同意展示QQ 1-同意 0-不同意")
    private String showQqState;

    @ApiModelProperty(value = "来源")
    private String source;

    @ApiModelProperty(value = "审核状态 99-不通过 0-未审核 1-待定 2-通过 ")
    private String confirmState;

    @ApiModelProperty(value = "审核人")
    private String confirmUsername;

    @ApiModelProperty(value = "审核时间")
    private Date confirmTime;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

}
