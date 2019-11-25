package com.jk.minimalism.bean.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author admin-jk
 */
@Data
public class GenerateDetail implements Serializable {

    private static final long serialVersionUID = -164567294469931676L;

    private String beanName;

    private List<BeanField> fields;

}
