package com.jk.minimalism.bean.common;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pager implements Serializable {

    @Min(1)
    @ApiModelProperty("页数, 从1开始")
    private int page = 1;

    @Min(1)
    @ApiModelProperty("每页数据大小")
    private int size = 20;

}
