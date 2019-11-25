var id = getUrlParam("id");
var editable = getUrlParam('editable') === 'true';

layui.use(['layer', 'table', 'laytpl', 'form', 'laydate'], function () {
    var This = this;
    var layer = layui.layer;
    var table = layui.table;
    var laytpl = layui.laytpl;
    var form = layui.form;
    var laydate = layui.laydate;
    var adminTab = parent.adminTab || top.adminTab;
    // 企业表单
    var $saveForm = $('#form-save-company');
    // 税种鉴定表单
    var $saveSzjdForm = $('#form-save-szjd');
    var saveCompanyFromId = 'form-filter-save-company';
    // 编辑按钮
    var $enableBtn = $('#btn-enable-form');
    // 完善登记信息按钮
    var $updateInfoBtn = $('#btn-update-info');
    // 新增税种鉴定按钮
    var $addSzjdBtn = $('#btn-add-szjd');
    // 缓存企业信息
    var company;
    // 税种鉴定数据总数
    var szjdCount = 0;

    // 加载自定义验证规则
    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

    /**
     * 设置保存企业表单是否启用
     * @param enable true:启用 false:不启用
     */
    function setSaveCompanyFormEnable(enable) {
        setSaveCompanyFormEnable.enable = enable;
        // 纳税人识别号始终不给修改
        $saveForm.find('.layui-inline [name=taxpayerCode]').prop('disabled', true);
        // 设置表单input以及select状态
        $saveForm.find('.layui-inline [name][name!=taxpayerCode]').prop('disabled', !enable);

        // 设置保存按钮状态
        $('#btn-save-company-form')[enable ? 'show' : 'hide']();
        // 设置编辑按钮状态
        $enableBtn[enable ? 'hide' : 'show']();
        renderForm('select');

        // 设置税种鉴定
        setSzjdStatus(!enable);
    }

    /**
     * 设置税种鉴定的启用状态
     */
    function setSzjdStatus(enable) {
        setSzjdStatus.enable = enable;
        // 设置税种鉴定2个按钮
        var method = enable ? 'removeClass' : 'addClass';
        $addSzjdBtn[method]('layui-btn-disabled').prop('disabled', !enable);
        $('#btn-set-zt-data')[method]('layui-btn-disabled').prop('disabled', !enable);

        // 设置税种鉴定表格操作
        $('.table-btn-szjd-edit,.table-btn-szjd-del')[method]('layui-btn-disabled').prop('disabled', !enable);
    }

    if (id) {
        // 编辑企业, 禁止表单修改
        setSaveCompanyFormEnable(false);
        setSzjdStatus(true);

        if (!editable) {
            $('#btn-enable-form, #btn-add-szjd')
                .addClass('layui-btn-disabled')
                .prop('disabled', true);
        }
    } else {
        // 新增将editable设为true
        editable = true;

        // 新增企业
        $updateInfoBtn.addClass('layui-btn-disabled').prop('disabled', true);
        setSzjdStatus(false);
    }

    /**
     * 设置id, 由新增且为编辑
     * @param id 企业id
     */
    function setId(id) {
        if (!id) {
            return;
        }
        window.id = id;
        $saveForm.find('input[name=id]').val(id);
        $updateInfoBtn.removeClass('layui-btn-disabled').prop('disabled', false);
        renderForm('select');
        setSzjdStatus(true);
        tableIns.reload({
            url: '/taxSpeciesIdentifications/company-id/' + id
        });
    }

    // 税种鉴定列表
    var tableIns = table.render($.extend((id ? {
        url: '/taxSpeciesIdentifications/company-id/' + id
    } : {
        data: []
    }), {
        id: 'table-id-szjd',
        elem: '#table-szjd',
        page: false, //开启分页
        cols: [[ //表头
            {title: '序号', type: 'numbers'},
            {field: 'taxKind', title: '税种'},
            {field: 'taxPeriod', title: '纳税期限'},
            {field: 'taxTableName', title: '税表名称'},
            {
                field: 'taxValidPeriodStart', title: '有效期起',
                templet: function (d) {
                    return dayjs(d.taxValidPeriodStart).format('YYYY-MM')
                }
            },
            {
                title: '操作',
                width: 90,
                templet: function (d) {
                    return laytpl($('#laytpl-table-ops').html()).render($.extend(true, d, {
                        editable: editable
                    }));
                }
            }
        ]],
        response: {
            statusCode: 200
        },
        parseData: function (res) {
            res = res || [];
            return {
                code: 200,
                msg: '',
                count: res.length,
                data: res
            }
        },
        done: function (res, curr, count) {
            // 设置税种鉴定表格操作
            $('.table-btn-szjd-edit,.table-btn-szjd-del')
                [setSzjdStatus.enable ? 'removeClass' : 'addClass']('layui-btn-disabled')
                .prop('disabled', !setSzjdStatus.enable);

            szjdCount = count;
        }
    }));

    // 删除税种鉴定
    var $body = $('body');
    $body.on('click', '.table-btn-szjd-del', function () {
        var id = $(this).data('id');
        layer.confirm('<p class="vg-text-indent-2">确定删除所选税种鉴定？</p><p class="vg-text-indent-2 vg-warn-color">注：删除税种鉴定会删除对应税表数据！</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'delete',
                    url: '/taxSpeciesIdentifications/' + id
                });
            })().done(function () {
                layer.msg("删除成功");
                tableIns.reload({
                    page: {
                        curr: 1
                    }
                });
            });

            layer.close(1);
        });
    });

    $body.on('click', '.table-btn-szjd-edit', function () {
        var id = $(this).data('id');
        var filter = $saveSzjdForm.attr('lay-filter');
        loadingMonitor(function () {
            var d = $.Deferred();
            $.ajax({
                url: '/taxSpeciesIdentifications/' + id,
                type: 'GET',
                dataType: 'JSON'
            }).done(function (data) {
                // 查税表数据要用
                data.companyId = window.id;
                form.val(filter, data);

                // 重新设置时间
                $saveSzjdForm.find('input[name=taxValidPeriodStart]').val(dayjs(data.taxValidPeriodStart).format('YYYY-MM'));
            }).done(function (data) {
                // 设置税目
                var smD = initDependSelect($saveSzjdForm.find('select[name=taxSubjectId]'), data)
                    .done(function () {
                        $saveSzjdForm.find('select[name=taxSubjectId]').val(data.taxSubjectId || '');
                        form.render('select', filter);
                    });
                // 设置税表名称
                var sbmcD = initDependSelect($saveSzjdForm.find('select[name=taxTableModelId]'), data)
                    .done(function () {
                        $saveSzjdForm.find('select[name=taxTableModelId]').val(data.taxTableModelId || '');
                        form.render('select', filter);
                    });
                $.when(smD, sbmcD).done(function () {
                    d.resolve();
                    layerIndex = layer.open({
                        id: 'layer-id-szjd',
                        type: 1,
                        title: '编辑税种鉴定信息',
                        content: $('#layer-save-szjd'),
                        area: '400px',
                        resize: false
                    })
                }).fail(function () {
                    d.reject.apply(this, arguments);
                });
            }).fail(function () {
                d.reject.apply(this, arguments);
            });
            return d;
        })();
    });

    /**
     * 渲染过滤数据form
     */
    function renderForm(type) {
        form.render(type || null, saveCompanyFromId);
    }

    // 设置企业表单初始数据
    function setSaveCompanyForm(data) {
        // 处理启用期间
        data.startDate = '' + data.startYear + '-' + (data.startMonth < 10 ? '0' + data.startMonth : data.startMonth);
        form.val(saveCompanyFromId, data);
        // 设置初始值
        $.each($saveForm.find('[name=applicableAccountingType],[name=taxpayerSeniorityType],[name=startDate]'), function (i, ele) {
            var $ele = $(ele);
            $ele.attr('data-init-value', data[$ele.attr('name')])
                .removeAttr('data-change')
                .parent()
                .find('.vg-tip')
                .hide();
        });
        renderForm();

        // 刷新税种鉴定信息
        tableIns.reload();
    }

    /**
     * 加载保存企业信息表单
     * @param id 企业id
     */
    function loadSaveCompanyForm(id) {
        return $.ajax({
            url: '/companys/' + id,
            type: 'GET',
            dataType: 'json'
        }).done(function (data) {
            company = data;
            setSaveCompanyForm(data);
        });
    }

    // 初始化 启用期限
    laydate.render({
        elem: $saveForm.find('[name=startDate]')[0],
        type: 'month',
        value: id ? null : '2019-01',
        min: '2019-01-01 00:00:00',
        max: '2019-12-31 23:59:59',
        done: function (value) {
            var $date = $saveForm.find('input[name=startDate]');
            var initValue = $date.attr('data-init-value');
            var change = initValue !== value;
            $date.attr('data-change', change)
                .parent()
                .find('.vg-tip')[change && szjdCount > 0 ? 'show' : 'hide']();
        }
    });

    // 初始化企业信息中的select
    $.when(
        // 初始化会计准则
        VgReq.initSelect.call(This, {
            fn: VgReq.getAccounting,
            $ele: $saveForm.find('select[name=applicableAccountingType]')
        }),
        // 初始纳税人资格
        VgReq.initSelect.call(This, {
            fn: VgReq.getTaxpayerSeniority,
            $ele: $saveForm.find('select[name=taxpayerSeniorityType]')
        })).done(function () {
        if (!id) {
            return;
        }
        loadSaveCompanyForm(id);
    });

    // 初始化 适用会计制度和纳税人资格 select选择事件
    $.each($saveForm.find('[name=applicableAccountingType],[name=taxpayerSeniorityType]'), function (i, ele) {
        onSelect($(ele), function (data) {
            if (!id) {
                // 没有id是新增
                return;
            }

            var initValue = $(data.elem).attr('data-init-value');
            var change = +initValue !== +data.value;
            $(data.elem)
                .attr('data-change', change)
                .parent()
                .find('.vg-tip')[change && szjdCount > 0 ? 'show' : 'hide']();
        });
    });

    // 初始化保存税种鉴定信息弹窗select
    var initSzjdSelects = [
        // 税种
        {fn: VgReq.getTaxKinds, $ele: $saveSzjdForm.find('select[name=taxKindId]')},
        // 纳税期限
        {fn: VgReq.getTaxPeriods, $ele: $saveSzjdForm.find('select[name=taxPeriodId]')}
    ];
    $.each(initSzjdSelects, function (i, row) {
        VgReq.initSelect.call(This, row);
    });

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

    /**
     * 初始化有依赖关系的select
     * fromData:指定参数数据, 而不是自动获取表单数据
     */
    function initDependSelect($select, fromData) {
        var dp = $select.attr('data-vg-required-dp');
        var dps = dp ? dp.split(',') : undefined;
        if (!dps) {
            return;
        }
        var $form = $select.parentsUntil('.layui-form').parent();

        // 还原select
        $select.val('');
        $select.find('option[value!=""]').remove();
        form.render('select', $form.attr('lay-filter'));

        // 重新加载select
        var params = fromData || $form.serializeObject();
        var flag = true;
        var reqPrams = {};
        $.each(dps, function (j, jdp) {
            if (!params[jdp]) {
                flag = false;
                return false;
            }
            reqPrams[jdp] = params[jdp];
        });
        if (flag) {
            return VgReq.initSelect.call(This, {
                fn: VgReq[$select.attr('data-vg-req-method')],
                param: reqPrams,
                $ele: $select
            });
        }
        return $.Deferred().resolve();
    }

    // 初始化依赖select
    $saveSzjdForm.find('[data-vg-required-dp]').each(function () {
        var $this = $(this);
        var dp = $this.attr('data-vg-required-dp');
        var dps = dp ? dp.split(',') : undefined;
        if (!dps) {
            return;
        }
        var $form = $this.parentsUntil('.layui-form').parent();

        $.each(dps, function (i, dp) {
            onSelect($form.find('[name=' + dp + ']'), function () {
                initDependSelect($this);
            });
        });

    });

    function saveCompany(cd) {
        // 处理启用期间
        if (cd.startDate) {
            var startDates = cd.startDate.split('-');
            cd.startYear = startDates[0];
            cd.startMonth = startDates[1];
            delete cd.startDate
        }
        return loadingMonitor(function () {
            return $.ajax({
                url: '/companys',
                type: cd.id ? 'PUT' : 'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(cd)
            }).done(function (data) {
                company = data;
                setId(data.id);
                setSaveCompanyForm(data);
            });
        })().done(function () {
            layer.msg('保存成功');
            setSaveCompanyFormEnable(false);

            // 关联更新 完善登记信息
            var layids = ['tab-id-company-update-info'];
            $.each(layids, function (i, layid) {
                var win = adminTab.getTabWindow(layid);
                if (win && win.publicMethods && win.publicMethods.refresh) {
                    win.publicMethods.refresh(id);
                }
            })
        });
    }

    // 监听新增企业表单提交
    form.on('submit(btn-filter-save-company)', function (data) {
        // 检查会计制度和纳税人资格以及启用期间是否发生了改变
        var $checkChanges = $saveForm.find('[name=applicableAccountingType][data-change=true],[name=taxpayerSeniorityType][data-change=true],[name=startDate][data-change=true]');
        var change = $checkChanges.length > 0;
        if (change && szjdCount > 0) {
            // 会计制度和纳税人资格以及启用期间是否发生了改变并且有税种时提示
            layer.confirm('<p class="vg-text-indent-2">' + $checkChanges.first().attr('data-change-msg') + '</p>', {
                btn: ['确定', '取消']
            }, function () {
                saveCompany(data.field);
                layer.close(1);
            });
        } else {
            saveCompany(data.field);
        }
        return false;
    });

    // 完善登记信息
    $updateInfoBtn.on('click', function () {
        var params = {
            id: id,
            editable: editable
        };
        adminTab.del('tab-id-company-update-info');
        adminTab.add({
            layId: 'tab-id-company-update-info',
            title: '完善登记信息',
            url: 'pages/company/updateInfo.html?' + serialize(params),
            icon: 'fa-university'
        });
        return false;
    });

    // 保存税种鉴定弹窗索引
    var layerIndex;
    // 新增税种鉴定按钮
    $addSzjdBtn.on('click', function () {
        if ($(this).hasClass('layui-btn-disabled')) {
            return;
        }

        // 重置表单
        $saveSzjdForm[0].reset();
        $saveSzjdForm.find('input[name=id]').val('');
        // 查税表数据要用
        $saveSzjdForm.find('input[name=companyId]').val(id);

        layerIndex = layer.open({
            id: 'layer-id-szjd',
            type: 1,
            title: '新增税种鉴定信息',
            content: $('#layer-save-szjd'),
            area: '400px',
            resize: false
        })
    });

    // 设置账套数据
    $body.on('click', '#btn-set-zt-data', function () {
        var param = {
            id: company.booksetDataId,
            companyId: company.id,
            editable: editable
        };
        adminTab.del('tab-id-set-bookset-data');
        adminTab.add({
            layId: 'tab-id-set-bookset-data',
            title: '设置账套数据',
            url: 'pages/bookset-data/saveBooksetData.html?' + serialize(param),
            icon: 'fa-book'
        });
    });

    // 监听保存税种鉴定表单提交
    form.on('submit(submit-filter-save-szjd)', function (data) {
        var params = data.field;
        // 企业id
        params.companyId = id;

        loadingMonitor(function () {
            return $.ajax({
                url: '/taxSpeciesIdentifications',
                type: params.id ? 'PUT' : 'POST',
                contentType: 'application/json',
                dataType: 'JSON',
                data: JSON.stringify(params)
            })
        })().done(function () {
            tableIns.reload();
            layer.msg(params.id ? '修改成功' : '新增成功');
            if (layerIndex) {
                layer.close(layerIndex);
            }
        });
        return false;
    });

    // 编辑按钮事件
    $enableBtn.on('click', function () {
        setSaveCompanyFormEnable(true);
        return false;
    });

    // 保存弹窗取消按钮单击事件
    $('#layer-save-szjd').find('.btn1').on('click', function () {
        layer.close(layerIndex);
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            id && tableIns.reload();
        },
        refresh: function (companyId) {
            if (!id || companyId !== id) {
                return;
            }
            loadSaveCompanyForm(id);
        }
    }
});
