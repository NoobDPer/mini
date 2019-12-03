package com.jk.minimalism.service;

import com.jk.minimalism.bean.entity.BizConfirmLog;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
public interface BizConfirmLogService {

    int count(Map<String, Object> params);

    List<BizConfirmLog> list(Map<String, Object> params, Integer offset, Integer limit);

}
