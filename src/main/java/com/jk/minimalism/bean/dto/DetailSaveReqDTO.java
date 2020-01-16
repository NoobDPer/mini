package com.jk.minimalism.bean.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author admin-jk
 * @date 20-1-16
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DetailSaveReqDTO {

    private Long id;

    private List<BizContentDetailDTO> list;
}
