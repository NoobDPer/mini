package com.jk.minimalism.util;

import com.jk.minimalism.bean.common.UserAndTimeAttrAdapter;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 补充bean对象的一些公共方法
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/04/29
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class BeanFillUtils {

    /**
     * 设置创建属性
     *
     * @param adapter 属性适配器
     * @param userId  用户id
     */
    public static void setCreateAttr(UserAndTimeAttrAdapter adapter, long userId) {
        Date date = new Date();
        adapter.setCreateTime(date);
        adapter.setUpdateTime(date);
        adapter.setCreateBy(userId);
        adapter.setUpdateBy(userId);
    }

    /**
     * 设置创建属性, 用户为当前请求用户
     *
     * @param adapter 属性适配器
     */
    public static void setCreateAttr(UserAndTimeAttrAdapter adapter) {
        setCreateAttr(adapter, getUserId());
    }

    /**
     * 设置更新属性
     *
     * @param adapter 属性适配器
     * @param userId  用户id
     */
    public static void setUpdateAttr(UserAndTimeAttrAdapter adapter, long userId) {
        Date date = new Date();
        adapter.setUpdateTime(date);
        adapter.setUpdateBy(userId);
    }

    /**
     * 设置更新属性, 用户为当前请求用户
     *
     * @param adapter 属性适配器
     */
    public static void setUpdateAttr(UserAndTimeAttrAdapter adapter) {
        setUpdateAttr(adapter, getUserId());
    }

    /**
     * 设置用户id
     *
     * @param adapter 属性适配器
     */
    public static void setUserId(UserAndTimeAttrAdapter adapter) {
        long userId = getUserId();
        adapter.setUpdateBy(userId);
        adapter.setCreateBy(userId);
    }

    private static long getUserId() {
       return UserUtil.getUserId();
    }
}
