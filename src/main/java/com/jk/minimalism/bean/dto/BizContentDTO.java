package com.jk.minimalism.bean.dto;

import com.jk.minimalism.constraint.VStringIn;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * @author auto-generate
 */
@Data
public class BizContentDTO implements Serializable {

    @ApiModelProperty(value = "ID")
    private Long id;

    @ApiModelProperty(value = "类型")
    @NotNull
    @VStringIn(in = {"1", "2", "3", "4", "5"})
    private String type;

    @ApiModelProperty(value = "中文内容")
    @NotNull
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
    @NotNull
    @VStringIn(in = {"0", "1", "2",})
    private String source;

    @ApiModelProperty(value = "审核状态 99-不通过 0-未审核 1-待定 2-通过 ")
    @NotNull
    @VStringIn(in = {"99", "0", "1", "2"})
    private String confirmState;

    private List<BizContentDetailDTO> list;

}
