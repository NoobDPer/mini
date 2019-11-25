package com.jk.minimalism.util;

import com.google.common.collect.Lists;

import java.util.List;

/**
 * 字符串转化工具类
 *
 * @author jiaokai
 */
public class StrUtil {

    /**
     * 字符串转为驼峰
     */
    public static String str2hump(String str) {
        StringBuffer buffer = new StringBuffer();
        if (str != null && str.length() > 0) {
            if (str.contains("_")) {
                String[] chars = str.split("_");
                int size = chars.length;
                if (size > 0) {
                    List<String> list = Lists.newArrayList();
                    for (String s : chars) {
                        if (s != null && s.trim().length() > 0) {
                            list.add(s);
                        }
                    }

                    size = list.size();
                    if (size > 0) {
                        buffer.append(list.get(0).toLowerCase());
                        for (int i = 1; i < size; i++) {
                            String s = list.get(i);
                            buffer.append(s.substring(0, 1).toUpperCase());
                            if (s.length() > 1) {
                                buffer.append(s.substring(1).toLowerCase());
                            }
                        }
                    }
                }
            } else {
                buffer.append(str.toLowerCase());
            }
        }

        return buffer.toString();
    }


    /**
     * @param string input string
     * @return the converted String
     * 范围（无空格）：
     * 全角字符unicode编码从65281~65374（十六进制0xFF01 ~ 0xFF5E）
     * 半角字符unicode编码从33~126（十六进制0x21~ 0x7E）
     * <p>
     * 特例：
     * 空格比较特殊，全角为12288（0x3000），半角为 32（0x20）
     *  
     * @Title: convertStringFromFullWidthToHalfWidth.
     * @Description: Convert a String from half width to full width.
     */
    public static String full2Half(String string) {
        if (isEmpty(string)) {
            return string;
        }
        char[] charArray = string.toCharArray();
        for (int i = 0; i < charArray.length; i++) {
            if (charArray[i] == 12288) {
                charArray[i] = ' ';
            } else if (charArray[i] >= ' ' && charArray[i] <= 65374) {
                charArray[i] = (char) (charArray[i] - 65248);
            }
        }
        return new String(charArray);
    }

    /**
     * @param str input string
     * @return whether the input is empty
     * @Description: check whether is empty.
     * @Title: isEmpty
     */
    public static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }


    /**
     * ASCII表中可见字符从!开始，偏移位值为33(Decimal)
     * 半角!
     */
    private static final char DBC_CHAR_START = 33;

    /**
     * ASCII表中可见字符到~结束，偏移位值为126(Decimal)
     * 半角~
     */
    private static final char DBC_CHAR_END = 126;

    /**
     * 全角对应于ASCII表的可见字符从！开始，偏移值为65281
     * 全角！
     */
    private static final char SBC_CHAR_START = 65281;

    /**
     * 全角对应于ASCII表的可见字符到～结束，偏移值为65374
     * 全角～
     */
    private static final char SBC_CHAR_END = 65374;

    /**
     * ASCII表中除空格外的可见字符与对应的全角字符的相对偏移
     * 全角半角转换间隔
     */
    private static final int CONVERT_STEP = 65248;

    /**
     * 全角空格的值，它没有遵从与ASCII的相对偏移，必须单独处理
     * 全角空格 12288
     */
    private static final char SBC_SPACE = 12288;

    /**
     * 半角空格的值，在ASCII中为32(Decimal)
     * 半角空格
     */
    private static final char DBC_SPACE = ' ';

    /**
     * <PRE>
     * 半角字符->全角字符转换
     * 只处理空格，!到˜之间的字符，忽略其他
     * </PRE>
     */
    private static String halfAngle2byteMode(String src) {
        if (src == null) {
            return src;
        }
        StringBuilder buf = new StringBuilder(src.length());
        char[] ca = src.toCharArray();
        for (int i = 0; i < ca.length; i++) {
            if (ca[i] == DBC_SPACE) {
                // 如果是半角空格，直接用全角空格替代
                buf.append(SBC_SPACE);
            } else if ((ca[i] >= DBC_CHAR_START) && (ca[i] <= DBC_CHAR_END)) {
                // 字符是!到~之间的可见字符
                buf.append((char) (ca[i] + CONVERT_STEP));
            } else { // 不对空格以及ascii表中其他可见字符之外的字符做任何处理
                buf.append(ca[i]);
            }
        }
        return buf.toString();
    }

    /**
     * <PRE>
     * 全角字符->半角字符转换
     * 只处理全角的空格，全角！到全角～之间的字符，忽略其他
     * </PRE>
     */
    public static String byteMode2halfAngle(String src) {
        if (src == null) {
            return src;
        }
        StringBuilder buf = new StringBuilder(src.length());
        char[] ca = src.toCharArray();
        for (int i = 0; i < src.length(); i++) {
            if (ca[i] >= SBC_CHAR_START && ca[i] <= SBC_CHAR_END) {
                // 如果位于全角！到全角～区间内
                buf.append((char) (ca[i] - CONVERT_STEP));
            } else if (ca[i] == SBC_SPACE) {
                // 如果是全角空格
                buf.append(DBC_SPACE);
            } else { // 不处理全角空格，全角！到全角～区间外的字符
                buf.append(ca[i]);
            }
        }
        return buf.toString();
    }

