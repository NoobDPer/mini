var pers = checkPermission();

layui.use(['layer', 'laydate', 'table', 'form'], function () {
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    var laytpl = layui.laytpl;
    var laydate = layui.laydate;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-metric-user]');

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

    var tableId = 'table-id-metric-user';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-metric-user',
        url: '/declareMetric/users', //数据接口
        cols: [[ //表头
            {field: 'index', title: '排名', type: 'numbers'},
            {field: 'username', title: '学生登录名'},
            {field: 'currentUser', title: '当前使用者'},
            {field: 'firstCreateTime', title: '首次登录时间'},
            {field: 'finishCount', title: '完成账套数'},
            {
                field: 'avgMinutes', title: '单账套平均完成时间',
                templet: function (d) {
                    if (d.avgMinutes === 0 || !d.avgMinutes) {
                        return '--';
                    }
                    return d.avgMinutes + 'min';
                }
            },
            {title: '操作', width: 65, templet: '#laytpl-table-ops'}
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

// 完成账套详情
    $('body').on('click', '.table-btn-bookset-finished', function () {
        var userId = $(this).data('userId');
        adminTab.del('tab-id-metric-bookset-finished');
        adminTab.add({
            layId: 'tab-id-metric-bookset-finished',
            title: '完成账套详情',
            url: 'pages/metric/booksetFinished.html?userId=' + userId,
            icon: 'fa-users'
        });
    });

    // 用户历史记录
    $('#btn-show-history').on('click', function () {
        var id = $(this).data('id');
        adminTab.del('tab-id-metric-user-history');
        adminTab.add({
            layId: 'tab-id-metric-user-history',
            title: '用户历史记录',
            url: 'pages/metric/userHistory.html?id=' + id,
            icon: 'fa-users'
        });
    });

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
})
;