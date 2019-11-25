package com.jk.minimalism.util;

import com.jk.minimalism.bean.constant.SysConstants;
import org.slf4j.MDC;

/**
 * MDC工具类
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2019/09/03
 */
public class MDCUtils {

    public static void setTraceId() {
        MDC.put(SysConstants.LOG_TRACE_ID, generateTraceId());
    }

    public static String getTraceId() {
        return MDC.get(SysConstants.LOG_TRACE_ID);
    }

    private static String generateTraceId() {
        return "" + IdUtils.nextId();
    }

}
