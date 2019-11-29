package com.jk.minimalism.controller;

import java.util.List;
import java.util.Map;

import com.jk.minimalism.bean.common.AjaxResult;
import com.jk.minimalism.bean.dto.BizContentDTO;
import com.jk.minimalism.util.MapperColumnUtil;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jk.minimalism.bean.page.PageTableRequest;
import com.jk.minimalism.bean.page.PageTableHandler;
import com.jk.minimalism.bean.page.PageTableResponse;
import com.jk.minimalism.service.BizContentService;
import com.jk.minimalism.dao.BizContentMapper;
import com.jk.minimalism.bean.entity.BizContent;

import io.swagger.annotations.ApiOperation;

/**
 * @author auto-generate
 */
@RestController
@RequestMapping("/contents")
public class BizContentController {

    @Autowired
    private BizContentService bizContentService;

    @PostMapping
    @ApiOperation(value = "保存")
    public BizContent save(@RequestBody BizContentDTO bizcontent) {
        return bizContentService.saveBizContent(bizcontent);
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "根据id获取")
    public BizContent get(@PathVariable Long id) {
        return bizContentService.getById(id);
    }

    @PutMapping
    @ApiOperation(value = "修改")
    public BizContent update(@RequestBody BizContent bizcontent) {
        bizContentService.update(bizcontent);

        return bizcontent;
    }

    @GetMapping
    @ApiOperation(value = "列表")
    public PageTableResponse list(PageTableRequest request) {
        return new PageTableHandler(countRequest -> bizContentService.count(countRequest.getParams()),
                listRequest -> bizContentService.list(listRequest.getParams(), listRequest.getOffset(), listRequest.getLimit()),
                orderRequest -> {
                    Map<String, String> map = MapperColumnUtil.getColumnPro(BizContentMapper.class, "BaseResultMap");
                    String orderBy = MapperColumnUtil.pro2Column(orderRequest, map);
                    orderRequest.getParams().put("orderBy", orderBy);
                    return orderRequest;
                }).handle(request);
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除")
    public void delete(@PathVariable Long id) {
        bizContentService.delete(id);
    }

    @PostMapping("/state/batch/{state}")
    @ApiOperation(value = "批量审核内容")
    public AjaxResult batchConfirmBizContent(@RequestBody List<Long> ids,
                                             @PathVariable(value = "state") @ApiParam("审核状态") String state) {
        bizContentService.batchConfirmBizContent(ids, state);
        return new AjaxResult().success();
    }

    @PostMapping("/{id}/state/{state}")
    @ApiOperation(value = "单个审核内容")
    public AjaxResult confirmBizContent(@PathVariable(value = "id") @ApiParam("ID") Long id,
                                        @PathVariable(value = "state") @ApiParam("审核状态") String state) {
        bizContentService.confirmBizContent(id, state);
        return new AjaxResult().success();
    }
}
