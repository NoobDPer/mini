package com.jk.minimalism.util;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import java.math.BigDecimal;

/**
 * 自定义ObjectMapper
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/10/31
 */
public class MinimalismObjectMapper extends ObjectMapper {

    public MinimalismObjectMapper() {
        super();
        SimpleModule simpleModule = new SimpleModule();
        simpleModule.addSerializer(Long.class, ToStringSerializer.instance);
        simpleModule.addSerializer(Long.TYPE, ToStringSerializer.instance);
        registerModule(simpleModule);

        simpleModule = new SimpleModule();
        simpleModule.addSerializer(BigDecimal.class, ToStringSerializer.instance);
        registerModule(simpleModule);
        configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    }
}
