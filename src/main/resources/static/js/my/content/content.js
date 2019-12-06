var pers = checkPermission();

layui.config({
    base: '/js/my/content/'      //自定义layui组件的目录
}).extend({ //设定组件别名
    dropdown: 'dropdown',
});

layui.use(['layer', 'table', 'form', 'laydate','dropdown'], function () {
    var This = this;
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    var dropdown = layui.dropdown;
    dropdown.render();
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-content]');

    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

    var tableId = 'table-id-content';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-content',
        url: '/contents', //数据接口
        cols: [[ //表头
            {type: 'checkbox', fixed: 'left'},
            {field: 'contentCn', title: '中文内容', minWidth: 300},
            {field: 'contentEn', title: '英文内容', width: 185, minWidth: 185},
            {field: 'commitQq', title: '提交人', width: 75, minWidth: 75},
            {field: 'showQqState', title: '同意展示', width: 100, minWidth: 100, templet: '#laytpl-table-show-state-icon'
                    },
            {field: 'source', title: '来源', width: 60, minWidth: 60, templet: function (d) {
                    switch (d.source) {
                        case '0' :
                            return "后台";
                        case '1' :
                            return "WEB";
                        case '2' :
                            return "小程序";
                        default :
                            return "--";
                    }
                }
            },
            {field: 'confirmUsername', title: '审核人', width: 75, minWidth: 75},
            {field: 'confirmState', title: '审核状态', width: 100, minWidth: 100, templet: '#laytpl-table-confirm-state-icon'},
            {
                title: '审核时间', width: 165, minWidth: 165, templet: function (d) {
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

    // 新增内容
    $('#btn-add-content').click(function () {
        adminTab.del('tab-id-add-content');
        adminTab.add({
            layId: 'tab-id-add-content',
            title: '新增内容',
            url: 'pages/content/saveBizContent.html',
            icon: 'fa-university'
        });
    });

    // 审核通过
    var $body = $('body');
    $body.on('click', '.table-btn-content-confirm', function () {
        var id = $(this).data('id');
        layer.confirm('<p class="vg-text-indent-2">确定审核通过该内容？</p><p class="vg-warn-color">注：通过后该内容会被随机刷到！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'post',
                    url: '/contents/' + id + "/state/2"
                });
            })().done(function (data) {
                if (data.code == 0) {
                    layer.msg("通过成功！");
                    tableLns.reload({
                        page: {
                            curr: 1
                        }
                    });
                } else {
                    layer.msg("Sth. must be wrong!")
                }
            });

            layer.close(1);
        });
    });

    // 批量通过
    $('#btn-batch-confirm-content').on('click', function () {
        batchAction(2);
    });
    $('#btn-batch-todo-content').on('click', function () {
        batchAction(1);
    });
    $('#btn-batch-back-content').on('click', function () {
        batchAction(99);
    });

    function batchAction(state) {

        var alertMsg;
        switch (state) {
            case 99 : alertMsg = "打回";break;
            case 1 : alertMsg = "待定";break;
            case 2 : alertMsg = "通过";break;
            default:
        }
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请先选择需要" + alertMsg + "的内容！");
            return;
        }

        layer.confirm('<p class="vg-text-indent-2">确定批量' + alertMsg + '所选的内容信息？</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    url: '/contents/state/batch/' + state,
                    contentType: 'application/json',
                    type: 'POST',
                    data: JSON.stringify(ids)
                });
            })().done(function () {
                layer.msg(alertMsg + "成功");
                tableLns.reload({
                    page: {
                        curr: 1
                    }
                });
            });
            layer.close(1);
        });

    }

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});