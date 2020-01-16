package com.jk.minimalism.dao;

import com.jk.minimalism.base.mapper.BaseMapper;
import com.jk.minimalism.bean.entity.BizContent;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
@Repository
public interface BizContentMapper extends BaseMapper<BizContent> {

    BizContent getById(@Param("id") Long id);

    int deleteById(@Param("id") Long id);

    int update(BizContent bizcontent);
    
    int count(@Param("params") Map<String, Object> params);

    List<BizContent> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset, @Param("limit") Integer limit);

    int batchUpdateState(@Param("ids") List<Long> ids, @Param("state") String state, @Param("updateBy") Long updateUser);

    int countByType(@Param("type") String type);

    BizContent getByTypeAndLimit(@Param("type") String type, @Param("offset") Integer offset);

    List<BizContent> listByIds(@Param("ids") List<Long> ids);
}
