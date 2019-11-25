package com.jk.minimalism.constraint;


import com.jk.minimalism.constraint.validator.IntInValidator;

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
 * Integer类型的In验证
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/09
 */
@Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE, TYPE_USE})
@Retention(RUNTIME)
@Constraint(validatedBy = IntInValidator.class)
@Documented
public @interface VIntIn {

    String message() default "[${validatedValue}]不在指定的范围内";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    /**
     * 整数允许的数值
     */
    int[] in() default {};

}
