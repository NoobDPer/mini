package com.jk.minimalism.service.impl;

import com.jk.minimalism.util.IdUtils;
import com.jk.minimalism.dao.BizContentDao;
import com.jk.minimalism.bean.entity.BizContent;
import com.jk.minimalism.service.BizContentService;
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
public class BizContentServiceImpl implements BizContentService {
    private final BizContentDao bizcontentdao;

    @Autowired
    public BizContentServiceImpl(BizContentDao bizcontentdao) {
        this.bizcontentdao = bizcontentdao;
    }

    @Override
    public BizContent saveBizContent(BizContent bizcontent) {

        bizcontent.setId(IdUtils.nextId());
        bizcontentdao.save(bizcontent);
        return bizcontent;
    }

    @Override
    public BizContent getById(Long id) {
        return bizcontentdao.getById(id);
    }

    @Override
    public BizContent update(BizContent bizcontent) {
        bizcontentdao.update(bizcontent);
        return bizcontent;
    }

    @Override
    public void delete(Long id) {
        bizcontentdao.delete(id);
    }

    @Override
    public int count(Map<String, Object> params) {
        return bizcontentdao.count(params);
    }

    @Override
    public List<BizContent> list(Map<String, Object> params, Integer offset, Integer limit) {
        return bizcontentdao.list(params, offset, limit);
    }
}
