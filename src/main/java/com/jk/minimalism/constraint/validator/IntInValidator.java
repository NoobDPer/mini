package com.jk.minimalism.constraint.validator;


import com.jk.minimalism.constraint.VIntIn;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Objects;

/**
 * Integer类型的In验证器
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/09
 */
public class IntInValidator implements ConstraintValidator<VIntIn, Object> {

    private int[] in;

    @Override
    public void initialize(VIntIn constraintAnnotation) {
        this.in = constraintAnnotation.in();
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        if (Objects.isNull(value) || !(value instanceof Integer)) {
            return true;
        }

        for (int i : in) {
            if (((Integer) value) == i) {
                return true;
            }
        }
        return false;
    }
}
