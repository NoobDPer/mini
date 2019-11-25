package com.jk.minimalism.util;

import com.jk.minimalism.bean.enums.ResultCode;
import com.jk.minimalism.exception.MinimalismBizRuntimeException;
import io.swagger.annotations.ApiModelProperty;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.Set;

/**
 * 验证帮助类
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/12/28
 */
@Slf4j
@Component
public class ValidateHelper {

    @Autowired
    private Validator validator;

    /**
     * 验证, 并且如果错误则抛出异常
     *
     * @param source 需要验证的对象
     * @param groups 验证组
     */
    public void validate(Object source, Class<?>... groups) {
        // 在验证时使用中文环境, 没有设置全局环境, 避免影响i18n
        Locale tempLocal = LocaleContextHolder.getLocale();
        LocaleContextHolder.setLocale(Locale.SIMPLIFIED_CHINESE);
        try {
            Set<ConstraintViolation<Object>> validationSet = validator.validate(source, groups);
            if (CollectionUtils.isNotEmpty(validationSet)) {
                List<String> msgs = new ArrayList<>();
                for (ConstraintViolation<Object> violation : validationSet) {
                    String propertyName = getPropertyName(violation);
                    msgs.add(propertyName + violation.getMessage());
                }
                throw new MinimalismBizRuntimeException(ResultCode.PARAM_ERROR, StringUtils.join(msgs, "; "));
            }
        } finally {
            // 结束验证后还原原始语言环境
            LocaleContextHolder.setLocale(tempLocal);
        }
    }

    private String getPropertyName(ConstraintViolation<Object> violation) {
        String[] paths = StringUtils.split(violation.getPropertyPath().toString(), ".");
        String propertyName = paths[paths.length - 1];
        Class<?> leafClass = violation.getLeafBean().getClass();
        try {
            Field field = leafClass.getDeclaredField(propertyName);
            ApiModelProperty annotation = field.getAnnotation(ApiModelProperty.class);
            if (Objects.nonNull(annotation) && StringUtils.isNotBlank(annotation.value())) {
                propertyName = annotation.value();
            }
        } catch (NoSuchFieldException e) {
            // 一般不会出现错误
            log.warn("反射获取字段失败", e);
        }
        return propertyName;
    }

}
