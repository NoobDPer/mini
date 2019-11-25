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
    /**
     * 调用公共数据中心失败
     */
    COMMON_INVOKE_DATA_CENTER_ERROR("10001", "获取数据失败"),

    /**
     * 调用代账失败
     */
    COMMON_INVOKE_DAIZHANG_ERROR("10002", "获取数据失败"),

    /**
     * 获取锁失败
     */
    COMMON_GET_LOCK_ERROR("10003", "获取锁失败"),

    /**
     * 调用SSO失败
     */
    COMMON_INVOKE_SSO_ERROR("10004", "获取数据失败"),

    /**
     * 行政区划不存在
     */
    COMMON_ADMIN_DIVISION_NOT_EXISTS("10005", "行政区划不存在"),

    /**
     * 数据库中的数据异常
     */
    COMMON_INVALID_DATA_ERROR("10006", "数据异常"),

    /**
     * 调用计费系统失败
     */
    COMMON_INVOKE_BILLING_SYSTEM_ERROR("10007", "获取数据失败"),

    /**
     * 调用客户中心系统失败
     */
    COMMON_INVOKE_CUSTOMER_SYSTEM_ERROR("10008", "获取数据失败"),

    /**
     * 调用微信接口失败
     */
    COMMON_INVOKE_WECHAT_ERROR("10009", "获取微信数据失败"),
    /* --------- 公共错误 -------- */


    /* --------- 服务商模块错误 -------- */
    /**
     * 服务商已存在
     */
    PROVIDER_EXISTS_ERROR("20001", "服务商已存在"),

    /**
     * 服务商不存在
     */
    PROVIDER_NOT_EXISTS_ERROR("20002", "服务商不存在"),

    /**
     * 密码错误
     */
    PROVIDER_USER_PASSWORD_ERROR("20003", "原密码错误，请重新输入"),

    /**
     * 用户名已经存在
     */
    PROVIDER_USER_USERNAME_EXISTS_ERROR("20004", "该手机号已绑定其他账号，请更换其他手机号"),

    /**
     * 服务商子账号不存在
     */
    PROVIDER_CHILDREN_NOT_EXISTS_ERROR("20005", "服务商子账号不存在"),

    /**
     * 帐号已经被停用
     */
    PROVIDER_USER_DISABLED_ERROR("20006", "帐号已经被停用"),

    /**
     * 服务商简称已经存在
     */
    PROVIDER_COMPANY_NAME_SHORT_EXISTS_ERROR("20007", "服务商简称已经存在"),

    /**
     * 当前用户既无服务商，亦无子账号
     */
    PROVIDER_USER_TYPE_ERROR("20008", "账号类型查询失败"),

    /**
     * 未查询到登录用户
     */
    PROVIDER_NOT_LOGIN_ERROR("20009", "未查询到登录用户"),

    /**
     * 服务商已经绑定了微信号
     */
    PROVIDER_ALREADY_BIND_ERROR("20010", "当前账号已被其他微信号绑定"),


    /**
     * 微信号已经绑定了其他服务商
     */
    PROVIDER_WX_ALREADY_BIND_ERROR("20011", "当前微信号已被其他账号绑定"),

    /**
     * 新密码与原密码一致
     */
    PROVIDER_USER_NEW_PASSWORD_REPEATED_ERROR("200012", "新密码不能与原密码一致"),

    /**
     * 运营平台, 服务商未开号
     */
    PROVIDER_NOT_OPEN_ERROR("200013", "服务商未开号"),

    /* --------- 服务商模块错误 -------- */

    /* --------- 线索模块错误 -------- */
    /**
     * 线索类型不存在
     */
    TRACK_TYPE_NOT_EXISTS_ERROR("30001", "线索类型不存在"),

    /**
     * 线索类型级别不存在
     */
    TRACK_TYPE_LEVEL_NOT_EXISTS_ERROR("30002", "当前级别没有该线索名称"),

    /**
     * 线索类型级别已存在
     */
    TRACK_TYPE_LEVEL_EXISTS_ERROR("30003", "当前级别已存在该线索名称"),

    /**
     * 线索类型的城市重复
     */
    TRACK_TYPE_DIVISION_PRICE_REPEAT_ERROR("30004", "不同单价设置的地区或价格重复"),

    /**
     * 地区价格不同与数据库的价格, 并且还不能更新
     */
    TRACK_TYPE_DIVISION_PRICE_DIFF_ERROR("30005", "地区价格错误"),

    /**
     * 新增线索与已有线索重复，添加失败
     */
    TRACK_DATA_EXISTS_ERROR("30006", "线索已存在，添加失败"),

    /**
     * 已分配的线索不能删除
     */
    TRACK_DATA_ASSIGNED_DEL_ERROR("30007", "线索已分配，不可删除"),

    /**
     * 线索类型重复
     */
    TRACK_TYPE_REPEAT_ERROR("30008", "服务类型重复"),

    /**
     * 线索类型不支持的地区
     */
    TRACK_TYPE_NOT_SUPPORT_DIVISION_ERROR("30009", "当前线索类型不支持该地区"),

    /**
     * 线索类型中1,2,3级均相同
     */
    TRACK_TYPE_EXISTS_ERROR("30010", "线索类型已存在"),

    /**
     * 线索分配失败
     */
    TRACK_ASSIGN_ERROR("30011", "线索分配失败"),

    /**
     * 线索跟进记录修改状态时跟进内容不能为空
     */
    TRACK_PROVIDER_LOG_CONTENT_NULL_ERROR("30012", "跟进内容不能为空"),

    /**
     * 线索导入数据重复
     */
    TRACK_IMPORT_DATA_REPEAT_ERROR("30013", "线索导入数据重复"),

    /**
     * 线索导出无数据内容
     */
    TRACK_EXPORT_DATA_NULL_ERROR("30014", "线索导出数据为空"),

    /**
     * 线索不存在
     */
    TRACK_DATA_NOT_EXISTS_ERROR("30015", "线索不存在"),

    /**
     * 线索已经被分配
     */
    TRACK_DATA_ASSIGNED_ERROR("30016", "线索已经被分配"),
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
