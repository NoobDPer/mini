package com.jk.minimalism.bean.enums;

import com.jk.minimalism.bean.dto.BeanCommonMap;
import lombok.Getter;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author admin-jk
 * @date 19-12-6
 */
public enum UserStatus {

    /** 启用 */
    VALID(1, "启用"),
    /** 停用 */
    DISABLED(0, "停用"),
    /** 冻结 */
    FROZEN(-1, "冻结"),;

    @Getter
    private Integer state;

    @Getter
    private String desc;

    UserStatus(Integer state, String desc) {
        this.state = state;
        this.desc = desc;
    }

    public static List<BeanCommonMap> getCommonMap() {
        return Stream.of(UserStatus.values()).map(value -> BeanCommonMap.builder().code(value.getState().toString()).data(value.getDesc()).build()).collect(Collectors.toList());
    }

    public static String getDescByState(Integer state) {
        Optional<UserStatus> userStatus = Stream.of(UserStatus.values()).filter(value -> state.equals(value.getState())).findFirst();
        if (userStatus.isPresent()) {
            return userStatus.get().getDesc();
        }
        return "";
    }
}
