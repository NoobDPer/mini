package com.jk.minimalism.util;

import com.github.pagehelper.PageInfo;
import com.jk.minimalism.bean.common.PageResult;
import com.jk.minimalism.bean.common.Pager;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Collection;
import java.util.stream.Collectors;

/**
 * 分页处理工具
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/12
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class PageHandleUtils {

    /**
     * 批量更新以及插入时, 每页的大小
     */
    private static int BATCH_HANDLE_PAGE_SIZE = 200;

    /**
     * 分页处理数据
     *
     * @param handler 分页数据处理器
     * @param data 需要分页进行处理的数据
     * @param <T> 数据类型
     */
    public static <T> void handle(Handler<T> handler, Collection<T> data) {
        handle(handler, data, BATCH_HANDLE_PAGE_SIZE);
    }

    /**
     * 分页处理数据
     *
     * @param handler 分页数据处理器
     * @param data 需要分页进行处理的数据
     * @param pageSize 每页数据的大小
     * @param <T> 数据类型
     */
    public static <T> void handle(Handler<T> handler, Collection<T> data, int pageSize) {
        int total = data.size();
        int pages = total / pageSize + ((total % pageSize == 0) ? 0 : 1);
        for (int i = 0; i < pages; i++) {
            handler.handle(data.stream().skip((long) i * pageSize).limit(pageSize).collect(Collectors.toList()));
        }
    }

    /**
     * 将PageInfo转为PageResult
     *
     * @param pageInfo PageInfo
     * @param <T> PageResult数据的类型
     * @return PageResult, 如果无数据, result字段为空集合
     */
    public static <T> PageResult<T> convertToPageResult(PageInfo pageInfo) {
        return PageResult.build(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getTotal(), new ArrayList<>());
    }

    /**
     * 根据总数计算总页数
     *
     * @param totalCount 总数
     * @param pageSize 每页数
     * @return 总页数
     */
    public static int totalPage(long totalCount, int pageSize) {
        if (pageSize == 0) {
            return 0;
        }
        return (int) (totalCount % pageSize == 0 ? (totalCount / pageSize) : (totalCount / pageSize + 1));
    }

    /**
     * 将页数和每页条目数转换为开始位置和结束位置<br>
     * 此方法用于不包括结束位置的分页方法<br>
     * 例如：<br>
     * 页码：1，每页10 =》 [0, 10]<br>
     * 页码：2，每页10 =》 [10, 20]<br>
     * 。。。<br>
     *
     * @param pageNo 页码（从1计数）
     * @param pageSize 每页条目数
     * @return 第一个数为开始位置，第二个数为结束位置
     */
    public static int[] transToStartEnd(int pageNo, int pageSize) {
        if (pageNo < 1) {
            pageNo = 1;
        }

        if (pageSize < 1) {
            pageSize = 0;
        }

        int start = (pageNo - 1) * pageSize;
        int end = start + pageSize;

        return new int[] { start, end };
    }

    /**
     * 封装成对象
     *
     * @param page 页号
     * @param size 每页大小
     * @return Pager
     */
    public static Pager wrap(int page, int size) {
        Pager pager = new Pager();
        pager.setSize(size);
        pager.setPage(page);
        return pager;
    }

    /**
     * 分页数据的处理器
     *
     * @param <T> 数据类型
     */
    @FunctionalInterface
    public interface Handler <T> {

        /**
         * 每一页数据的处理方法
         *
         * @param data 需要处理的每一页的数据
         */
        void handle(Collection<T> data);

    }

}
