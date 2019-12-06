package com.jk.minimalism.controller;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.dto.BeanCommonMap;
import com.jk.minimalism.bean.enums.BizContentType;
import com.jk.minimalism.bean.enums.ConfirmStatus;
import com.jk.minimalism.bean.enums.UserStatus;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author admin-jk
 * @date 19-11-28
 */
@Api(tags = "公共接口")
@RestController
@RequestMapping("/common")
public class CommonController {

    @ApiOperation("查询审核状态对应关系")
    @GetMapping("/confirm-status")
    public AjaxResult<List<BeanCommonMap>> getConfirmStatus() {
        return new AjaxResult<>(ConfirmStatus.getCommonMap()).success();
    }

    @ApiOperation("查询内容类型对应关系")
    @GetMapping("/content-types")
    public AjaxResult<List<BeanCommonMap>> getContentTypes() {
        return new AjaxResult<>(BizContentType.getCommonMap()).success();
    }


    @ApiOperation(value = "获取全部用户状态")
    @GetMapping("/user-status")
    public AjaxResult<List<BeanCommonMap>> getUserStatus() {
        return new AjaxResult<>(UserStatus.getCommonMap()).success();
    }

}
