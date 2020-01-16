package com.jk.minimalism.dao;

import com.jk.minimalism.base.mapper.BaseMapper;
import com.jk.minimalism.bean.entity.BizContentDetail;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author auto-generate
 */
@Repository
public interface BizContentDetailMapper extends BaseMapper<BizContentDetail> {

    int batchSave(@Param("list") List<BizContentDetail> list);

    int deleteByContentId(@Param("id") Long id);

    List<BizContentDetail> selectByContentId(@Param("id") Long id);

}
