package com.jk.minimalism.interceptor;

import com.jk.minimalism.util.MDCUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 请求追踪ID
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/09/03
 */
public class TraceInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        MDCUtils.setTraceId();
        return true;
    }
}