//    public static void main(String[] args) {
////        String s = "nihaoｈｋ　｜　　　ｎｉｈｅｈｅ　，。　７８　　７　";
//        String s = "{\"expressions\":[{\"expression\":\"本期是否适用增值税小规模纳税人减征政策n(减免性质代码__城市维护建设税：07049901，减免性质代码_教育费附加：61049901，减免性质代码_地方教育附加：99049901)@@\",\"sheetName\":\"附加税\",\"value\":\"1\"},{\"expression\":\"城市维护建设税@@9\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@9\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加@@9\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@9\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@9\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@9\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"减征比例_城市维护建设税(%)@@\",\"sheetName\":\"附加税\",\"value\":\"0.50\"},{\"expression\":\"城市维护建设税@@10\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@10\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@10\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@10\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@10\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@10\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"经办人身份证号码:t@@9\",\"sheetName\":\"附加税\",\"value\":\"0\"},{\"expression\":\"减征比例_教育费附加(%)@@\",\"sheetName\":\"附加税\",\"value\":\"0.50\"},{\"expression\":\"城市维护建设税@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"本期是否适用试点建设培育产教融合型企业抵免政策@@1\",\"sheetName\":\"附加税\",\"value\":\"0\"},{\"expression\":\"减征比例_地方教育附加(%)@@\",\"sheetName\":\"附加税\",\"value\":\"0.50\"},{\"expression\":\"城市维护建设税@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"当期新增投资额@@4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税@@1\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@1\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加@@1\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@1\",\"sheetName\":\"附加税\"},{\"expression\":\"地方教育附加@@1\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@1\",\"sheetName\":\"附加税\"},{\"expression\":\"合计@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"本期是否适用试点建设培育产教融合型企业抵免政策##上期留抵可抵免金额@@4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税@@2\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@2\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加@@2\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@2\",\"sheetName\":\"附加税\"},{\"expression\":\"地方教育附加@@2\",\"sheetName\":\"附加税\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@2\",\"sheetName\":\"附加税\"},{\"expression\":\"合计@@8\",\"sheetName\":\"附加税\"},{\"expression\":\"本期是否适用试点建设培育产教融合型企业抵免政策##结转下期可抵免金额@@4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税@@3\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@3\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@3\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@3\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@3\",\"sheetName\":\"附加税\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@3\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"合计@@9\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税@@4\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@4\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加@@4\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@4\",\"sheetName\":\"附加税\"},{\"expression\":\"地方教育附加@@4\",\"sheetName\":\"附加税\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@4\",\"sheetName\":\"附加税\"},{\"expression\":\"合计@@10\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@5=1+2+3+4\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"合计@@11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@111\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"合计@@12=7-9-10-11\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@7=5x6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"@@6\",\"sheetName\":\"附加税\",\"value\":\"0.00\"},{\"expression\":\"城市维护建设税@@8\",\"sheetName\":\"附加税\"},{\"expression\":\"城市维护建设税 | 市区(消费税附征)@@8\",\"sheetName\":\"附加税\"},{\"expression\":\"教育费附加@@8\",\"sheetName\":\"附加税\",\"value\":\"0\"},{\"expression\":\"教育费附加 | 消费税教育费附加@@8\",\"sheetName\":\"附加税\",\"value\":\"0\"},{\"expression\":\"地方教育附加@@8\",\"sheetName\":\"附加税\",\"value\":\"0\"},{\"expression\":\"地方教育附加 | 消费税地方教育附加@@8\",\"sheetName\":\"附加税\",\"value\":\"0\"},{\"expression\":\"经办人：@@9\",\"sheetName\":\"附加税\",\"value\":\"南京润秸纸品贸易有限公司\"}],\"modelId\":\"32002068\",\"taxpayerCode\":\"913201143023949650\"}";
//        s=StrUtil.byteMode2halfAngle(s);
//        System.out.println(s);
////        System.out.println(StrUtil.halfAngle2byteMode(s));
//    }

}
