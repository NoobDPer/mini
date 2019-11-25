package com.jk.minimalism.util;

import java.util.regex.Pattern;

/**
 * @author admin-jk
 * @date 19-8-13
 */
public class PatternUtil {

    /**
     * 校验是否匹配
     * @param pattern 正则
     * @param toMatch 待匹配字符串
     * @return boolean
     */
    public static boolean isMatch(Pattern pattern, String toMatch) {
        return pattern.matcher(toMatch).matches();
    }

    /**
     * 手机号校验
     */
    public static final Pattern MOBILE_PHONE = Pattern.compile("^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\\d{8}$");

    /**
     * 中文名校验
     */
    public static final Pattern CONTACT_NAME = Pattern.compile("^[\\u4e00-\\u9fa5]+$");


}
