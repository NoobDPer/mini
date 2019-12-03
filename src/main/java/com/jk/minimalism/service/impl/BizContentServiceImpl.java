package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.dto.BizContentDTO;
import com.jk.minimalism.bean.dto.BizContentOpenRequestDTO;
import com.jk.minimalism.bean.dto.BizContentResponseDTO;
import com.jk.minimalism.bean.entity.BizConfirmLog;
import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.bean.enums.ConfirmStatus;
import com.jk.minimalism.bean.enums.ContentSource;
import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.dao.BizConfirmLogMapper;
import com.jk.minimalism.dao.UserMapper;
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
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author auto-generate
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BizContentServiceImpl implements BizContentService {

    private final BizContentMapper bizContentMapper;

    private final ModelMapper modelMapper;

    private final BizConfirmLogMapper bizConfirmLogMapper;

    private final UserMapper userMapper;

    @Autowired
    public BizContentServiceImpl(BizContentMapper bizContentMapper,
                                 BizConfirmLogMapper bizConfirmLogMapper,
                                 @Lazy ModelMapper modelMapper,
                                 UserMapper userMapper) {
        this.bizContentMapper = bizContentMapper;
        this.bizConfirmLogMapper = bizConfirmLogMapper;
        this.modelMapper = modelMapper;
        this.userMapper = userMapper;
    }

    @Override
    public BizContent saveBizContent(BizContentDTO bizContentDTO) {
        BizContent bizContent = modelMapper.map(bizContentDTO, BizContent.class);
        long userId = UserUtil.getUserId();
        Date now = new Date();
        bizContent.setConfirmUser(userId);
        bizContent.setConfirmTime(now);
        String originState;
        if (Objects.nonNull(bizContent.getId())) {
            // 更新
            BeanFillUtils.setUpdateAttr(bizContent, userId);
            BizContent originBizContent = bizContentMapper.getById(bizContent.getId());
            originState = originBizContent.getConfirmState();
            bizContentMapper.updateByPrimaryKey(bizContent);
        } else {
            // 新增
            bizContent.setId(IdUtils.nextId());
            bizContent.setSource(ContentSource.WEB_BACK.getSource());
            BeanFillUtils.setCreateAttr(bizContent, userId);
            originState = ConfirmStatus.NOT_CONFIRMED.getCode();
            bizContentMapper.insertSelective(bizContent);
        }

        // 保存审核记录日志
        BizConfirmLog bizConfirmLog = BizConfirmLog.builder()
                .id(IdUtils.nextId())
                .contentId(bizContent.getId())
                .confirmUser(userId)
                .confirmTime(now)
                .confirmStateOrigin(originState)
                .confirmStateNew(bizContent.getConfirmState())
                .build();
        bizConfirmLogMapper.insertSelective(bizConfirmLog);
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
    public List<BizContentResponseDTO> list(Map<String, Object> params, Integer offset, Integer limit) {
        List<BizContent> bizContents = bizContentMapper.list(params, offset, limit);
        List<Long> userIds = bizContents.stream().map(BizContent::getConfirmUser).distinct().collect(Collectors.toList());
        List<User> users = userMapper.selectByIds(userIds);
        Map<Long, String> userIdNicknameMap = users.stream().collect(Collectors.toMap(User::getId, User::getNickname));
        return bizContents.stream().map(c -> {
            BizContentResponseDTO result = modelMapper.map(c, BizContentResponseDTO.class);
            result.setConfirmUsername(userIdNicknameMap.get(c.getConfirmUser()));
            return result;
        }).collect(Collectors.toList());
    }

    @Override
    public void batchConfirmBizContent(List<Long> ids, String state) {
        if (CollectionUtils.isEmpty(ids)) {
            return;
        }
        // 批量修改审核状态
        Long userId = UserUtil.getUserId();
        bizContentMapper.batchUpdateState(ids, state, userId);
        // 保存状态变更日志
        List<BizContent> bizContents = bizContentMapper.listByIds(ids);
        Map<Long, String> bizContentIdStateMap = bizContents.stream().collect(Collectors.toMap(BizContent::getId, BizContent::getConfirmState));
        List<BizConfirmLog> insertLogList = new ArrayList<>(ids.size());
        Date now = new Date();
        for (Map.Entry<Long, String> entry : bizContentIdStateMap.entrySet()) {
            insertLogList.add(BizConfirmLog.builder()
                    .id(IdUtils.nextId())
                    .contentId(entry.getKey())
                    .confirmUser(userId)
                    .confirmTime(now)
                    .confirmStateOrigin(entry.getValue())
                    .confirmStateNew(state)
                    .build());
        }
        bizConfirmLogMapper.insertList(insertLogList);
    }

    @Override
    public void confirmBizContent(Long id, String state) {
        if (Objects.isNull(id)) {
            return;
        }
        // 修改审核状态
        Long userId = UserUtil.getUserId();
        bizContentMapper.batchUpdateState(Collections.singletonList(id), state, userId);
        // 保存状态变更日志
        BizContent originBizContent = bizContentMapper.getById(id);
        BizConfirmLog bizConfirmLog = BizConfirmLog.builder()
                .id(IdUtils.nextId())
                .contentId(id)
                .confirmUser(userId)
                .confirmTime(new Date())
                .confirmStateOrigin(originBizContent.getConfirmState())
                .confirmStateNew(state)
                .build();
        bizConfirmLogMapper.insertSelective(bizConfirmLog);
    }

    @Override
    public BizContent randomOneBizContent(String type) {
        int totalCount = bizContentMapper.countByType(type);
        if (totalCount < 1) {
            throw new MinimalismBizRuntimeException(ResultCode.NO_DATA_TO_SHOW_ERROR);
        }
        int offset = (int) (Math.random() * (totalCount));
        return bizContentMapper.getByTypeAndLimit(type, offset);
        // TODO record hits
    }
}
