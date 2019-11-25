package com.jk.minimalism.exception;


import com.jk.minimalism.bean.enums.ResultCode;

/**
 * 抛出此异常, 返回的消息中msg参数值为message字段值
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/01/19
 */
public class CustomMsgRuntimeException extends MinimalismBizRuntimeException {
    public CustomMsgRuntimeException(ResultCode resultCode, String message) {
        super(resultCode, message);
    }

    public CustomMsgRuntimeException(String message, Throwable e) {
        super(message, e);
    }

    public CustomMsgRuntimeException(String message) {
        super(message);
    }

    public CustomMsgRuntimeException(ResultCode resultCode, String message, Throwable e) {
        super(resultCode, message, e);
    }
}
