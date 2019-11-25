package com.jk.minimalism.util;

import org.apache.commons.lang3.StringUtils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author Admin on 2018/7/22.
 */
public class DateUtils {

    public static final String DATE_FORMAT_STR = "yyyy-MM-dd";
    public static final String DATE_FORMAT_STR_TIME = "yyyy-MM-dd HH:mm:ss";

    public static String getDateString(Integer year, Integer month, Integer day) {
        StringBuilder formatDate = new StringBuilder(String.valueOf(year)).append("-");
        if (month < 10) {
            formatDate.append("0");
        }
        formatDate.append(String.valueOf(month)).append("-");
        if (day < 10) {
            formatDate.append("0");
        }
        formatDate.append(String.valueOf(day));
        return formatDate.toString();
    }

    public static String getMonthString(Integer year, Integer month) {
        StringBuilder formatDate = new StringBuilder(String.valueOf(year)).append("-");
        if (month < 10) {
            formatDate.append("0");
        }
        formatDate.append(String.valueOf(month));
        return formatDate.toString();
    }

    public static List<String> getDayListOfMonth(int year, int month) {
        List<String> list = new ArrayList<>();
        Calendar aCalendar = Calendar.getInstance();
        aCalendar.set(Calendar.YEAR, year);
        aCalendar.set(Calendar.MONTH, month - 1);
        int day = aCalendar.getActualMaximum(Calendar.DATE);
        for (int i = 1; i <= day; i++) {
            StringBuilder aDate = new StringBuilder(String.valueOf(year)).append("-");
            if (month < 10) {
                aDate.append("0");
            }
            aDate.append(month).append("-");
            if (i < 10) {
                aDate.append("0");
            }
            aDate.append(i);
            list.add(aDate.toString());
        }
        return list;
    }

    public static Integer getLastMonth(Integer month) {
        return month.compareTo(1) == 0 ? 12 : month - 1;
    }

    public static Integer getLastMonthYear(Integer year, Integer month) {
        return month.compareTo(1) == 0 ? year - 1 : year;
    }

    public static Integer getNextMonth(Integer month) {
        return month.compareTo(12) == 0 ? 1 : month + 1;
    }

    public static Integer getNextMonthYear(Integer year, Integer month) {

        return month.compareTo(12) == 0 ? year + 1 : year;
    }

    public static Date toDate(String date) {
        DateFormat dateFormat = new SimpleDateFormat(DATE_FORMAT_STR);
        if (date == null || date.trim().length() == 0) {
            throw new RuntimeException("转换字符串不能为空");
        }
        try {
            return dateFormat.parse(date);
        } catch (ParseException e) {
            throw new RuntimeException("日期格式错误，转换出错！");
        }
    }

    /**
     * 获取某月最后一天
     *
     * @param year 年
     * @param month 月
     * @return last day of month
     */
    public static Date getLastDayOfMonth(int year, int month) {
        // 获取当前日期
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month);
        // 设置为1号,当前日期既为本月第一天
        cal.set(Calendar.DAY_OF_MONTH, 0);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    /**
     * 获取某月第一天
     *
     * @param year 年
     * @param month 月
     * @return first day of month
     */
    public static Date getFirstDayOfMonth(int year, int month) {
        //获取当前日期
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    /**
     * 按照指定的日期格式将日期转换成字符串
     *
     * @param date              要进行格式化的日期
     * @param dateFormatPattern 日期正则
     * @return 返回日期格式化后的字符串
     */
    public static String format(Date date, String dateFormatPattern) {
        if (date == null) {
            return "";
        }
        DateFormat dateFormat = new SimpleDateFormat(StringUtils.isEmpty(dateFormatPattern) ? DATE_FORMAT_STR: dateFormatPattern);
        return dateFormat.format(date);
    }
}
