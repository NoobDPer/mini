var pers = checkPermission();

layui.use(['layer', 'table', 'form', 'laydate'], function () {
    var This = this;
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    var laydate = layui.laydate;
    var laytpl = layui.laytpl;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-company]');
    // 缓存会计制度数据
    var accountingData = [];
    // 缓存纳税人资格数据
    var taxpayerSeniorityData = [];

    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

    var tableId = 'table-id-company';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-company',
        url: '/companys', //数据接口
        cols: [[ //表头
            {type: 'checkbox', fixed: 'left'},
            {field: 'taxpayerName', title: '纳税人名称', minWidth: 105},
            {field: 'taxpayerCode', title: '纳税人识别号', width: 185, minWidth: 185},
            {field: 'booksetCode', title: '账套编码', width: 155, minWidth: 155},
            {field: 'taxpayerSeniorityType', title: '纳税人资格', width: 160, minWidth: 160},
            {field: 'applicableAccountingType', title: '会计制度', width: 200, minWidth: 200},
            {
                title: '启用期间', width: 155, minWidth: 155, templet: function (d) {
                    return '' + d.startYear + '-' + (d.startMonth < 10 ? '0' + d.startMonth : d.startMonth);
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

    // 初始化select
    var initSelects = [
        // 初始化会计准则
        {
            fn: function () {
                return VgReq.getAccounting().done(function (data) {
                    accountingData = data;
                })
            }, $ele: $filterForm.find('select[name=applicableAccountingType]')
        },
        // 初始纳税人资格
        {
            fn: function () {
                return VgReq.getTaxpayerSeniority().done(function (data) {
                    taxpayerSeniorityData = data;
                })
            }, $ele: $filterForm.find('select[name=taxpayerSeniorityType]')
        }
    ];
    $.each(initSelects, function (i, row) {
        VgReq.initSelect.call(This, row);
    });

    // 筛选事件
    form.on('select(select-filter-taxpayer-seniority)', function () {
        reloadTable();
    });
    form.on('select(select-filter-accounting)', function () {
        reloadTable();
    });
    $filterForm.find('input[name=condition]').keyup(function (event) {
        if (event.keyCode === 13) {
            reloadTable();
        }
    });
    $filterForm.find('.vg-search-icon').mouseup(reloadTable);

    // 初始化 启用期限 筛选
    laydate.render({
        elem: $filterForm.find('[name=startDate]')[0],
        type: 'month',
        min: '2019-01-01 00:00:00',
        max: '2019-12-31 23:59:59',
        done: function (value) {
            if (value) {
                var startDates = value.split('-');
                $filterForm.find('input[name=startYear]').val(startDates[0]);
                $filterForm.find('input[name=startMonth]').val(startDates[1]);
            } else {
                $filterForm.find('input[name=startYear]').val("");
                $filterForm.find('input[name=startMonth]').val("");
            }
            reloadTable();
        }
    });

    // 新增企业
    $('#btn-add-company').click(function () {
        adminTab.del('tab-id-add-company');
        adminTab.add({
            layId: 'tab-id-add-company',
            title: '新增企业',
            url: 'pages/company/saveCompany.html',
            icon: 'fa-university'
        });
    });

    // 删除企业
    var $body = $('body');
    $body.on('click', '.table-btn-company-del', function () {
        var id = $(this).data('id');
        layer.confirm('<p class="vg-text-indent-2">确定删除所选企业所有信息？</p><p class="vg-warn-color">注：删除企业会删除对应账套数据！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'delete',
                    url: '/companys/' + id
                });
            })().done(function () {
                layer.msg("删除成功");
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
    $body.on('click', '.table-btn-company-edit, .table-btn-company-show', function () {
        var $this = $(this);
        var data = $this.data();
        var param = {
            id: data.id,
            editable: data.editable
        };
        adminTab.del(data['tabId']);
        adminTab.add({
            layId: data['tabId'],
            title: data['tabTitle'],
            url: 'pages/company/saveCompany.html?' + serialize(param),
            icon: 'fa-university'
        });
    });

    // 批量删除
    $('#btn-batch-delete-company').on('click', function () {
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请先选择需要删除的企业！");
            return;
        }

        layer.confirm('<p class="vg-text-indent-2">确定批量删除所选的企业所有信息？</p><p class="vg-text-indent-2 vg-warn-color">注：删除企业会删除对应账套数据！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    url: '/companys/batch',
                    contentType: 'application/json',
                    type: 'DELETE',
                    data: JSON.stringify(ids)
                });
            })().done(function () {
                layer.msg("删除成功");
                tableLns.reload({
                    page: {
                        curr: 1
                    }
                });
            });
            layer.close(1);
        });

    });

    var $tableBatchAdd = $('#table-batch-add');
    // 批量新增
    var layerIndex;

    function initBatchAddRow($tpl) {
        if (accountingData && accountingData.length > 0) {
            VgReq.initSelect.call(This, {
                fn: null,
                data: accountingData,
                $ele: $tpl.find('select[name=applicableAccountingType]')
            });
            VgReq.initSelect.call(This, {
                fn: null,
                data: taxpayerSeniorityData,
                $ele: $tpl.find('select[name=taxpayerSeniorityType]')
            });
        }
        laydate.render({
            elem: $tpl.find('[name=startDate]')[0],
            type: 'month',
            value: '2019-01',
            min: '2019-01-01 00:00:00',
            max: '2019-12-31 23:59:59'
        });
    }

    $('#btn-batch-add-company').on('click', function () {
        $tableBatchAdd.find('tbody').empty();
        var $tpl = $($('#laytpl-table-tr').html());
        $tableBatchAdd.find('tbody').append($tpl);
        initBatchAddRow($tpl);
        form.render(null, 'form-filter-batch-add');
        layerIndex = layer.open({
            id: 'layer-id-batch-add',
            type: 1,
            title: '批量新增',
            content: $('#layer-batch-add'),
            area: '1000px',
            resize: false
        })
    });

    // 监听批量新增表单提交
    form.on('submit(submit-filter-batch-add)', function (data) {
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

            // 处理启用期间
            if (rowData.startDate) {
                var startDates = rowData.startDate.split('-');
                rowData.startYear = startDates[0];
                rowData.startMonth = startDates[1];
                delete rowData.startDate
            }
            return rowData;
        });

        loadingMonitor(function () {
            return $.ajax({
                url: "/companys/batch",
                contentType: 'application/json',
                type: "POST",
                data: JSON.stringify(formData),
                dataType: 'JSON'
            })
        })().done(function () {
            reloadTable();
            layer.msg("新增企业成功");
            if (layerIndex) {
                layer.close(layerIndex);
            }
        });
        return false;
    });

    // 批量新增取消按钮单击事件
    $('#layer-batch-add').find('.btn1').on('click', function () {
        layer.close(layerIndex);
    });

    // 批量新增单元格事件
    $tableBatchAdd.on('mouseover', 'tr', function () {
        var $this = $(this);
        $this.find('.ops > a.a-ops-add').show();
        if ($this.parent().find('tr').length > 1) {
            $this.find('.ops > a.a-ops-del').show();
        }
    });
    $tableBatchAdd.on('mouseout', 'tr', function () {
        var $this = $(this);
        $this.find('.ops > a').hide();
    });
    $tableBatchAdd.on('click', 'a.a-ops-add', function () {
        var $tpl = $($('#laytpl-table-tr').html());
        initBatchAddRow($tpl);
        $(this).parentsUntil('tr').parent().after($tpl);
        form.render(null, 'form-filter-batch-add');
    });
    $tableBatchAdd.on('click', 'a.a-ops-del', function () {
        $(this).parentsUntil('tr').parent().remove();
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});