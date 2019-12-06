package com.jk.minimalism.bean.common;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class PageResult<T> implements Serializable {

    private static final long serialVersionUID = 1147197044059296827L;
    private Integer page;
    private Integer size;
    private Long total;
    private List<T> data;

    public PageResult() {
    }

    public PageResult(Integer page, Integer size, Long total, List<T> data) {
        this(total, data);
        this.page = page;
        this.size = size;
    }

    public PageResult(Long total, List<T> data) {
        this.total = total;
        this.data = data;
    }

    public static <T> PageResult<T> build(List<T> data) {
        return new PageResult((Long) null, data);
    }

    public static <T> PageResult<T> build(Long total, List<T> data) {
        return new PageResult(total, data);
    }

    public static <T> PageResult<T> build(Integer page, Integer size, Long total, List<T> data) {
        return new PageResult(page, size, total, data);
    }

}
