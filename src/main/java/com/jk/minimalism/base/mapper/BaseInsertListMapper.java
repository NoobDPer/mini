package com.jk.minimalism.base.mapper;

import com.jk.minimalism.base.provider.BaseSpecialProvider;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Options;

import java.util.Collection;

/**
 * 批量插入
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/06/21
 */
@tk.mybatis.mapper.annotation.RegisterMapper
public interface BaseInsertListMapper<T> {

    @Options
    @InsertProvider(type = BaseSpecialProvider.class, method = "dynamicSQL")
    int insertList(Collection<T> recordList);

}
