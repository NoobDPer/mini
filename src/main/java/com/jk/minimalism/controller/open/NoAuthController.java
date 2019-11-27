package com.jk.minimalism.controller.open;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.entity.BizContent;
import com.jk.minimalism.service.BizContentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 无权限接口
 * @author jiaokai
 */
@Api(tags = "开放接口")
@RestController
@RequestMapping("/open")
public class NoAuthController {

    @Autowired
    private BizContentService bizContentService;

    @PostMapping
    @ApiOperation(value = "/contents/batch/state")
    public AjaxResult batchConfirmBizContent(@RequestBody List<Long> ids,
                           @RequestParam(value = "state") @ApiParam("审核状态") String state) {
        bizContentService.batchConfirmBizContent(ids, state);
        return new AjaxResult().success();
    }

    @PostMapping
    @ApiOperation(value = "/contents/state")
    public AjaxResult confirmBizContent(@RequestParam(value = "id") @ApiParam("ID") Long id,
                                        @RequestParam(value = "state") @ApiParam("审核状态") String state) {
        bizContentService.confirmBizContent(id, state);
        return new AjaxResult().success();
    }
}
