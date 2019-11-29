package com.jk.minimalism.bean.dto;

import com.jk.minimalism.constraint.VStringIn;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @author admin-jk
 * @date 19-11-29
 */
@Data
public class BizContentOpenDTO {

    @ApiModelProperty(value = "类型")
    @NotNull
    @VStringIn(in = {"1", "2", "3", "4", "5"})
    private String type;

    @ApiModelProperty(value = "中文内容")
    @NotNull
    private String contentCn;

    @ApiModelProperty(value = "英文内容")
    private String contentEn;

    @ApiModelProperty(value = "提交人QQ")
    private String commitQq;

    @ApiModelProperty(value = "是否同意展示QQ 1-同意 0-不同意")
    private String showQqState;

    @ApiModelProperty(value = "来源")
    @NotNull
    @VStringIn(in = {"0", "1", "2",})
    private String source;

}
