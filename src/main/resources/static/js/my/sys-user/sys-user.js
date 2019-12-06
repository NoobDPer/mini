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
        cols: [[ //表头
            {type: 'checkbox', fixed: 'left'},
            {field: 'username', title: '登录名', minWidth: 100},
            {field: 'phone', title: '手机号', width: 120, minWidth: 120},
            {field: 'nickname', title: '昵称', minWidth: 90},
            {field: 'roleName', title: '角色', width: 135, minWidth: 135},
            {field: 'currentLoginTime', title: '当前登录时间', width: 160, templet: function (d) {
                    return dayjs(d.currentLoginTime).format('YYYY-MM-DD HH:mm:ss')
                }
            },
            {field: 'lastLoginTime', title: '上次登录时间', width: 160, templet: function (d) {
                    return dayjs(d.lastLoginTime).format('YYYY-MM-DD')
                }},
            {field: 'createTime', title: '创建时间', minWidth: 120},
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

    // /**
    //  * 删除系统管理员和教育机构管理员
    //  * @param msg 确认文本
    //  * @param oldId 要删除的用户id
    //  * @param newId 要分配的用户id
    //  */
    // function deleteUser(msg, oldId, newId) {
    //     function inner() {
    //         return loadingMonitor(function () {
    //             if (!newId) {
    //                 // 不需要分配
    //                 var url = '/users/' + oldId;
    //             } else {
    //                 // 分配新用户id
    //                 url = '/users/' + oldId + '/assignment/' + newId;
    //             }
    //             return $.ajax({
    //                 url: url,
    //                 type: 'DELETE'
    //             });
    //         })().done(function () {
    //             layer.msg("删除成功");
    //             tableLns.reload({
    //                 page: {
    //                     curr: 1
    //                 }
    //             });
    //             refreshCapacity();
    //         });
    //     }
    //
    //     if (!msg) {
    //         return inner();
    //     }
    //
    //     layer.confirm('<p class="vg-text-indent-2">' + msg + '</p>', {
    //         btn: ['确定', '取消']
    //     }, function (index) {
    //         inner();
    //         layer.close(index);
    //     });
    // }

    // // 表格删除按钮
    // var $body = $('body');
    // $body.on('click', '.table-btn-sys-user-del', function () {
    //     var data = $(this).data();
    //     var id = data.id;
    //     var roleId = data.roleId;
    //
    //     if (userTools.isEduUser(roleId)) {
    //         // 培训讲师时调批量删除接口
    //         batchDeleteEduUser([id]);
    //         return;
    //     }
    //
    //     // 检查所选账号下是否已创建代账账号
    //     $.ajax({
    //         url: '/users/children/exits-status/' + id,
    //         type: 'GET',
    //         dataType: 'text'
    //     }).done(function (data) {
    //         if (data === 'false') {
    //             // 不存在子账号
    //             deleteUser('确定删除所选账号？', id);
    //             return;
    //         }
    //
    //         if (userTools.isEduAdmin(roleId)) {
    //             // 需要删除的是教育机构管理员
    //             deleteUser('删除此管理员账号，将同步删除其创建的所有教育机构讲师账号和平台所有账号，确定删除！', id);
    //         } else if (userTools.isAdmin(roleId)) {
    //             // 需要删除的是系统管理员
    //             layer.confirm('<p class="vg-text-indent-2">此管理员下已创建子账号，删除此系统管理员需将其子账号分配给其他系统管理员！</p>', {
    //                 btn: ['去分配', '取消']
    //             }, function (index) {
    //                 layer.close(index);
    //
    //                 // 初始化查询可分配管理员
    //                 loadingMonitor(function () {
    //                     return VgReq.initSelect.call(This, {
    //                         $ele: $('#layer-distribution select[name=newId]'),
    //                         fn: function () {
    //                             var d = $.Deferred();
    //                             $.ajax({
    //                                 url: '/users/user/admin/' + id,
    //                                 type: 'GET'
    //                             }).done(function (data) {
    //                                 d.resolve($.map(data, function (row) {
    //                                     return {
    //                                         val: row.id,
    //                                         text: row.username,
    //                                         data: row
    //                                     };
    //                                 }));
    //                             }).fail(function () {
    //                                 d.reject();
    //                             });
    //                             return d;
    //                         }
    //                     })
    //                 })().done(function () {
    //                     layer.open({
    //                         id: 'layer-id-distribution',
    //                         type: 1,
    //                         title: '分配',
    //                         content: $('#layer-distribution'),
    //                         area: '460px',
    //                         resize: false,
    //                         btn: ['确定', '取消'],
    //                         yes: function (index) {
    //                             var success = layuiTools.verify($fpLayer.find('select[name=newId]'), function (val) {
    //                                 return {
    //                                     success: val && true || false,
    //                                     msg: '必填项不能为空'
    //                                 }
    //                             });
    //                             if (!success) {
    //                                 return;
    //                             }
    //
    //                             var newId = $fpLayer.find('select[name=newId]').val();
    //                             deleteUser('', id, newId);
    //                             layer.close(index);
    //                         }
    //                     })
    //                 });
    //             });
    //         }
    //     });
    // });

    // // 表格编辑按钮
    // $body.on('click', '.table-btn-sys-user-refresh,.table-btn-sys-user-edit', function () {
    //     var $this = $(this);
    //     var id = $this.data('id');
    //     var title = '编辑账号';
    //
    //     loadingMonitor(function () {
    //         return $.ajax({
    //             url: '/users/' + id,
    //             type: 'GET',
    //             dataType: 'JSON'
    //         }).done(function (data) {
    //             initSaveFrom({
    //                 initRole: {val: data.roleId, text: data.roleName},
    //                 companyName: data.companyName
    //             });
    //             form.val($saveForm.attr('lay-filter'), data);
    //             $saveForm.find('[name=companyName]')
    //                 .prop('disabled', !userTools.isEduAdmin());
    //         })
    //     })().done(function () {
    //         saveLayerIndex = layer.open({
    //             id: 'layer-id-save-sys-user',
    //             type: 1,
    //             title: title,
    //             content: $('#layer-save-sys-user'),
    //             area: '460px',
    //             resize: false
    //         })
    //     });
    // });

    /**
     * 初始化表单
     */
    // function initSaveFrom(options) {
    //     $saveForm[0].reset();
    //     $saveForm.find('input[name=id]').val('');
    //     // 删除动态创建的元素
    //     $saveForm.find('[data-script-id]').empty().remove();
    //
    //     // 初始化角色框
    //     var $roleInline = $('#div-save-from-role-id').empty();
    //     var $roleItem = $roleInline.parents('.layui-form-item');
    //
    //     function initByRole(role) {
    //         if (!userTools.isAdmin(role.val)) {
    //             // 非系统管理员有 可创建账号总数上限和同时在线账号数上限
    //             $roleItem.after($('#laytpl-role-relation').html());
    //         }
    //         if (userTools.isAdmin(role.val)) {
    //             // 系统管理员, 所属企业为 云帐房
    //             $roleItem.after(laytpl($('#laytpl-input-compnay-name').html()).render({
    //                 companyName: '云帐房'
    //             }));
    //         } else if (userTools.isEduAdmin(role.val)) {
    //             $roleItem.after(laytpl($('#laytpl-input-compnay-name').html()).render({
    //                 companyName: ''
    //             }));
    //             $saveForm.find('input[name=companyName]').prop('disabled', false);
    //         } else if (userTools.isEduUser(role.val)) {
    //             if (userTools.isEduAdmin()) {
    //                 // 教育机构管理员, 所属企业为其教育机构
    //                 $roleItem.after(laytpl($('#laytpl-input-compnay-name').html()).render({
    //                     companyName: userTools.getCompanyName()
    //                 }));
    //             } else {
    //                 // 超级管理员和系统管理员, 所属企业为下拉
    //                 $roleItem.after($('#laytpl-select-compnay-name').html());
    //                 var df = VgReq.initSelect.call(This, {
    //                     $ele: $saveForm.find('select[name=companyName]'),
    //                     fn: getCompanys
    //                 });
    //                 if (options.companyName) {
    //                     df.done(function () {
    //                         var $select = $saveForm.find('select[name=companyName]').val(options.companyName);
    //                         form.render('select', $select.parentsUntil('form').parent().attr('lay-filter'));
    //                     })
    //                 }
    //             }
    //         }
    //         if (!userTools.isEduUser(role.val) && !userTools.isAdmin(role.val)) {
    //             // 培训讲师和系统管理员没有使用期限
    //             $saveForm.find('.btn-save-sys-user').before($('#layer-dateRange').html());
    //             laydate.render({
    //                 elem: 'input[name=expireDate]',
    //                 range: false,
    //                 min: 0
    //             });
    //         }
    //     }
    //
    //     // 如果是编辑则使用初始化角色, 新增
    //     var roles = (options && options.initRole && [options.initRole]) || getRoles();
    //     if (roles.length > 1) {
    //         var $select = $('<select name="roleId" lay-verify="required" lay-filter="select-filter-save-role">' +
    //             '<option value="">请选择</option>' +
    //             '</select>').appendTo($roleInline);
    //         VgReq.initSelect.call(This, {data: getRoles(), $ele: $select});
    //
    //         onSelect($select, function (data) {
    //             // 初始化可创建账号总数上限, 同时在线账号数上限
    //             $saveForm.find('[data-script-id]').empty().remove();
    //             if (data.value === '') {
    //                 return;
    //             }
    //             initByRole({val: data.value});
    //         });
    //     } else {
    //         var $input = $('<input type="text" class="layui-input" lay-verify="required" disabled>')
    //             .appendTo($roleInline);
    //         var role = roles[0];
    //         if (role) {
    //             $input.val(role.text);
    //             $('<input type="hidden" name="roleId">')
    //                 .val(role.val)
    //                 .appendTo($roleInline);
    //             initByRole(role);
    //         }
    //     }
    // }


    // // 新增账号按钮
    // var saveLayerIndex;
    // $('#btn-add-sys-user').on('click', function () {
    //     initSaveFrom();
    //
    //     saveLayerIndex = layer.open({
    //         id: 'layer-id-save-sys-user',
    //         type: 1,
    //         title: '新增账号',
    //         content: $('#layer-save-sys-user'),
    //         area: '460px',
    //         resize: false
    //     })
    // });
    // 保存弹窗取消按钮单击事件
    // $saveForm.find('.btn-save-sys-user .btn1').on('click', function () {
    //     layer.close(saveLayerIndex);
    // });

    // 监听保存表单提交
    form.on('submit(submit-filter-save-sys-user)', function (data) {
        var params = data.field;
        loadingMonitor(function () {
            return $.ajax({
                url: '/users',
                type: params.id ? 'PUT' : 'POST',
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