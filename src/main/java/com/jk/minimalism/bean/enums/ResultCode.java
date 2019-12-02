package com.jk.minimalism.bean.enums;

import lombok.Getter;

/**
 * 定义返回结果的代码以及消息等信息
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
public enum ResultCode {

    /**
     * 成功
     */
    SUCCESS("0", "成功"),

    /**
     * 未知的错误
     */
    ERROR("101", "未知异常"),

    /**
     * 参数错误
     */
    PARAM_ERROR("102", "参数异常"),

    /**
     * 权限异常
     */
    ACCESS_DENIED_ERROR("401", "权限异常"),

    /**
     * 远程调用异常
     */
    ERROR_REMOTE_CALL("103", "远程调用异常"),

    /* --------- 公共错误 -------- */
    NO_DATA_TO_SHOW_ERROR("10001", "尚无数据"),
    /* --------- 公共错误 -------- */


    /* --------- 用户模块错误 -------- */

    /**
     * 用户不存在
     */
    USER_NOT_EXISTS_ERROR("20002", "用户不存在"),

    /**
     * 密码错误
     */
    USER_PASSWORD_ERROR("20003", "原密码错误，请重新输入"),

    /**
     * 用户名已经存在
     */
    USER_USERNAME_EXISTS_ERROR("20004", "该手机号已绑定其他账号，请更换其他手机号"),

    /**
     * 帐号已经被停用
     */
    USER_DISABLED_ERROR("20006", "帐号已经被停用"),

    /**
     * 新密码与原密码一致
     */
    USER_NEW_PASSWORD_REPEATED_ERROR("200012", "新密码不能与原密码一致"),

    /* --------- 用户模块错误 -------- */

    /* --------- 线索模块错误 -------- */

    /* --------- 线索模块错误 -------- */
    /* --------- 导入导出模块错误 -------- */
    /**
     * 模板不支持
     */
    EXCEL_MODEL_NOT_SUPPORT_ERROR("40001", "上传文件的格式有误"),

    /**
     * 模板有误
     */
    EXCEL_MODEL_ERROR("40002", "上传文件的内容有误"),

    /**
     * 无数据内容
     */
    EXCEL_DATA_NULL_ERROR("40003", "导入数据为空"),

    /**
     * 导出异常
     */
    EXCEL_OUTPUT_ERROR("41001", "导出异常"),

    /**
     * 导出无内容异常
     */
    EXCEL_OUTPUT_DATA_NULL_ERROR("41002", "没有可导出的数据"),
    /* --------- 导入导出模块错误 -------- */;


    @Getter
    private String code;

    @Getter
    private String message;

    ResultCode(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public static ResultCode getByCode(String code) {
        if (null == code || "".equals(code)) {
            return ERROR;
        }

        for (ResultCode resultCode : values()) {
            if (resultCode.code.equals(code)) {
                return resultCode;
            }
        }
        return ERROR;
    }
}
