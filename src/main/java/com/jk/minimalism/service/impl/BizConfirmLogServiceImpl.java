package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.entity.BizConfirmLog;
import com.jk.minimalism.dao.BizConfirmLogMapper;
import com.jk.minimalism.service.BizConfirmLogService;
import com.jk.minimalism.util.IdUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BizConfirmLogServiceImpl implements BizConfirmLogService {
    private final BizConfirmLogMapper bizConfirmLogMapper;

    @Autowired
    public BizConfirmLogServiceImpl(BizConfirmLogMapper bizConfirmLogMapper) {
        this.bizConfirmLogMapper = bizConfirmLogMapper;
    }

    @Override
    public int count(Map<String, Object> params) {
        return bizConfirmLogMapper.count(params);
    }

    @Override
    public List<BizConfirmLog> list(Map<String, Object> params, Integer offset, Integer limit) {
        return bizConfirmLogMapper.list(params, offset, limit);
    }
}
