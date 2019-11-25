package com.jk.minimalism.exception;

import org.springframework.security.core.AuthenticationException;


/**
 * @author admin-jk
 * @date 19-6-26
 */
public class ValidateException extends AuthenticationException {


    private static final long serialVersionUID = 6057739130495673899L;

    public ValidateException(String msg, Throwable t) {
        super(msg, t);
    }

    public ValidateException(String msg) {
        super(msg);
    }
}
