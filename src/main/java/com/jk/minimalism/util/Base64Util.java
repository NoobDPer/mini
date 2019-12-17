package com.jk.minimalism.util;

import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import org.apache.commons.lang3.StringUtils;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.regex.Pattern;

/**
 * @author admin-jk
 * @date 19-12-17
 */
public class Base64Util {

    private static final Pattern BASE64 = Pattern.compile("^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$");

    /**
     * 编码成base64格式
     * @param str 字符串
     * @return base64格式的编码
     */
    public static String encode(String str) {
        if (StringUtils.isEmpty(str)) {
            throw new MinimalismBizRuntimeException("string to be encoded can not be null!");
        }
        return Base64.getEncoder().encodeToString(str.getBytes(StandardCharsets.UTF_8));
    }

    /**
     * base64格式的字符串解码成普通字符串
     * @param str base64格式的字符串
     * @return 解码后的字符串
     */
    public static String decode(String str) {
        if (StringUtils.isEmpty(str) || !isBase64Str(str)) {
            return str;
        }
        return new String(Base64.getDecoder().decode(str), StandardCharsets.UTF_8);
    }

    /**
     * 判断是否是base64格式的字符串
     * @param str 字符串
     * @return 是否是base64格式的字符串
     */
    private static boolean isBase64Str(String str) {
        return BASE64.matcher(str).matches();
    }
}
