package com.jk.minimalism.service;

import com.jk.minimalism.bean.dto.BizContentDetailDTO;
import com.jk.minimalism.bean.dto.DetailSaveReqDTO;
import com.jk.minimalism.bean.entity.BizContentDetail;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
public interface BizContentDetailService {

    /**
     * 批量保存明细数据
     * @param reqDTO 明细数据
     */
    void batchSaveDetails(DetailSaveReqDTO reqDTO);

    /**
     *
     * @param id 内容ID
     * @return 明细数据
     */
    List<BizContentDetailDTO> getDetailsById(Long id);

}
