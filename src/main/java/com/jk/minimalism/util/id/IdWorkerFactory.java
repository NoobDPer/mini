package com.jk.minimalism.util.id;

/**
 * id 工厂类
 * Created by Promise.H on 2018/7/30
 **/
public class IdWorkerFactory {

    private IdWorker idWorker;

    private static IdWorkerFactory idWorkerFactory = new IdWorkerFactory();

    private IdWorkerFactory() {
    }

    public static IdWorkerFactory getInstance() {
        return idWorkerFactory;
    }

    public IdWorker getIdWorker() {
        if (idWorker == null) {
            synchronized (IdWorker.class) {
                if (idWorker == null) {
                    idWorker = new IdWorker();
                }
            }
        }

        return idWorker;
    }
}
