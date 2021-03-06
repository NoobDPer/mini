package com.jk.minimalism.dao;

import com.jk.minimalism.base.mapper.BaseMapper;
import com.jk.minimalism.bean.entity.BizConfirmLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
@Mapper
@Repository
public interface BizConfirmLogMapper extends BaseMapper<BizConfirmLog> {

    int count(@Param("params") Map<String, Object> params);

    List<BizConfirmLog> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset, @Param("limit") Integer limit);

}
