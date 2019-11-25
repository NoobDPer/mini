package com.jk.minimalism.dao.base;

import tk.mybatis.mapper.common.Mapper;

/**
 * tk基础mapper
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/06
 */
@tk.mybatis.mapper.annotation.RegisterMapper
public interface BaseMapper<T> extends Mapper<T> {

}
