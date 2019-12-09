package com.jk.minimalism.controller.open;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.dto.BizContentOpenRequestDTO;
import com.jk.minimalism.bean.dto.BizContentOpenResponseDTO;
import com.jk.minimalism.bean.entity.BizContent;
import com.jk.minimalism.service.BizContentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @Autowired
    private ModelMapper modelMapper;

    @PostMapping("/content")
    @ApiOperation(value = "保存")
    public AjaxResult save(@RequestBody BizContentOpenRequestDTO bizcontent) {
        bizContentService.saveBizContent4forOpen(bizcontent);
        return new AjaxResult<>().success();
    }

    @GetMapping("/content/type/{type}/random")
    @ApiOperation(value = "随机一条内容")
    public AjaxResult<BizContentOpenResponseDTO> randomOneContent(@PathVariable("type") String type) {
        BizContent bizContent = bizContentService.randomOneBizContent(type);
        BizContentOpenResponseDTO result = modelMapper.map(bizContent, BizContentOpenResponseDTO.class);
        if ("0".equals(bizContent.getShowQqState())) {
            result.setCommitQq("");
        }
        return new AjaxResult<>(result).success();
    }

}
