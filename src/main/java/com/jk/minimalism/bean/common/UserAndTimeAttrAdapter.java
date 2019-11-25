package com.jk.minimalism.bean.common;

import java.util.Date;

/**
 * 创建时间,更新时间,创建用户,更新用户适配器
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/04/29
 */
public interface UserAndTimeAttrAdapter {

    /**
     * 设置创建时间
     *
     * @param createdTime 创建时间
     */
    void setCreateTime(Date createdTime);

    /**
     * 设置更新时间
     *
     * @param updatedTime 更新时间
     */
    void setUpdateTime(Date updatedTime);

    /**
     * 设置创建用户
     *
     * @param createdUser 创建用户
     */
    void setCreateBy(Long createdUser);

    /**
     * 设置更新用户
     *
     * @param updatedUser 更新用户
     */
    void setUpdateBy(Long updatedUser);

}
