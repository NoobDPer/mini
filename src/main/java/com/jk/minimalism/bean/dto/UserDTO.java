package com.jk.minimalism.bean.dto;

import com.jk.minimalism.bean.entity.User;
import lombok.Data;

/**
 * @author admin-jk
 * @date 19-11-22
 */
@Data
public class UserDTO extends User {

    private Integer roleId;
}
