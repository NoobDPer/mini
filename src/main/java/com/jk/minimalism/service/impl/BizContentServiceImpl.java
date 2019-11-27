package com.jk.minimalism.service.impl;

import com.jk.minimalism.util.IdUtils;
import com.jk.minimalism.dao.BizContentDao;
import com.jk.minimalism.bean.entity.BizContent;
import com.jk.minimalism.service.BizContentService;
import com.jk.minimalism.util.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BizContentServiceImpl implements BizContentService {
    private final BizContentDao bizContentDao;

    @Autowired
    public BizContentServiceImpl(BizContentDao bizContentDao) {
        this.bizContentDao = bizContentDao;
    }

    @Override
    public BizContent saveBizContent(BizContent bizcontent) {

        bizcontent.setId(IdUtils.nextId());
        bizContentDao.save(bizcontent);
        return bizcontent;
    }

    @Override
    public BizContent getById(Long id) {
        return bizContentDao.getById(id);
    }

    @Override
    public BizContent update(BizContent bizcontent) {
        bizContentDao.update(bizcontent);
        return bizcontent;
    }

    @Override
    public void delete(Long id) {
        bizContentDao.delete(id);
    }

    @Override
    public int count(Map<String, Object> params) {
        return bizContentDao.count(params);
    }

    @Override
    public List<BizContent> list(Map<String, Object> params, Integer offset, Integer limit) {
        return bizContentDao.list(params, offset, limit);
    }

    @Override
    public void batchConfirmBizContent(List<Long> ids, String state) {
        bizContentDao.batchUpdateState(ids, state, UserUtil.getUserId());
        // TODO SAVE CONFIRM LOGS
    }

    @Override
    public void confirmBizContent(Long id, String state) {
        bizContentDao.batchUpdateState(Collections.singletonList(id), state, UserUtil.getUserId());
        // TODO SAVE CONFIRM LOGS
    }
}
