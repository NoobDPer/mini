package com.jk.minimalism.controller.open;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.dto.BizContentDTO;
import com.jk.minimalism.bean.dto.BizContentOpenDTO;
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
    @ApiOperation(value = "保存")
    public void save(@RequestBody BizContentOpenDTO bizcontent) {
        bizContentService.saveBizContent4forOpen(bizcontent);
    }

}
