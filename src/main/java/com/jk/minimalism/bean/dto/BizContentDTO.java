package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author auto-generate
 */
@Data
public class BizContentDTO implements Serializable {

	@ApiModelProperty(value = "ID")
	private Long id;

	@ApiModelProperty(value = "类型")
	private String type;

	@ApiModelProperty(value = "中文内容")
	private String contentCn;

	@ApiModelProperty(value = "英文内容")
	private String contentEn;

	@ApiModelProperty(value = "提交人QQ")
	private String commitQq;

	@ApiModelProperty(value = "是否同意展示QQ 1-同意 0-不同意")
	private String showQqState;

	@ApiModelProperty(value = "来源")
	private String source;

	@ApiModelProperty(value = "审核状态 99-不通过 0-未审核 1-待定 2-通过 ")
	private String confirmState;

	@ApiModelProperty(value = "审核人")
	private String confirmUser;

	@ApiModelProperty(value = "审核时间")
	private Date confirmTime;

	@ApiModelProperty(value = "创建人")
	private String createUser;

	@ApiModelProperty(value = "更新人")
	private String updateUser;



}
