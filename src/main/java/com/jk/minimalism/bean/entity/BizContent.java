package com.jk.minimalism.bean.entity;

import com.jk.minimalism.bean.common.UserAndTimeAttrAdapter;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * @author auto-generate
 */
@Data
@Table(name = "biz_content")
public class BizContent implements UserAndTimeAttrAdapter, Serializable {

    /**
     * ID
     */
    @Id
    @Column(name = "ID")
    private Long id;

    /**
     * 类型
     */
    @Column(name = "TYPE")
    private String type;

    /**
     * 中文内容
     */
    @Column(name = "CONTENT_CN")
    private String contentCn;

    /**
     * 英文内容
     */
    @Column(name = "CONTENT_EN")
    private String contentEn;

    /**
     * 提交人QQ
     */
    @Column(name = "COMMIT_QQ")
    private String commitQq;

    /**
     * 是否同意展示QQ 1-同意 0-不同意
     */
    @Column(name = "SHOW_QQ_STATE")
    private String showQqState;

    /**
     * 来源
     */
    @Column(name = "SOURCE")
    private String source;

    /**
     * 审核状态 99-不通过 0-未审核 1-待定 2-通过
     */
    @Column(name = "CONFIRM_STATE")
    private String confirmState;

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
     * 创建时间
     */
    @Column(name = "CREATE_TIME")
    private Date createTime;

    /**
     * 创建人
     */
    @Column(name = "CREATE_BY")
    private Long createBy;

    /**
     * 更新时间
     */
    @Column(name = "UPDATE_TIME")
    private Date updateTime;

    /**
     * 更新人
     */
    @Column(name = "UPDATE_BY")
    private Long updateBy;

    public interface CONFIRM_STATE {
        /**
         * 99-不通过
         */
        String NOT_PASSED = "99";

        /**
         * 0-未审核
         */
        String NOT_CONFIRMED = "0";

        /**
         * 1-待定
         */
        String TO_CONFIRM = "1";

        /**
         * 2-通过
         */
        String PASSED = "2";
    }

}
