package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.dto.BizContentDetailDTO;
import com.jk.minimalism.bean.dto.DetailSaveReqDTO;
import com.jk.minimalism.bean.entity.BizContent;
import com.jk.minimalism.bean.entity.BizContentDetail;
import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.dao.BizContentMapper;
import com.jk.minimalism.dao.BizContentDetailMapper;
import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import com.jk.minimalism.service.BizContentDetailService;
import com.jk.minimalism.util.IdUtils;
import org.apache.commons.collections4.CollectionUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author auto-generate
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class BizContentDetailServiceImpl implements BizContentDetailService {
    private final BizContentDetailMapper bizContentDetailMapper;

    private final BizContentMapper bizContentMapper;

    private final ModelMapper modelMapper;

    @Autowired
    public BizContentDetailServiceImpl(BizContentDetailMapper bizContentDetailMapper,
                                       BizContentMapper bizContentMapper,
                                       @Lazy ModelMapper modelMapper) {
        this.bizContentDetailMapper = bizContentDetailMapper;
        this.bizContentMapper = bizContentMapper;
        this.modelMapper = modelMapper;
    }


    @Override
    public void batchSaveDetails(DetailSaveReqDTO reqDTO) {
        BizContent bizContent = bizContentMapper.getById(reqDTO.getId());
        if (Objects.isNull(bizContent)) {
            throw new MinimalismBizRuntimeException(ResultCode.PARAM_ERROR, "内容不存在");
        }
        if (CollectionUtils.isEmpty(reqDTO.getList())) {
            return;
        }
        bizContentDetailMapper.deleteByContentId(reqDTO.getId());
        List<BizContentDetail> list = reqDTO.getList().stream().map(d -> modelMapper.map(d, BizContentDetail.class)).collect(Collectors.toList());
        for (int i = 0; i < list.size(); i++) {
            list.get(i).setId(IdUtils.nextId());
            list.get(i).setContentId(reqDTO.getId());
            list.get(i).setOrder(i + 1);
        }
        bizContentDetailMapper.batchSave(list);
    }

    @Override
    public List<BizContentDetailDTO> getDetailsById(Long id) {
        return bizContentDetailMapper.selectByContentId(id).stream().map(d -> modelMapper.map(d, BizContentDetailDTO.class)).collect(Collectors.toList());
    }
}
