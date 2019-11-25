package com.jk.minimalism.exception;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.enums.ResultCode;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.ConversionNotSupportedException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

/**
 * 全局异常处理
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
@ControllerAdvice
@Slf4j
public class GlobalErrorHandleAdvice extends ResponseEntityExceptionHandler {

    @Value("${minimalism.debug}")
    private boolean debug;

    /**
     * 不含间隔符号的时间格式器 20180101010101
     */
    private static DateTimeFormatter NO_SPACE_CHARACTER_DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    /**
     * 处理未知异常
     */
    @ExceptionHandler(Throwable.class)
    @ResponseBody
    ResponseEntity<Object> handleException(HttpServletRequest request, Throwable ex) {
        return handleExceptionInternal(ex instanceof Exception ? ((Exception) ex) : new Exception(ex), null, new HttpHeaders(), getStatus(request), new ServletWebRequest(request));
    }

    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers, HttpStatus status, WebRequest request) {
        ResultCode codeEnum = Objects.nonNull(body) && body instanceof ResultCode ? ((ResultCode) body) : getCodeEnum(ex);
        return new ResponseEntity<>(getErrorResult(((ServletWebRequest) request).getRequest(), ex, codeEnum), HttpStatus.OK);
    }

    private ResultCode getCodeEnum(Exception ex) {
        ResultCode codeEnum = ResultCode.ERROR;
        if (ex instanceof MethodArgumentNotValidException || ex instanceof BindException || ex instanceof ConversionNotSupportedException) {
            codeEnum = ResultCode.PARAM_ERROR;
        } else if (ex instanceof AccessDeniedException) {
            codeEnum = ResultCode.ACCESS_DENIED_ERROR;
        } else if (ex instanceof MinimalismBizRuntimeException) {
            codeEnum = ((MinimalismBizRuntimeException) ex).getResultCode();
        }
        return codeEnum;
    }

    /**
     * 封装错误结果
     */
    private AjaxResult getErrorResult(HttpServletRequest request, Throwable ex, ResultCode resultCode) {
        HttpStatus status = getStatus(request);
        ErrorResult errorResult = ErrorResult.builder()
                .id(generateId())
                .code(resultCode.getCode())
                .codeDesc(resultCode.getMessage())
                .statusCode(status.value())
                .path(request.getRequestURI())
                .exceptionName(ex.getClass().getSimpleName())
                .build();
        AjaxResult ajaxResult = new AjaxResult()
                .fail(errorResult.getCode(), handleErrorMsg(errorResult, ex))
                .cause(String.format("[%s]%s", errorResult.getId(), debug ? (" " + ex.getMessage()) : ""));
        log.error(String.format("ID:[%s] PATH:[%s]失败, ErrorResult:[%s]", errorResult.getId(), request.getRequestURI(), errorResult), ex);
        return ajaxResult;
    }

    /**
     * 获取请求的状态码
     */
    private HttpStatus getStatus(HttpServletRequest request) {
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        if (statusCode == null) {
            return HttpStatus.INTERNAL_SERVER_ERROR;
        }
        return HttpStatus.valueOf(statusCode);
    }

    private String handleErrorMsg(ErrorResult errorResult, Throwable ex) {
        String msg = errorResult.getCodeDesc();
        if (ex instanceof MinimalismBizRuntimeException) {
            if (ex instanceof CustomMsgRuntimeException) {
                msg = ex.getMessage();
            }
        }
        return debug ? String.format("[%s] %s", errorResult.getId(), msg) : msg;
    }

    private String generateId() {
        String datePart = LocalDateTime.now().format(NO_SPACE_CHARACTER_DATE_FORMATTER);
        String randomPart = RandomStringUtils.randomAlphanumeric(4).toUpperCase();
        return datePart + randomPart;
    }
}
