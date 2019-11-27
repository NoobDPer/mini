package com.jk.minimalism.service;

import com.jk.minimalism.bean.entity.BizContent;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
public interface BizContentService {

    BizContent saveBizContent(BizContent bizcontent);

    BizContent getById(Long id);

    BizContent update(BizContent bizcontent);

    void delete(Long id);

    int count(Map<String, Object> params);

    List<BizContent> list(Map<String, Object> params, Integer offset, Integer limit);

    /**
     * 批量更改审核状态
     *
     * @param ids   内容id列表
     * @param state 审核状态 99-不通过 0-未审核 1-待定 2-通过
     */
    void batchConfirmBizContent(List<Long> ids, String state);

    /**
     * 更改审核状态
     *
     * @param id    内容ID
     * @param state 审核状态 99-不通过 0-未审核 1-待定 2-通过
     */
    void confirmBizContent(Long id, String state);

}