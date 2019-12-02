package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.dto.BizContentDTO;
import com.jk.minimalism.bean.dto.BizContentOpenRequestDTO;
import com.jk.minimalism.bean.enums.ConfirmStatus;
import com.jk.minimalism.bean.enums.ContentSource;
import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import com.jk.minimalism.util.BeanFillUtils;
import com.jk.minimalism.util.IdUtils;
import com.jk.minimalism.dao.BizContentMapper;
import com.jk.minimalism.bean.entity.BizContent;
import com.jk.minimalism.service.BizContentService;
import com.jk.minimalism.util.UserUtil;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @author auto-generate
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BizContentServiceImpl implements BizContentService {

    private final BizContentMapper bizContentMapper;

    private final ModelMapper modelMapper;

    @Autowired
    public BizContentServiceImpl(BizContentMapper bizContentMapper,@Lazy ModelMapper modelMapper) {
        this.bizContentMapper = bizContentMapper;
        this.modelMapper = modelMapper;
    }

    @Override
    public BizContent saveBizContent(BizContentDTO bizContentDTO) {
        BizContent bizContent = modelMapper.map(bizContentDTO, BizContent.class);
        long userId = UserUtil.getUserId();
        Date now = new Date();
        bizContent.setConfirmUser(userId);
        bizContent.setConfirmTime(now);
        if (Objects.nonNull(bizContent.getId())) {
            // 更新
            BeanFillUtils.setUpdateAttr(bizContent, userId);
            bizContentMapper.updateByPrimaryKey(bizContent);
        } else {
            // 新增
            bizContent.setId(IdUtils.nextId());
            bizContent.setSource(ContentSource.WEB_BACK.getSource());
            BeanFillUtils.setCreateAttr(bizContent, userId);
            bizContentMapper.insertSelective(bizContent);
        }
        // TODO SAVE CONFIRM LOGS
        return bizContent;
    }

    @Override
    public void saveBizContent4forOpen(BizContentOpenRequestDTO bizContentOpenRequestDTO) {
        BizContent bizContent = modelMapper.map(bizContentOpenRequestDTO, BizContent.class);
        bizContent.setConfirmState(ConfirmStatus.NOT_CONFIRMED.getCode());
        BeanFillUtils.setCreateAttr(bizContent);
        bizContentMapper.insertSelective(bizContent);
    }

    @Override
    public BizContent getById(Long id) {
        return bizContentMapper.getById(id);
    }

    @Override
    public BizContent update(BizContent bizcontent) {
        bizContentMapper.update(bizcontent);
        return bizcontent;
    }

    @Override
    public void delete(Long id) {
        bizContentMapper.deleteById(id);
    }

    @Override
    public int count(Map<String, Object> params) {
        return bizContentMapper.count(params);
    }

    @Override
    public List<BizContent> list(Map<String, Object> params, Integer offset, Integer limit) {
        return bizContentMapper.list(params, offset, limit);
    }

    @Override
    public void batchConfirmBizContent(List<Long> ids, String state) {
        bizContentMapper.batchUpdateState(ids, state, UserUtil.getUserId());
        // TODO SAVE CONFIRM LOGS
    }

    @Override
    public void confirmBizContent(Long id, String state) {
        bizContentMapper.batchUpdateState(Collections.singletonList(id), state, UserUtil.getUserId());
        // TODO SAVE CONFIRM LOGS
    }

    @Override
    public BizContent randomOneBizContent(String type) {
        int totalCount = bizContentMapper.countByType(type);
        if (totalCount < 1) {
            throw new MinimalismBizRuntimeException(ResultCode.NO_DATA_TO_SHOW_ERROR);
        }
        int offset = (int) (Math.random()*(totalCount));
        return bizContentMapper.getByTypeAndLimit(type, offset);
    }
}
