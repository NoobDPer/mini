package com.jk.minimalism.bean.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * @author auto-generate
 */
@Data
@Table(name = "biz_content_detail")
public class BizContentDetail {

	/**
	* ID
	*/
	@Id
	@Column(name = "ID")
	private Long id;

	/**
	* 内容ID
	*/
	@Column(name = "CONTENT_ID")
	private Long contentId;

	/**
	* 明细ID
	*/
	@Column(name = "CONTENT")
	private String content;

	/**
	* 顺序
	*/
	@Column(name = "ORDER")
	private Integer order;



}
