package com.jk.minimalism.controller;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.common.Pager;
import com.jk.minimalism.bean.dto.UserDTO;
import com.jk.minimalism.bean.dto.UserListRequestDTO;
import com.jk.minimalism.bean.dto.UserSaveReqDTO;
import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.bean.page.PageTableHandler;
import com.jk.minimalism.bean.page.PageTableRequest;
import com.jk.minimalism.bean.page.PageTableResponse;
import com.jk.minimalism.interceptor.LogAnnotation;
import com.jk.minimalism.service.UserService;
import com.jk.minimalism.util.UserUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

/**
 * 用户相关接口
 *
 * @author jiaokai
 */
@Api(tags = "用户")

@RestController
@RequestMapping("/users")
public class UserController {

    private static final Logger log = LoggerFactory.getLogger("adminLogger");

    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper modelMapper;

    @LogAnnotation
    @PostMapping
    @ApiOperation(value = "保存用户")
    @PreAuthorize("hasAuthority('sys:user:add')")
    public User saveUser(@RequestBody UserSaveReqDTO userSaveReqDTO) {
        User user = modelMapper.map(userSaveReqDTO, User.class);
        return Objects.isNull(user.getId()) ? userService.insert(user, userSaveReqDTO.getRoleId()) : userService.update(user);
    }

    @LogAnnotation
    @PutMapping("/{username}")
    @ApiOperation(value = "修改密码")
    @PreAuthorize("hasAuthority('sys:user:password')")
    public void changePassword(@PathVariable Long id, String oldPassword, String newPassword) {
        userService.updatePassword(id, oldPassword, newPassword);
    }

    @GetMapping
    @ApiOperation(value = "用户列表")
    @PreAuthorize("hasAuthority('sys:user:query')")
    public AjaxResult listUsers(@RequestParam(value = "condition", required = false) @ApiParam(value = "用户名、昵称、手机号") String condition,
                                @RequestParam(value = "roleId", required = false) @ApiParam(value = "角色ID") String roleId,
                                @RequestParam(value = "state", required = false) @ApiParam(value = "状态") Integer state,
                                @RequestParam(value = "page") @ApiParam(value = "页码") Integer page,
                                @RequestParam(value = "limit") @ApiParam(value = "条数") Integer limit) {
        return new AjaxResult<>(userService.list(UserListRequestDTO.builder().condition(condition).roleId(roleId).state(state).pager(new Pager(page, limit)).build())).success();
    }


    @ApiOperation(value = "当前登录用户")
    @GetMapping("/current")
    public User currentUser() {
        return UserUtil.getLoginUser();
    }


    @ApiOperation(value = "当前登录用户")
    @GetMapping("/user-info")
    public User currentUserInfo() {
        return userService.find(UserUtil.getLoginUser().getId());
    }

    @ApiOperation(value = "根据用户id获取用户")
    @GetMapping("/{id}")
    @PreAuthorize("hasAuthority('sys:user:query')")
    public User user(@PathVariable Long id) {
        return userService.find(id);
    }


    @ApiOperation(value = "删除用户")
    @DeleteMapping("/user/{id}")
    @PreAuthorize("hasAuthority('sys:user:del')")
    public AjaxResult deleteById(@PathVariable("id") Long id) {
        userService.deleteUser(id);
        return new AjaxResult().success();
    }

}
