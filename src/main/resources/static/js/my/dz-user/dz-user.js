var pers = checkPermission();

layui.use(['layer', 'table', 'form'], function () {
    var This = this;
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    var laytpl = layui.laytpl;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-dz-user]');
    // 代账用户保存表单
    var $saveDzUserForm = $('#layer-batch-save-dz-user form');
    // 账号设置表单
    var $updateDzUserForm = $('#layer-batch-edit-dz-suer form');
    var isSuperAdmin = userTools.isSuperAdmin();
    var isAdmin = userTools.isAdmin();
    var isEduAdmin = userTools.isEduAdmin();
    var isEduUser = userTools.isEduUser();


    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

    // 检查角色权限
    userTools.checkRole();

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

    // 刷新账号限制信息
    function refreshLimits() {
        if (!isEduAdmin && !isEduUser) {
            return;
        }

        $.ajax({
            url: '/daizhangUsers/user/limit',
            type: 'GET'
        }).done(function (data) {
            $.each(data, function (key, value) {
                data[key] = value || 0;
            });
            if (userTools.isEduAdmin()) {
                data.userAllow = data.maxAccountNum - data.maxUserAccountNum - data.currentAdminAccountNum;
            } else if (userTools.isEduUser()) {
                data.userAllow = data.maxAccountNum - data.currentAccountNum;
            }

            $('#capacity-text').text(laytpl('账号总数：{{ d.maxAccountNum }}，' +
                '已创建：{{ d.currentAccountNum }}，' +
                '可创建：{{ d.maxAccountNum - d.currentAccountNum }}，' +
                '同时在线账号上限：{{ d.maxOnlineNum }}').render(data))
                .show();
            $('#user-counts-tip').css('display', 'block')
                .find('span')
                .data('source', data)
                .text(laytpl('总账号数：{{ d.maxAccountNum }}，可开账号数：{{ d.userAllow }}')
                    .render(data));
        });
    }

    refreshLimits();

    // 初始化账号状态事件
    onSelect($filterForm.find('select[name=status]'), reloadTable);
    // 初始化创建人
    VgReq.initSelect.call(This, {
        fn: VgReq.getCreators,
        $ele: [$filterForm.find('select[name=createUsername]')], param: {
            type: 1
        }
    });
    onSelect($filterForm.find('select[name=createUsername]'), reloadTable);

    // 初始化表格
    var cols = [[ //表头
        {type: 'checkbox', fixed: 'left'},
        {field: 'username', title: '学生登录账号'},
        {field: 'currentUser', title: '当前使用者'},
        {field: 'password', title: '登录密码'},
        {field: 'statusDescribe', title: '账号状态'},
        {field: 'createUsername', title: '创建人', hide: !isAdmin && !isEduAdmin && !isSuperAdmin},
        {
            title: '账号创建时间', templet: function (d) {
                return dayjs(d.createTime).format('YYYY-MM-DD')
            }
        },
        {
            title: '账号到期时间', templet: function (d) {
                return dayjs(d.expireTime).format('YYYY-MM-DD')
            }
        }
    ]];
    if (!isAdmin) {
        // 系统管理员不能启用和停用
        cols[0].push({title: '操作', width: 60, templet: '#laytpl-table-ops', fixed: 'right'});
    }
    var tableId = 'table-id-dz-user';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-dz-user',
        url: '/daizhangUsers', //数据接口
        cols: cols
    }));

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

    $filterForm.find('input[name=condition]').keyup(function (event) {
        if (event.keyCode === 13) {
            reloadTable();
        }
    });
    $filterForm.find('.vg-search-icon').mouseup(reloadTable);

    // 启用和停用
    $('body').on('click', '.table-btn-dz-user-status', function () {
        var data = $(this).data();
        loadingMonitor(function () {
            return $.ajax({
                url: '/daizhangUsers/' + data.id + '/status/' + (+data.status === 1 ? 2 : 1),
                type: 'PUT'
            });
        })().done(function () {
            reloadTable();
        });
    });

    // 新增账号按钮
    var saveLayerIndex;
    $('#btn-add-dz-user').on('click', function () {
        // 重置表单
        $saveDzUserForm[0].reset();
        $saveDzUserForm.find('input[name=id]').val('');
        refreshLimits();

        saveLayerIndex = layer.open({
            id: 'layer-id-save-dz-user',
            type: 1,
            title: '新增账号',
            content: $('#layer-batch-save-dz-user'),
            area: '435px',
            resize: false
        })
    });

    $saveDzUserForm.find('input[name=userCounts]').on('focusout', function () {
        var data = $('#user-counts-tip span').data('source');
        if (!data) {
            return;
        }
        layuiTools.verify($(this), function (value) {
            if (+(value || 0) > data.userAllow) {
                return {
                    success: false,
                    msg: '账号已达上限，请联系管理员申请更多账号'
                };
            }
            return {
                success: true
            }
        })
    });

    form.on('radio(lay-filter-available-status-enable)', function () {
        var data = $('#user-counts-tip span').data('source');
        if (!data) {
            return;
        }

        if (userTools.isEduAdmin()) {
            var allow = data.maxOnlineNum - data.maxUserOnlineNum - data.currentAdminOnlineNum;
        } else if (userTools.isEduUser()) {
            allow = data.maxOnlineNum - data.currentOnlineNum;
        }
        if (allow < $saveDzUserForm.find('input[name=userCounts]').val()) {
            layer.msg('同时启用账号上限数为' + data.maxOnlineNum + '，已达上限，请先默认为关闭状态，在列表中选择开启！', {icon: 5, shift: 6});
            $saveDzUserForm.find('input[name=availableStatus][value=2]').prop('checked', true);
            form.render('radio', $saveDzUserForm.attr('lay-filter'));
        }
    });

    // 监听代账用户保存表单提交
    form.on('submit(submit-filter-save-dz-user)', function (data) {
        var params = data.field;

        loadingMonitor(function () {
            return $.ajax({
                url: '/daizhangUsers/batch',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(params)
            })
        })().done(function () {
            reloadTable();
            refreshLimits();
            layer.msg('新增成功');
            if (saveLayerIndex) {
                layer.close(saveLayerIndex);
            }
        });
        return false;
    });

    // 新增取消按钮
    $('#layer-batch-save-dz-user .vg-layer-btn-group .btn1').on('click', function () {
        layer.close(saveLayerIndex);
    });

    // 批量删除账号按钮
    $('#btn-batch-del-dz-user').on('click', function () {
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请先选择需要删除的账号！");
            return;
        }

        layer.confirm('<p class="vg-text-indent-2">确定删除所选账号？</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    url: '/daizhangUsers/ids',
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
                refreshLimits();
            });
            layer.close(1);
        });
    });

    // 账号设置
    var editLayerIndex;
    $('#btn-batch-edit-dz-user').on('click', function () {
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请先选择需要修改的账号！");
            return;
        }

        // 重置表单
        $updateDzUserForm[0].reset();
        $updateDzUserForm.find('.selected-count-label')
            .text(ids.length)
            .data('ids', ids);

        var $content = $('#layer-batch-edit-dz-suer');
        editLayerIndex = layer.open({
            id: 'layer-id-batch-edit-dz-suer',
            type: 1,
            title: '账号设置',
            content: $content,
            area: '435px',
            resize: false
        })
    });

    // 监听账号设置表单提交
    form.on('submit(submit-filter-edit-dz-user)', function (data) {
        var params = data.field;
        params.daizhangUserIds = $updateDzUserForm.find('.selected-count-label').data('ids');

        loadingMonitor(function () {
            return $.ajax({
                url: '/daizhangUsers/batch',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(params)
            })
        })().done(function () {
            reloadTable();
            layer.msg('修改成功');
            if (editLayerIndex) {
                layer.close(editLayerIndex);
            }
        });
        return false;
    });

    // 新增取消按钮
    $('#layer-batch-edit-dz-suer .vg-layer-btn-group .btn1').on('click', function () {
        layer.close(editLayerIndex);
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
            refreshLimits();
        }
    }
});