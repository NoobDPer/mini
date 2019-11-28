package com.jk.minimalism.bean.enums;

import com.jk.minimalism.bean.dto.BeanCommonMap;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


/**
 * @author admin-jk
 * @date 19-11-28
 */
public enum BizContentType {

    /** 毒鸡汤 */
    SOUP("1", "毒鸡汤"),
    /** 土味情话 */
    LOW_LOVE_WORDS("2", "土味情话"),
    /** 艺术现场 */
    ART("3", "艺术现场"),
    /** 三行情诗 */
    LOVE_POEM("4", "三行情诗"),
    /** 刀圈黑话 */
    DOTA_CANT("5", "刀圈黑话"),;

    @Getter
    private String type;

    @Getter
    private String desc;

    BizContentType(String type, String desc) {
        this.type = type;
        this.desc = desc;
    }

    public static List<BeanCommonMap> getCommonMap() {
        return Stream.of(BizContentType.values()).map(value -> BeanCommonMap.builder().code(value.getType()).data(value.getDesc()).build()).collect(Collectors.toList());
    }
}
