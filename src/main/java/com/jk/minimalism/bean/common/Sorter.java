package com.jk.minimalism.bean.common;

import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.constraint.VStringIn;
import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import com.jk.minimalism.util.MapperColumnUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.apache.commons.collections4.CollectionUtils;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;

/**
 * 排序参数
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/08/12
 */
@Data
public class Sorter {

    /**
     * 排序字段名称
     */
    @NotBlank
    @ApiModelProperty("排序字段名称")
    private String name;

    /**
     * ASC DESC
     */
    @NotNull
    @VStringIn(in = {"ASC", "DESC"})
    @ApiModelProperty("ASC, DESC")
    private String direction;

    /**
     * 设置排序参数
     *
     * @param otherNames 其他支持的排序参数
     * @param mapper     mapper类
     * @param resultMaps 数据库字段和对象属性映射map
     */
    public void buildName(List<String> otherNames, Class<?> mapper, String... resultMaps) {
        Map<String, String> proColumnMap = MapperColumnUtil.getColumnPro(mapper, resultMaps);
        if (CollectionUtils.isNotEmpty(otherNames)) {
            for (String otherName : otherNames) {
                proColumnMap.put(otherName, otherName);
            }
        }
        if (!proColumnMap.containsKey(name)) {
            throw new MinimalismBizRuntimeException(ResultCode.PARAM_ERROR, "排序参数不合法");
        }
        this.setName(proColumnMap.get(name));
        this.setDirection(direction);
    }

    /**
     * 设置排序参数
     *
     * @param mapper     mapper类
     * @param resultMaps 数据库字段和对象属性映射map
     */
    public void buildName(Class<?> mapper, String... resultMaps) {
        buildName(null, mapper, resultMaps);
    }

    /**
     * 设置排序参数
     *
     * @param otherNames 其他支持的排序参数
     * @param mapper     mapper类
     * @param resultMaps 数据库字段和对象属性映射map
     * @param otherOrderParam 为解决排序查询时不幂等追加的参数
     * @param addOtherOrderParam 是否需要追加该排序参数
     */
    public void buildName(List<String> otherNames, Class<?> mapper, String otherOrderParam, Boolean addOtherOrderParam, String... resultMaps) {
        buildName(otherNames, mapper, resultMaps);
        if (addOtherOrderParam) {
            this.setName(name + " " + direction);
            this.setDirection(", " + otherOrderParam + " DESC");
        }
    }


    public static String generateOrderBy(String name, String direction) {
        return String.format(" ORDER BY %s %s",
                name,
                direction);
    }

}
