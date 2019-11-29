package com.jk.minimalism.bean.enums;

import com.jk.minimalism.bean.dto.BeanCommonMap;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author admin-jk
 * @date 19-11-29
 */
public enum ContentSource {
    /** 管理平台管理员 */
    WEB_BACK("0", "管理平台管理员"),
    /** 网友提供 */
    WEB_FRONT("1", "网友提供"),
    /** 微信小程序 */
    WE_CHAT("2", "微信小程序"),;

    @Getter
    private String source;

    @Getter
    private String desc;

    ContentSource(String source, String desc) {
        this.source = source;
        this.desc = desc;
    }

    public static List<BeanCommonMap> getCommonMap() {
        return Stream.of(ContentSource.values()).map(value -> BeanCommonMap.builder().code(value.getSource()).data(value.getDesc()).build()).collect(Collectors.toList());
    }

}
