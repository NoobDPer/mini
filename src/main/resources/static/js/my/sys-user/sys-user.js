var pers = checkPermission();

layui.use(['layer', 'table', 'form', 'laydate'], function () {
    var This = this;
    var table = layui.table;
    var form = layui.form;
    var laytpl = layui.laytpl;
    var laydate = layui.laydate;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-sys-user]');
    // 保存账号弹窗
    var $saveForm = $('#layer-save-sys-user form');
    var $eye = $('#eye');
    var $password = $('#password');

    $eye.on('click', function () {
        if ($password.attr("type") == "password") {
            $password.attr("type", "text");
            $eye.removeClass('fa-eye');
            $eye.addClass('fa-eye-slash');
        }else {
            $password.attr("type", "password");
            $eye.removeClass('fa-eye-slash');
            $eye.addClass('fa-eye');
        }
    });
    // // 账号状态
    // var STATUS = {
    //     0: '无效',
    //     1: '正常',
    //     2: '锁定'
    // };

    // userTools.checkRole();

    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

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


    // 初始化select
    var initSelects = [
        {fn: miniReq.getAllRoles, $ele: $filterForm.find('select[name=roleId]')},
        {fn: miniReq.getUserStatus, $ele: $filterForm.find('select[name=state]')}
    ];
    $.each(initSelects, function (i, row) {
        miniReq.initSelect.call(This, row);
    });
    // 批量绑定select事件
    $filterForm.find('select[name]').each(function () {
        onSelect($(this), reloadTable);
    });

    // 初始化表格
    var tableId = 'table-id-sys-user';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-sys-user',
        url: '/users', //数据接口
        parseData: function (res) {
            return {
                code: 200,
                msg: '',
                count: res.result.total,
                data: res.result.data
            }
        },
        cols: [[ //表头
            // {type: 'checkbox', fixed: 'left'},
            {field: 'username', title: '登录名', minWidth: 100},
            {field: 'phone', title: '手机号', width: 120, minWidth: 120},
            {field: 'nickname', title: '昵称', minWidth: 90},
            {field: 'roleName', title: '角色', width: 135, minWidth: 135},
            {field: 'currentLoginTime', title: '当前登录时间', width: 160, templet: function (d) {
                    return d.currentLoginTime ? dayjs(d.currentLoginTime).format('YYYY-MM-DD HH:mm:ss') : "--";
                }
            },
            {field: 'lastLoginTime', title: '上次登录时间', width: 160, templet: function (d) {
                    return d.lastLoginTime ? dayjs(d.lastLoginTime).format('YYYY-MM-DD HH:mm:ss') : "--";
                }},
            {field: 'createTime', title: '创建时间', minWidth: 120, templet: function (d) {
                    return d.createTime ? dayjs(d.createTime).format('YYYY-MM-DD') : "--";
                }},
            {field: 'stateDesc', title: '账号状态', minWidth: 120},
            {
                title: '操作',
                width: 90,
                minWidth: 90,
                fixed: 'right',
                templet: function (d) {
                    return laytpl($('#laytpl-table-ops').html()).render(d);
                }
            }
        ]]
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
    $filterForm.find('.mini-search-icon').mouseup(reloadTable);


    /**
     * 清空数据
     */
    function initSaveFrom() {
        $saveForm[0].reset();
        ['input[name=id]', 'input[name=username]', 'input[name=phone]', 'input[name=password]', 'input[name=nickname]'].forEach(function (ele) {
            $saveForm.find(ele).val('');
        });
        $saveForm.find('input[name=roleId]').val('99');
    }

    /**
     * 删除系统管理员和教育机构管理员
     * @param msg 确认文本
     * @param id 要删除的用户id
     */
    function deleteUser(msg, id) {
        layer.confirm('<p class="mini-text-indent-2">' + msg + '</p>', {
            btn: ['确定', '取消']
        }, function (index) {
            loadingMonitor(function () {
                return $.ajax({
                    url: '/users/user/' + id,
                    type: 'DELETE'
                });
            })().done(function () {
                layer.msg("删除成功");
                tableLns.reload({
                    page: {
                        curr: 1
                    }
                });
            });
            layer.close(index);
        });
    }

    // 表格删除按钮
    var $body = $('body');
    $body.on('click', '.table-btn-sys-user-del', function () {
        var data = $(this).data();
        deleteUser("确认删除该账号？", data.id);
    });

    // 表格编辑按钮
    $body.on('click', '.table-btn-sys-user-edit', function () {
        var $this = $(this);
        var id = $this.data('id');
        var title = '编辑账号';

        initSaveFrom();
        loadingMonitor(function () {
            return $.ajax({
                url: '/users/' + id,
                type: 'GET',
                dataType: 'JSON'
            }).done(function (data) {
                form.val($saveForm.attr('lay-filter'), data);
                $saveForm.find('[name=password]').removeAttr("required");
                $saveForm.find('[name=password]').attr("lay-verify", "regex");
                $('#layer-password-label').removeClass("mini-required");
            })
        })().done(function () {
            saveLayerIndex = layer.open({
                id: 'layer-id-save-sys-user',
                type: 1,
                title: title,
                content: $('#layer-save-sys-user'),
                area: '460px',
                resize: false
            })
        });
    });

    // 新增账号按钮
    var saveLayerIndex;
    $('#btn-add-sys-user').on('click', function () {
        initSaveFrom();
        $saveForm.find('[name=password]').attr("required", "required");
        $saveForm.find('[name=password]').attr("lay-verify", "required|regex");
        $('#layer-password-label').addClass("mini-required");
        saveLayerIndex = layer.open({
            id: 'layer-id-save-sys-user',
            type: 1,
            title: '新增账号',
            content: $('#layer-save-sys-user'),
            area: '460px',
            resize: false
        })
    });
    // 保存弹窗取消按钮单击事件
    $saveForm.find('.btn-save-sys-user .btn1').on('click', function () {
        layer.close(saveLayerIndex);
    });

    // 监听保存表单提交
    form.on('submit(submit-filter-save-sys-user)', function (data) {
        var params = data.field;
        loadingMonitor(function () {
            return $.ajax({
                url: '/users',
                type: 'POST',
                contentType: 'application/json',
                dataType: 'JSON',
                data: JSON.stringify(params)
            })
        })().done(function () {
            reloadTable();
            layer.msg(params.id ? '修改成功' : '新增成功');
            if (saveLayerIndex) {
                layer.close(saveLayerIndex);
            }
        });
        return false;
    });

    // 批量删除账号按钮
    $('#btn-batch-del-sys-user').on('click', function () {
        var checkStatus = table.checkStatus(tableId);
        var ids = $.map(checkStatus.data, function (row) {
            if (!userTools.isEduUser(row.roleId)) {
                throw new Error("批量删除操作异常");
            }
            return row.id
        });
        if (!ids || ids.length === 0) {
            layer.msg("请先选择需要删除的账号！");
            return;
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