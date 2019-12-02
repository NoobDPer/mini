package com.jk.minimalism.service;

import com.jk.minimalism.bean.dto.BizContentDTO;
import com.jk.minimalism.bean.dto.BizContentOpenRequestDTO;
import com.jk.minimalism.bean.entity.BizContent;

import java.util.List;
import java.util.Map;

/**
 * @author auto-generate
 */
public interface BizContentService {

    /**
     * 保存内容
     * @param bizContentDTO 内容对象
     * @return 保存完的内容
     */
    BizContent saveBizContent(BizContentDTO bizContentDTO);

    void saveBizContent4forOpen(BizContentOpenRequestDTO bizContentOpenRequestDTO);

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

    /**
     * 根据类型随机一条内容数据
     * @param type 内容类型 com.jk.minimalism.bean.enums.BizContentType
     */
    BizContent randomOneBizContent(String type);

}
