package com.jk.minimalism.bean.entity;

import com.jk.minimalism.bean.common.UserAndTimeAttrAdapter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * @author auto-generate
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "biz_confirm_log")
public class BizConfirmLog implements Serializable {

    /**
     * ID
     */
    @Id
    @Column(name = "ID")
    private Long id;

    /**
     * 内容ID
     */
    @Column(name = "CONTENT_ID")
    private Long contentId;

    /**
     * 审核人
     */
    @Column(name = "CONFIRM_USER")
    private Long confirmUser;

    /**
     * 审核时间
     */
    @Column(name = "CONFIRM_TIME")
    private Date confirmTime;

    /**
     * 审核前状态
     */
    @Column(name = "CONFIRM_STATE_ORIGIN")
    private String confirmStateOrigin;

    /**
     * 审核完成状态
     */
    @Column(name = "CONFIRM_STATE_NEW")
    private String confirmStateNew;


}
