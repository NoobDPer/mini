package com.jk.minimalism.constraint.validator;


import com.jk.minimalism.constraint.VDecimal;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.math.BigDecimal;
import java.util.Objects;

/**
 * Decimal验证器
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
public class DecimalValidator implements ConstraintValidator<VDecimal, BigDecimal> {

    /**
     * 整数长度限制
     */
    private int length;

    /**
     * 精度限制
     */
    private int scale;

    @Override
    public void initialize(VDecimal constraintAnnotation) {
        this.length = constraintAnnotation.intV();
        this.scale = constraintAnnotation.scale();
    }

    @Override
    public boolean isValid(BigDecimal value, ConstraintValidatorContext context) {
        if (Objects.isNull(value)) {
            return true;
        }
        boolean flag = true;
        if (length > 0) {
            flag = ("" + value.longValue()).length() <= length;
        }

        if (scale > 0) {
            flag = flag && value.scale() <= scale;
        }
        return flag;
    }
}
