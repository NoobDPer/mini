package com.jk.minimalism.dao;

import com.jk.minimalism.base.mapper.BaseMapper;
import com.jk.minimalism.bean.entity.BizContent;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
public interface BizContentMapper extends BaseMapper<BizContent> {

    @Select("select * from biz_content t where t.id = #{id}")
    BizContent getById(Long id);

    @Delete("delete from biz_content where id = #{id}")
    int deleteById(Long id);

    int update(BizContent bizcontent);
    
    @Options(useGeneratedKeys = true, keyProperty = "id")
    @Insert("insert into biz_content(ID, TYPE, CONTENT_CN, CONTENT_EN, COMMIT_QQ, SHOW_QQ_STATE, SOURCE, CONFIRM_STATE, CONFIRM_USER, CONFIRM_TIME, CREATE_TIME, CREATE_USER, UPDATE_TIME, UPDATE_USER) values(#{id}, #{type}, #{contentCn}, #{contentEn}, #{commitQq}, #{showQqState}, #{source}, #{confirmState}, #{confirmUser}, #{confirmTime}, #{createTime}, #{createUser}, #{updateTime}, #{updateUser})")
    int save(BizContent bizcontent);
    
    int count(@Param("params") Map<String, Object> params);

    List<BizContent> list(@Param("params") Map<String, Object> params, @Param("offset") Integer offset, @Param("limit") Integer limit);

    int batchUpdateState(@Param("ids") List<Long> ids, @Param("state") String state, @Param("updateUser") Long updateUser);
}
