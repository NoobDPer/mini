package com.jk.minimalism.bean.dto;

import com.jk.minimalism.bean.entity.Role;
import lombok.Data;

import java.util.List;

@Data
public class RoleDTO extends Role {

	private static final long serialVersionUID = 4218495592167610193L;

	private List<Long> permissionIds;

}
