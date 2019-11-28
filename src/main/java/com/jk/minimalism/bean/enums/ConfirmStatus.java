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
public enum ConfirmStatus {

    /** 不通过 */
    NOT_PASSED("99", "不通过"),
    /** 未审核 */
    NOT_CONFIRMED("0", "未审核"),
    /** 待定 */
    TO_CONFIRM("1", "待定"),
    /** 通过 */
    PASSED("2", "通过"),;

    @Getter
    private String code;

    @Getter
    private String desc;

    ConfirmStatus(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static List<BeanCommonMap> getCommonMap() {
        return Stream.of(ConfirmStatus.values()).map(value -> BeanCommonMap.builder().code(value.getCode()).data(value.getDesc()).build()).collect(Collectors.toList());
    }

}
