package com.jk.minimalism.exception;

import com.jk.minimalism.bean.enums.ResultCode;
import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

/**
 * 发票业务通用运行时异常
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
public class MinimalismBizRuntimeException extends RuntimeException {

    @Getter
    private ResultCode resultCode;

    @Getter
    @Setter
    private String message;

    public MinimalismBizRuntimeException(ResultCode resultCode) {
        this(resultCode, null, null);
    }

    public MinimalismBizRuntimeException(ResultCode resultCode, Throwable e) {
        this(resultCode, null, e);
    }

    public MinimalismBizRuntimeException(ResultCode resultCode, String message) {
        this(resultCode, message, null);
    }

    public MinimalismBizRuntimeException(String message, Throwable e) {
        this(ResultCode.ERROR, message, e);
    }

    public MinimalismBizRuntimeException(String message) {
        this(ResultCode.ERROR, message, null);
    }

    public MinimalismBizRuntimeException(ResultCode resultCode, String message, Throwable e) {
        super(message, e);
        this.message = message;
        this.resultCode = resultCode;

        if (Objects.nonNull(resultCode) && Objects.isNull(message)) {
            this.message = resultCode.getMessage();
        }
    }
}
