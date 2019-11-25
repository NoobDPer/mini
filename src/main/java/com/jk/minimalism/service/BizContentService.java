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

}
