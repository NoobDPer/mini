package com.jk.minimalism.bean.common;


import com.jk.minimalism.bean.enums.ResultCode;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

/**
 * 封装请求返回
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/04/25
 */
@ApiModel("请求返回结果")
public class AjaxResult<T> implements Serializable {
    private static final long serialVersionUID = -5757933746700705620L;

    @ApiModelProperty("返回数据")
    private T result;

    @ApiModelProperty("错误消息")
    private String message;

    @ApiModelProperty("返回代码, 0成功, 其他异常")
    private String code;

    @ApiModelProperty("异常详细信息")
    private String cause;

    public AjaxResult() {
    }

    public AjaxResult(T result) {
        this.result = result;
    }

    public AjaxResult(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public AjaxResult<T> result(T result) {
        this.result = result;
        return this;
    }

    public AjaxResult<T> success() {
        this.code = ResultCode.SUCCESS.getCode();
        this.message = ResultCode.SUCCESS.getMessage();
        return this;
    }

    public AjaxResult<T> fail() {
        this.code = ResultCode.ERROR.getCode();
        this.message = ResultCode.ERROR.getMessage();
        return this;
    }

    public AjaxResult<T> fail(String message) {
        this.code = ResultCode.ERROR.getCode();
        this.message = message;
        return this;
    }

    public AjaxResult<T> fail(String code, String message) {
        this.code = code;
        this.message = message;
        return this;
    }

    public AjaxResult<T> cause(String cause) {
        this.cause = cause;
        return this;
    }

    public T getResult() {
        return this.result;
    }

    public void setResult(T result) {
        this.result = result;
    }

    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCause() {
        return this.cause;
    }

    public void setCause(String cause) {
        this.cause = cause;
    }
}