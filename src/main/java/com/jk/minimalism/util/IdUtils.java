package com.jk.minimalism.util;

import com.jk.minimalism.util.id.IdWorker;
import com.jk.minimalism.util.id.IdWorkerFactory;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 生成id工具
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/07
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class IdUtils {

    private static final int maxSize = 4095;

    /**
     * 获取下一个id
     * @return
     */
    public static Long nextId() {
        return getId();
    }

    /**
     * 批量获取ids
     * <p>目前设置最大请求数量是4095，如果有特殊需要可以联系开发人员<p/>
     * @param size 请求id数量
     * @return List<Long>
     * @apiNote 一次最大请求数量4095
     */
    public static List<Long> nextIds(int size) {
        return getIdList(size);
    }

    /**
     * 获取idList
     * @param size
     * @return
     */
    private static List<Long> getIdList(int size) {
        if( size > maxSize) {
            throw new RuntimeException("Get the number of ID exceeding the maximum number");
        }
        IdWorker idWorker = IdWorkerFactory.getInstance().getIdWorker();
        List<Long> idList = new ArrayList<>();
        for(int i=0;i<size;i++) {
            idList.add(idWorker.nextId());
        }
        return idList;

    }

    /**
     * 获取单个id方法
     * @return
     */
    private static Long getId() {
        IdWorker idWorker = IdWorkerFactory.getInstance().getIdWorker();
        return idWorker.nextId();
    }

//    public static void main(String[] args) {
//        System.out.println(getId());
//        List<Long> idList = getIdList(50);
//        System.out.println(String.join(",", idList.stream().map(Object::toString).collect(Collectors.toList())));
//    }
}
