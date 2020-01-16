package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author auto-generate
 */
@Data
public class BizContentDetailDTO implements Serializable {

	@ApiModelProperty(value = "ID")
	private Long id;

	@ApiModelProperty(value = "内容ID")
	private Long contentId;

	@ApiModelProperty(value = "明细ID")
	private String content;

	@ApiModelProperty(value = "顺序")
	private Integer order;



}
