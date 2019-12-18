package com.jk.minimalism.util;

import javax.servlet.http.HttpServletRequest;

/**
 * @author jiaokai
 * @date 2019-03-29
 */
public class SourceIpUtil {


    private static final String[] HEADERS_TO_TRY = {
            "X-Real-IP",
            "REMOTE_ADDR",
            "X-Forwarded-For",
            "Proxy-Client-IP",
            "WL-Proxy-Client-IP",
            "HTTP_X_FORWARDED_FOR",
            "HTTP_X_FORWARDED",
            "HTTP_X_CLUSTER_CLIENT_IP",
            "HTTP_CLIENT_IP",
            "HTTP_FORWARDED_FOR",
            "HTTP_FORWARDED",
            "HTTP_VIA"
    };

    /***
     * 获取客户端ip地址(可以穿透代理)
     * @param request
     * @return
     */
    public static String getClientIpAddress(HttpServletRequest request) {
        for (String header : HEADERS_TO_TRY) {
            String ip = request.getHeader(header);
            if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
                return "0:0:0:0:0:0:0:1".equals(ip) ? "127.0.0.1" : ip;
            }
        }
        return request.getRemoteAddr();
    }


}
