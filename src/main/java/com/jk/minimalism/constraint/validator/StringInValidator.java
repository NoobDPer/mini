package com.jk.minimalism.constraint.validator;


import com.jk.minimalism.constraint.VStringIn;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.Objects;

/**
 * String类型的In验证器
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/09
 */
public class StringInValidator implements ConstraintValidator<VStringIn, Object> {

    private String[] in;

    @Override
    public void initialize(VStringIn constraintAnnotation) {
        this.in = constraintAnnotation.in();
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        if (Objects.isNull(value)) {
            return true;
        }

        for (String i : in) {
            if (value.toString().equals(i)) {
                return true;
            }
        }
        return false;
    }
}
