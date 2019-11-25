package com.jk.minimalism.controller;

import java.util.Map;

import com.jk.minimalism.util.MapperColumnUtil;
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
import com.jk.minimalism.dao.BizContentDao;
import com.jk.minimalism.bean.entity.BizContent;

import io.swagger.annotations.ApiOperation;

/**
 * @author auto-generate
 */
@RestController
@RequestMapping("/bizcontents")
public class BizContentController {

    @Autowired
    private BizContentService bizcontentservice;

    @PostMapping
    @ApiOperation(value = "保存")
    public BizContent save(@RequestBody BizContent bizcontent) {
        bizcontentservice.saveBizContent(bizcontent);

        return bizcontent;
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "根据id获取")
    public BizContent get(@PathVariable Long id) {
        return bizcontentservice.getById(id);
    }

    @PutMapping
    @ApiOperation(value = "修改")
    public BizContent update(@RequestBody BizContent bizcontent) {
        bizcontentservice.update(bizcontent);

        return bizcontent;
    }

    @GetMapping
    @ApiOperation(value = "列表")
    public PageTableResponse list(PageTableRequest request) {
        return new PageTableHandler(countRequest -> bizcontentservice.count(countRequest.getParams()),
              listRequest -> bizcontentservice.list(listRequest.getParams(), listRequest.getOffset(), listRequest.getLimit()),
              orderRequest -> {
                  Map<String,String> map = MapperColumnUtil.getColumnPro(BizContentDao.class, "BaseResultMap");
                  String orderBy = MapperColumnUtil.pro2Column(orderRequest, map);
                  orderRequest.getParams().put("orderBy", orderBy);
                  return orderRequest;
              }).handle(request);
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除")
    public void delete(@PathVariable Long id) {
        bizcontentservice.delete(id);
    }
}
