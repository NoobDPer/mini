package com.jk.minimalism.bean.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jk.minimalism.bean.common.UserAndTimeAttrAdapter;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Data
@Table(name = "sys_user")
public class User implements UserAndTimeAttrAdapter {
    /**
     * 用户ID
     */
    @Id
    @Column(name = "ID")
    private Long id;

    /**
     * 用户名
     */
    @Column(name = "USERNAME")
    private String username;

    /**
     * 密码
     */
    @Column(name = "PASSWORD")
    @JsonIgnore
    private String password;

    /**
     * 姓名
     */
    @Column(name = "NICKNAME")
    private String nickname;

    /**
     * 手机号
     */
    @Column(name = "PHONE")
    private String phone;

    /**
     * 当次登录时间
     */
    @Column(name = "CURRENT_LOGIN_TIME")
    private Date currentLoginTime;

    /**
     * 上次登录时间
     */
    @Column(name = "LAST_LOGIN_TIME")
    private Date lastLoginTime;

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
     * 1:启用 0:停用
     */
    @Column(name = "STATE")
    private Integer state;

    public interface Status {
        int VALID = 1;
        int DISABLED = 0;
        int FROZEN = -1;
    }
}