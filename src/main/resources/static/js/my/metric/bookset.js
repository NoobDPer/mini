var pers = checkPermission();

layui.use(['layer', 'laydate', 'table', 'form'], function () {
    var This = this;
    var table = layui.table;
    var form = layui.form;
    var laytpl = layui.laytpl;
    var laydate = layui.laydate;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-metric-bookset]');

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

    // 初始化select
    var initSelects = [
        // 初始化适用行业
        {fn: VgReq.getApplicableIndustry, $ele: $filterForm.find('select[name=applicableIndustry]')},
        // 初始化账套难度等级
        {fn: VgReq.getDifficultyLevel, $ele: $filterForm.find('select[name=difficultyLevel]')},
        // 初始化存货核算
        {fn: VgReq.getStockAccounting, $ele: $filterForm.find('select[name=stockAccounting]')}
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

    var tableId = 'table-id-metric-bookset';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-metric-bookset',
        url: '/declareMetric/booksets', //数据接口
        cols: [[ //表头
            {type: 'numbers', title: '排名'},
            {
                field: 'booksetCode', title: '账套编码', minWidth: 155,
                width: 155
            },
            {field: 'applicableAccountingType', title: '会计制度', minWidth: 90},
            {
                field: 'booksetType',
                title: '账套数据类型',
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
                field: 'applicableIndustry', title: '适用行业',
                templet: convertEmptyFn('applicableIndustry'),
                minWidth: 90,
                width: 90
            },
            {
                field: 'stockAccounting', title: '存货核算',
                templet: convertEmptyFn('stockAccounting'),
                minWidth: 120,
                width: 120
            },
            {
                field: 'difficultyLevel', title: '账套难度',
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
            {field: 'taxpayerSeniorityCount', title: '税种鉴定数', minWidth: 105, width: 105},
            {field: 'createUser', title: '创建人', minWidth: 80},
            {field: 'finishUserCount', title: '完成总用户数', minWidth: 120, width: 120},
            {
                field: 'avgMinutes', title: '完成时间', minWidth: 105, templet: function (d) {
                    if (d.avgMinutes === 0 || !d.avgMinutes) {
                        return '--';
                    }
                    return d.avgMinutes + 'min';
                }
            }
        ]]
    }));

    /**
     * 重新加载表格到第一页
     */
    function reloadTable() {
        var formData = $filterForm.serializeObject();
        delete formData.dateRange;
        tableLns.reload({
            where: formData,
            page: {
                curr: 1
            }
        });
    }

    laydate.render({
        elem: 'input[name=dateRange]',
        range: true,
        done: function (value) {
            var dates = LayuiTools.splitDateRange(value);
            if (!dates) {
                dates = ['', ''];
            }
            $filterForm.find('input[name=startTime]').val(dates[0]);
            $filterForm.find('input[name=finishTime]').val(dates[1]);
            reloadTable();
        }
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});