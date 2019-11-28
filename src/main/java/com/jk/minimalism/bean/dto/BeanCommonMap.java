package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author admin-jk
 * @date 19-11-28
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(value = "下拉列表公共返回对象")
public class BeanCommonMap {

    @ApiModelProperty(value = "编码")
    private String code;

    @ApiModelProperty(value = "值")
    private String data;

}
