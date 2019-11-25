package com.jk.minimalism.exception;

import com.jk.minimalism.bean.enums.ResultCode;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 出错时返回结果的封装
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ErrorResult {

    /**
     * 错误id
     */
    private String id;

    /**
     * 请求返回代码
     * @see ResultCode
     */
    private String code;

    /**
     * 请求返回代码的描述信息
     */
    private String codeDesc;

    /**
     * 出错的数据
     */
    private Object errorData;

    /**
     * 请求路径
     */
    private String path;

    /**
     * 请求状态码
     */
    private int statusCode;

    /**
     * 异常名称
     */
    private String exceptionName;
}
