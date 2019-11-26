var pers = checkPermission();

layui.use(['layer', 'table', 'form', 'laydate'], function () {
    var This = this;
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-content]');

    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

    var tableId = 'table-id-content';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-content',
        url: '/bizcontents', //数据接口
        cols: [[ //表头
            {type: 'checkbox', fixed: 'left'},
            {field: 'contentCn', title: '中文内容', minWidth: 105},
            {field: 'contentEn', title: '英文内容', width: 185, minWidth: 185},
            {field: 'commitQq', title: '提交人', width: 155, minWidth: 155},
            {field: 'showQqState', title: '同意展示', width: 160, minWidth: 160},
            {field: 'source', title: '来源', width: 200, minWidth: 200},
            {field: 'confirmUser', title: '审核人', width: 200, minWidth: 200},
            {field: 'confirmState', title: '审核状态', width: 200, minWidth: 200},
            {
                title: '审核时间', width: 155, minWidth: 155, templet: function (d) {
                    return dayjs(d.confirmTime).format('YYYY-MM-DD HH:mm:ss');
                }
            },
            {
                title: '创建时间', templet: function (d) {
                    return dayjs(d.createTime).format('YYYY-MM-DD HH:mm:ss')
                }, width: 165, minWidth: 165
            },
            {title: '操作', width: 90, minWidth: 90, templet: '#laytpl-table-ops', fixed: 'right'}
        ]]
    }));

    /**
     * 重新加载表格到第一页
     */
    function reloadTable() {
        var formData = $filterForm.serializeObject();
        delete formData.startDate;

        tableLns.reload({
            where: formData,
            page: {
                curr: 1
            }
        });
    }

    $filterForm.find('input[name=condition]').keyup(function (event) {
        if (event.keyCode === 13) {
            reloadTable();
        }
    });
    $filterForm.find('.mini-search-icon').mouseup(reloadTable);

    // // 初始化 启用期限 筛选
    // laydate.render({
    //     elem: $filterForm.find('[name=startDate]')[0],
    //     type: 'month',
    //     min: '2019-01-01 00:00:00',
    //     max: '2019-12-31 23:59:59',
    //     done: function (value) {
    //         if (value) {
    //             var startDates = value.split('-');
    //             $filterForm.find('input[name=startYear]').val(startDates[0]);
    //             $filterForm.find('input[name=startMonth]').val(startDates[1]);
    //         } else {
    //             $filterForm.find('input[name=startYear]').val("");
    //             $filterForm.find('input[name=startMonth]').val("");
    //         }
    //         reloadTable();
    //     }
    // });

    // 新增企业
    $('#btn-add-content').click(function () {
        // todo
        alert("建设中...");
        // adminTab.del('tab-id-add-company');
        // adminTab.add({
        //     layId: 'tab-id-add-company',
        //     title: '新增企业',
        //     url: 'pages/company/saveCompany.html',
        //     icon: 'fa-university'
        // });
    });

    // 删除企业
    var $body = $('body');
    $body.on('click', '.table-btn-content-confirm', function () {
        var id = $(this).data('id');
        layer.confirm('<p class="vg-text-indent-2">确定审核通过该内容？</p><p class="vg-warn-color">注：通过后该内容会被随机刷到！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'post',
                    url: '/contents/' + id + "?state=2"
                });
            })().done(function () {
                layer.msg("通过成功！");
                tableLns.reload({
                    page: {
                        curr: 1
                    }
                });
            });

            layer.close(1);
        });
    });

    // 编辑企业
    // $body.on('click', '.table-btn-company-edit, .table-btn-company-show', function () {
    //     var $this = $(this);
    //     var data = $this.data();
    //     var param = {
    //         id: data.id,
    //         editable: data.editable
    //     };
    //     adminTab.del(data['tabId']);
    //     adminTab.add({
    //         layId: data['tabId'],
    //         title: data['tabTitle'],
    //         url: 'pages/company/saveCompany.html?' + serialize(param),
    //         icon: 'fa-university'
    //     });
    // });

    // 批量通过
    $('#btn-batch-confirm-content').on('click', function () {
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请先选择需要通过的企业！");
            return;
        }

        layer.confirm('<p class="vg-text-indent-2">确定批量通过所选的内容信息？</p><p class="vg-text-indent-2 vg-warn-color">注：通过后内容会被随机刷到！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    url: '/contents/batch?state=2',
                    contentType: 'application/json',
                    type: 'POST',
                    data: JSON.stringify(ids)
                });
            })().done(function () {
                layer.msg("通过成功");
                tableLns.reload({
                    page: {
                        curr: 1
                    }
                });
            });
            layer.close(1);
        });

    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});