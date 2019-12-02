package com.jk.minimalism.bean.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * Created by admin on 2019/12/2.
 */

@Data
@ApiModel(value = "外部接口内容返回对象")
public class BizContentOpenResponseDTO {

    @ApiModelProperty(value = "中文内容")
    private String contentCn;

    @ApiModelProperty(value = "提交人QQ")
    private String commitQq;

}
