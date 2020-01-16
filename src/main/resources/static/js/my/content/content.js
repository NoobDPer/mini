var pers = checkPermission();

layui.config({
    base: '/js/my/content/'      //自定义layui组件的目录
}).extend({ //设定组件别名
    dropdown: 'dropdown',
});

layui.use(['layer', 'table', 'form', 'laydate', 'dropdown'], function () {
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
            {
                field: 'showQqState', title: '同意展示', width: 100, minWidth: 100, templet: '#laytpl-table-show-state-icon'
            },
            {
                field: 'source', title: '来源', width: 80, minWidth: 80, templet: function (d) {
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
            {
                field: 'confirmState',
                title: '审核状态',
                width: 100,
                minWidth: 100,
                templet: '#laytpl-table-confirm-state-icon'
            },
            {
                title: '审核时间', width: 165, minWidth: 165, templet: function (d) {
                    if (d.confirmTime) {
                        return dayjs(d.confirmTime).format('YYYY-MM-DD HH:mm:ss');
                    } else {
                        return "--";
                    }

                }
            },
            {
                title: '创建时间', templet: function (d) {
                    return dayjs(d.createTime).format('YYYY-MM-DD HH:mm:ss')
                }, width: 165, minWidth: 165
            },
            {title: '操作', width: 110, minWidth: 110, templet: '#laytpl-table-ops', fixed: 'right'}
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


    // 初始化select
    var initSelects = [
        // 审核状态
        {fn: miniReq.getConfirmStatus, $ele: $filterForm.find('select[name=confirmState]')},
        // 内容类型
        {fn: miniReq.getContentTypes, $ele: $filterForm.find('select[name=type]')},
    ];
    $.each(initSelects, function (i, row) {
        miniReq.initSelect.call(This, row);
    });


    // 初始化筛选select事件
    var $selects = [$filterForm.find('select[name=confirmState]'),
        $filterForm.find('select[name=type]')];
    $.each($selects, function (i, $ele) {
        onSelect($ele, reloadTable);
    });

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
        layer.confirm('<p class="mini-text-indent-2">确定审核通过该内容？</p><p class="mini-warn-color">注：通过后该内容会被随机刷到！</p>', {
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

    $body.on('click', '.table-btn-content-refuse', function () {
        var id = $(this).data('id');
        layer.confirm('<p class="mini-text-indent-2">确定打回该内容？</p><p class="mini-warn-color">注：打回后该内容不会被随机刷到！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'post',
                    url: '/contents/' + id + "/state/99"
                });
            })().done(function (data) {
                if (data.code == 0) {
                    layer.msg("打回成功！");
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

    var $tableDetailAdd = $('#table-batch-add');
    var layerIndex;

    function initBatchAddRow($tableDetailAdd, id) {
        $tableDetailAdd.find('tbody').empty();
        $('#content-id-hidden').val(id);

        loadingMonitor(function () {
            return $.ajax({
                type: 'get',
                url: '/contents/' + id + "/detail",
                async: false
            });
        })().done(function (data) {
            if (data.code == 0) {
                for (i = 0; i < data.result.length; i++) {
                    var $tpl = $($('#laytpl-table-tr').html());
                    $tpl.find('[name="content"]').val(data.result[i].content);
                    $tableDetailAdd.find('tbody').append($tpl);
                }
            } else {
                layer.msg("Sth. must be wrong!")
            }
        });

    }

    $body.on('click', '.table-btn-content-detail', function () {
        var id = $(this).data('id');
        $tableDetailAdd.find('tbody').empty();
        var $tpl = $($('#laytpl-table-tr').html());
        initBatchAddRow($tableDetailAdd, id);
        $tableDetailAdd.find('tbody').append($tpl);
        layerIndex = layer.open({
            id: 'layer-id-batch-add',
            type: 1,
            title: '内容编辑',
            content: $('#layer-save-detail'),
            area: '1000px',
            resize: false
        })
    });

    // 监听批量新增表单提交
    form.on('submit(submit-filter-save-detail)', function (data) {
        var $form = $(data.form);
        var formData = $.map($form.find('tbody tr'), function (tr) {
            var rowData = {};
            $(tr).find('[name!=""]').each(function (i1, input) {
                var $input = $(input);
                var name = $input.prop('name');
                if (name) {
                    rowData[name] = $input.val();
                }
            });

            return rowData;
        });
        var id = $('#content-id-hidden').val();

        loadingMonitor(function () {
            return $.ajax({
                url: "/contents/" + id + "/detail",
                contentType: 'application/json',
                type: "POST",
                data: JSON.stringify(formData),
                dataType: 'JSON'
            })
        })().done(function () {
            reloadTable();
            layer.msg("明细保存成功");
            if (layerIndex) {
                layer.close(layerIndex);
            }
        });
        return false;
    });


    // 批量新增取消按钮单击事件
    $('#layer-save-detail').find('.btn1').on('click', function () {
        layer.close(layerIndex);
    });

    $tableDetailAdd.on('mouseover', 'tr', function () {
        var $this = $(this);
        $this.find('.ops > a.a-ops-add').show();
        if ($this.parent().find('tr').length > 1) {
            $this.find('.ops > a.a-ops-del').show();
        }
    });
    $tableDetailAdd.on('mouseout', 'tr', function () {
        var $this = $(this);
        $this.find('.ops > a').hide();
    });
    $tableDetailAdd.on('click', 'a.a-ops-add', function () {
        var $tpl = $($('#laytpl-table-tr').html());
        $(this).parentsUntil('tr').parent().after($tpl);
        form.render(null, 'form-filter-save-detail');
    });
    $tableDetailAdd.on('click', 'a.a-ops-del', function () {
        $(this).parentsUntil('tr').parent().remove();
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
            case 99 :
                alertMsg = "打回";
                break;
            case 1 :
                alertMsg = "待定";
                break;
            case 2 :
                alertMsg = "通过";
                break;
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

    /**
     * 监听layui select事件
     */
    function onSelect($ele, fn) {
        var filter = $ele.attr('lay-filter');
        if (!filter) {
            return;
        }
        var fns = $ele.data('selectFns') || [];
        fns.push(fn);
        form.on('select(' + filter + ')', function () {
            var args = arguments;
            var This = this;
            $.each(fns, function (i, rowFn) {
                rowFn.apply(This, args);
            })
        });
        $ele.data('selectFns', fns);
    }

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});