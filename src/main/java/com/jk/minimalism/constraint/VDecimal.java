package com.jk.minimalism.constraint;


import com.jk.minimalism.constraint.validator.DecimalValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.TYPE_USE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * decimal 整数长度, 小数精度验证
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
@Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE, TYPE_USE})
@Retention(RUNTIME)
@Constraint(validatedBy = DecimalValidator.class)
@Documented
public @interface VDecimal {

    String message() default "整数位数大于{intV}或小数位数大于{scale}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    /**
     * 整数长度限制
     */
    int intV() default 0;

    /**
     * 精度限制
     */
    int scale() default 0;

}
