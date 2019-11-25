var pers = checkPermission();

layui.use(['layer', 'laydate', 'table', 'form', 'upload'], function () {
    var This = this;
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    var laytpl = layui.laytpl;
    var laydate = layui.laydate;
    var upload = layui.upload;
    var $body = $('body');
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-bookset-data]');

    // 初始化select
    var initSelects = [
        // 初始化账套数据类型
        {fn: VgReq.getBooksetType, $ele: $filterForm.find('select[name=booksetType]')},
        // 初始化申报期类型
        {fn: VgReq.getReportPeriodType, $ele: $filterForm.find('select[name=reportPeriodType]')},
        // 初始化适用行业
        {fn: VgReq.getApplicableIndustry, $ele: $filterForm.find('select[name=applicableIndustry]')},
        // 初始化账套难度等级
        {fn: VgReq.getDifficultyLevel, $ele: $filterForm.find('select[name=difficultyLevel]')},
        // 初始化存货核算
        {fn: VgReq.getStockAccounting, $ele: $filterForm.find('select[name=stockAccounting]')},
        // 初始化税表已设比例
        {fn: VgReq.getTaxTableStatus, $ele: $filterForm.find('select[name=status]')}
    ];
    $.each(initSelects, function (i, row) {
        VgReq.initSelect.call(This, row);
    });

    // 批量绑定select事件
    $filterForm.find('select[name]').each(function () {
        var $this = $(this);
        var filterName = $this.attr('lay-filter');
        if (!filterName) {
            return;
        }
        form.on('select(' + filterName + ')', reloadTable);
    });
    // 搜索框事件
    $filterForm.find('input[name=condition]').keyup(function (event) {
        if (event.keyCode === 13) {
            reloadTable();
        }
    });
    $filterForm.find('.vg-search-icon').mouseup(reloadTable);

    /**
     * val不为undefined/null/NaN/空字符串
     */
    function isEmpty(val) {
        return val === undefined || val === null || (val + '' === 'NaN') || val === '';
    }

    /**
     * 生成转换空的函数
     */
    function convertEmptyFn(field) {
        return function (d) {
            if (isEmpty(d[field])) {
                return '--';
            }
            return d[field];
        }
    }

    var tableId = 'table-id-bookset-data';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-bookset-data',
        url: '/booksetDatas', //数据接口
        cols: [[ //表头
            {type: 'checkbox', fixed: 'left'},
            {
                field: 'booksetCode', title: '账套编码', minWidth: 155, width: 155
            },
            {field: 'applicableAccountingType', title: '会计制度', minWidth: 90},
            {
                field: 'booksetType',
                title: '账套数据类型',
                templet: convertEmptyFn('booksetType'),
                minWidth: 120,
                width: 120
            },
            {
                field: 'reportPeriodType',
                title: '申报期类型',
                templet: convertEmptyFn('reportPeriodType'),
                minWidth: 100,
                width: 100
            },
            {
                field: 'applicableIndustry',
                title: '适用行业',
                templet: convertEmptyFn('applicableIndustry'),
                minWidth: 90,
                width: 90
            },
            {
                field: 'stockAccounting',
                title: '存货核算',
                templet: convertEmptyFn('stockAccounting'),
                minWidth: 120,
                width: 120
            },
            {
                field: 'difficultyLevel',
                title: '账套难度',
                templet: convertEmptyFn('difficultyLevel'),
                minWidth: 90,
                width: 90
            },
            {
                title: '清单数', minWidth: 75, templet: function (d) {
                    /*if (d.status === '未设置') {
                        return '--';
                    }*/
                    var keys = ['outputInvoice', 'inputInvoice', 'bankBill', 'costInvoice'];
                    $.each(keys, function (i, key) {
                        d[key] = +d[key] || 0;
                    });
                    if (d.outputInvoice + d.inputInvoice + d.bankBill + d.costInvoice === 0) {
                        return '--';
                    }
                    return laytpl('总数：{{ d.outputInvoice + d.inputInvoice + d.bankBill + d.costInvoice }}，' +
                        '销项{{ d.outputInvoice }}，' +
                        '进项{{ d.inputInvoice }}，' +
                        '银行清单{{ d.bankBill }}，' +
                        '费用票{{ d.costInvoice }}').render(d);
                }
            },
            {field: 'taxSpeciesIdentificationCount', title: '税种鉴定数', minWidth: 105, width: 105},
            {field: 'status', title: '账套数据设置状态', minWidth: 145, width: 145, templet: function (d) {
                if (d.status === '部分完成') {
                    var color = '#FFB800';
                } else if (d.status === '已完成设置') {
                    color = '#009688';
                } else {
                    color = '#FF5722';
                }
                return '<span style="color: ' + color + '">' + d.status + '</span>';
                }},
            {field: 'createUser', title: '创建人', minWidth: 80},
            {
                field: 'dataPackageUrl',
                title: '数据包',
                templet: '#laytpl-table-upload-data-package',
                minWidth: 115,
                width: 115,
                fixed: 'right'
            },
            {
                title: '操作', width: 85, minWidth: 85, fixed: 'right', templet: function (d) {
                    return laytpl(d.editable ? $('#laytpl-table-ops').html() : $('#laytpl-table-show-ops').html()).render(d);
                }
            }
        ]],
        done: function () {
            // 初始化上传数据包
            $('.upload-data-package').each(function () {
                var data = $(this).data();
                // 渲染上传文件
                upload.render({
                    elem: $(this), //绑定元素
                    url: '/booksetDatas/' + data.id + '/file', //上传接口
                    accept: 'file',
                    field: 'file',
                    exts: 'xls|xlsx|doc|docx|rar|zip',
                    extsTxt: '文件格式不支持，仅支持xls，xlsx，doc，docx，rar，zip',
                    before: function () {
                        layer.load();
                    },
                    done: function () {
                        layer.closeAll('loading');
                        layer.msg('上传账套数据包文件成功');
                        tableLns.reload();
                    },
                    error: function () {
                        var msg = '上传账套数据包文件失败';
                        var XMLHttpRequest = arguments[2];
                        if (XMLHttpRequest && XMLHttpRequest.responseJSON && XMLHttpRequest.responseJSON.errorMsg) {
                            msg = XMLHttpRequest.responseJSON.errorMsg;
                        }
                        //请求异常回调
                        layer.closeAll('loading');
                        layer.msg(msg);
                    }
                });
            });

            var clipboard = new ClipboardJS('.copy-data-package-url');
            clipboard.on('success', function (e) {
                layer.msg('复制成功');
                e.clearSelection();
            });
            clipboard.on('error', function (e) {
                layer.msg("复制失败");
            });
        }
    }));

    // 下载文件
    $body.on('click', '[vg-download]', function () {
        var data = $(this).data();
        data.url && window.open(data.url, '_blank');
    });

    /**
     * 重新加载表格到第一页
     */
    function reloadTable() {
        var formData = $filterForm.serializeObject();
        tableLns.reload({
            where: formData,
            page: {
                curr: 1
            }
        });
    }

    // 删除账套数据
    $body.on('click', '.table-btn-bookset-data-del', function () {
        var id = $(this).data('id');
        layer.confirm('<p class="vg-text-indent-2">确定清空此账套数据？</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'delete',
                    url: '/booksetDatas/' + id
                });
            })().done(function () {
                layer.msg("清空账套数据成功");
                tableLns.reload({
                    page: {
                        curr: 1
                    }
                });
            });
            layer.close(1);
        });
    });

    // 查看/设置/编辑账套数据
    $body.on('click', '.table-btn-bookset-data-show,.table-btn-bookset-data-set,.table-btn-bookset-data-edit', function () {
        var $this = $(this);
        var id = $this.data('id');
        var companyId = $this.data('company-id');
        var data = $this.data();
        var param = {
            id: id,
            companyId: companyId,
            editable: data['editable']
        };
        var tabId = data['tabId'] || 'tab-id-set-bookset-data';
        adminTab.del(tabId);
        adminTab.add({
            layId: tabId,
            title: data['tabTitle'] || '设置账套数据',
            url: 'pages/bookset-data/saveBooksetData.html?' + serialize(param),
            icon: 'fa-book'
        });
    });

    // 批量清空账套数据
    $('#btn-clear-bookset-data').click(function () {
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请选择需要清空账套数据的账套！");
            return;
        }

        layer.confirm('<p class="vg-text-indent-2">确定清空账套数据？</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'delete',
                    url: '/booksetDatas/answer/book-set-data/batch',
                    contentType: 'application/json',
                    type: 'DELETE',
                    data: JSON.stringify(ids)
                });
            })().done(function () {
                layer.msg("清空账套数据成功");
                tableLns.reload();
            });
            layer.close(1);
        });
    });

    laydate.render({
        elem: '#layer-add-bookset-data input[name=validPeriodStart]'
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});