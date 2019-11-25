var pers = checkPermission();

layui.use(['layer', 'laydate', 'table', 'form', 'upload'], function () {
    var This = this;
    var table = layui.table;
    var form = layui.form;
    var laytpl = layui.laytpl;
    var laydate = layui.laydate;
    var upload = layui.upload;
    // 筛选表单
    var $filterForm = $('form[lay-filter=form-filter-tax-model]');
    // 新增税表模板表单
    var $saveFilterForm = $('form[lay-filter=form-filter-save-tax-model]');

    // 初始化select
    var initSelects = [
        // 纳税人资格类型
        {fn: VgReq.getTaxpayerSeniority, $ele: $filterForm.find('select[name=taxpayerSeniorityType]')},
        // 税种
        {fn: VgReq.getTaxKinds, $ele: $filterForm.find('select[name=taxKindId]')},
        // 纳税期限
        {fn: VgReq.getTaxPeriods, $ele: $filterForm.find('select[name=taxPayPeriod]')},
        // 纳税人资格类型
        {fn: VgReq.getTaxpayerSeniority, $ele: $saveFilterForm.find('select[name=taxpayerSeniorityType]')},
        // 会计制度
        {fn: VgReq.getAccounting, $ele: $saveFilterForm.find('select[name=applicableAccountingType]')},
        // 税种
        {fn: VgReq.getTaxKinds, $ele: $saveFilterForm.find('select[name=taxKindId]')},
        // 纳税期限
        {fn: VgReq.getTaxPeriods, $ele: $saveFilterForm.find('select[name=taxPayPeriod]')}
    ];
    $.each(initSelects, function (i, row) {
        VgReq.initSelect.call(This, row);
    });

    // 初始化筛选select事件
    var $selects = [$filterForm.find('select[name=taxpayerSeniorityType]'),
        $filterForm.find('select[name=taxKindId]'),
        $filterForm.find('select[name=taxPayPeriod]')];
    $.each($selects, function (i, $ele) {
        onSelect($ele, reloadTable);
    });
    $filterForm.find('input[name=condition]').keyup(function (event) {
        if (event.keyCode === 13) {
            reloadTable();
        }
    });
    $filterForm.find('.vg-search-icon').mouseup(reloadTable);

    // 初始化表格
    var tableId = 'table-id-tax-model';
    var tableLns = table.render(LayuiTools.extendTableDefaultParams({
        id: tableId,
        elem: '#table-tax-model',
        url: '/taxTableModels', //数据接口
        cols: [[ //表头
            {type: 'numbers', title: '序号', fixed: 'left'},
            {field: 'area', title: '行政划分', width: 95, minWidth: 95},
            {field: 'taxpayerSeniority', title: '纳税人资格类型', width: 160, minWidth: 160},
            {field: 'applicableAccounting', title: '会计制度', width: 200, minWidth: 200},
            {field: 'taxKind', title: '税种类型', width: 170, minWidth: 170},
            {field: 'taxSubject', title: '税目', width: 250, minWidth: 250},
            {field: 'taxPayPeriod', title: '纳税期限', width: 90, minWidth: 90},
            {field: 'taxTableName', title: '税表模板名称', minWidth: 120},
            {field: 'booksetCount', title: '已引用账套数', width: 120, minWidth: 120},
            {title: '操作', width: 90, minWidth: 90, templet: '#laytpl-table-ops', fixed: 'right'}
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

    // 删除税表模版
    var $body = $('body');
    $body.on('click', '.table-btn-tax-model-del', function () {
        var $this = $(this);
        var booksetCount = +($this.attr('data-bookset-count') || 0);
        if (booksetCount > 0) {
            layer.alert('<p class="vg-text-indent-2">此税表模板已经被' + booksetCount + '家企业引用，请先到企业删除对应税表后，才可删除此税表模板！</p>');
            return;
        }

        var id = $this.attr('data-id');
        layer.confirm('<p class="vg-text-indent-2">确定删除此税表模板？</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'delete',
                    url: '/taxTableModels/' + id
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

    // 保存税表模版弹窗索引
    var layerIndex;

    // 编辑税表模版
    $body.on('click', '.table-btn-tax-model-edit', function () {
        var filter = $saveFilterForm.attr('lay-filter');
        var $this = $(this);
        var booksetCount = +($this.attr('data-bookset-count') || 0);
        var id = $this.attr('data-id');
        loadingMonitor(function () {
                var d = $.Deferred();
                $.ajax({
                    url: '/taxTableModels/' + id,
                    type: 'GET',
                    dataType: 'JSON'
                }).done(function (data) {
                    form.val(filter, data);

                    // 重新设置时间
                    $saveFilterForm.find('input[name=validPeriodStart]').val(dayjs(data.validPeriodStart).format('YYYY-MM'));

                    // 设置引用数
                    $saveFilterForm.find('input[name=booksetCount]').val(booksetCount);

                    // 设置上传
                    var $btn = $('#btn-upload-model-file');
                    var $parent = $btn.parent();
                    $btn.find('span').text("重新上传");
                    $parent.find('.upload-file-name')
                        .text(data.fileName)
                        .prop('title', data.fileName);
                }).done(function (data) {
                    $.when(
                        // 设置税目
                        initDependSelect($saveFilterForm.find('select[name=taxSubjectId]')).done(function () {
                            $saveFilterForm.find('select[name=taxSubjectId]').val(data.taxSubjectId || '');
                            form.render('select', $saveFilterForm.attr('lay-filter'));
                        }),
                        // 设置模版名称
                        initDependSelect($saveFilterForm.find('select[name=taxTableName]')).done(function () {
                            $saveFilterForm.find('select[name=taxTableName]').val(data.taxTableName || '');
                            form.render('select', $saveFilterForm.attr('lay-filter'));
                        })
                    ).done(function () {
                        d.resolve();

                        layerIndex = layer.open({
                            id: 'layer-id-add-tax-model',
                            type: 1,
                            title: '编辑税表模版',
                            content: $('#layer-save-tax-model'),
                            area: '550px',
                            resize: false
                        });
                        if (window.innerHeight >= 650) {
                            // 高度等于650的时候不出现滚动条, 防止下拉框被遮挡
                            $('#layer-id-add-tax-model').css('overflow', 'visible');
                        }
                    }).fail(function () {
                        d.reject.apply(this, arguments);
                    });
                }).fail(function () {
                    d.reject.apply(this, arguments);
                });
                return d;
            }
        )();
    });

    // 新增税表模板
    $('#btn-save-tax-model').click(function () {
        // 重置表单
        $saveFilterForm[0].reset();
        $saveFilterForm.find('input[name=id]').val('');
        $saveFilterForm.find('input[name=booksetCount]').val('');
        // 重置上传
        var $btn = $('#btn-upload-model-file');
        var $parent = $btn.parent();
        $btn.find('span').text("上传");
        $parent.find('input[name=fileId]').val('');
        $parent.find('.upload-file-name')
            .text('')
            .prop('title', '');

        layerIndex = layer.open({
            id: 'layer-id-add-tax-model',
            type: 1,
            title: '新增税表模板',
            content: $('#layer-save-tax-model'),
            area: '550px',
            resize: false
        });
        if (window.innerHeight >= 650) {
            // 高度等于650的时候不出现滚动条, 防止下拉框被遮挡
            $('#layer-id-add-tax-model').css('overflow', 'visible');
        }
    });

    // 监听保存表单提交
    form.on('submit(submit-filter-save-tax-model)', function (data) {
        var id = data.field.id;
        if (id) {
            // 修改
            var booksetCount = +(data.field.booksetCount || 0);
            if (booksetCount > 0) {
                layer.alert('<p class="vg-text-indent-2">此税表模板已经被' + booksetCount + '家企业引用，请先到企业删除对应税表后，才可编辑此税表模板！</p>');
                return;
            }
        }

        layer.confirm('<p class="vg-text-indent-2">为保证校验准确性，请确认上传的模板已经用“#”标记出需校验的数据表格</p>', {
            btn: ['确定', '取消']
        }, function () {
            var params = data.field;
            delete params.booksetCount;
            // 增加税表id参数
            var smData = $saveFilterForm.find('select[name=taxTableName] option:selected')
                .data('source')
                .data;
            params['taxTableId'] = smData.ksbszid;

            loadingMonitor(function () {
                return $.ajax({
                    url: '/taxTableModels',
                    type: params.id ? 'PUT' : 'POST',
                    contentType: 'application/json',
                    dataType: 'JSON',
                    data: JSON.stringify(params)
                })
            })().done(function () {
                reloadTable();
                layer.msg(params.id ? '修改成功' : '新增成功');
                if (layerIndex) {
                    layer.close(layerIndex);
                }
            });
        });
        return false;
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
     */
    function initDependSelect($select) {
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
        var params = $form.serializeObject();
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
    $saveFilterForm.find('[data-vg-required-dp]').each(function () {
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

    // 保存弹窗取消按钮单击事件
    $('#layer-save-tax-model').find('.btn1').on('click', function () {
        layer.close(layerIndex);
    });

    // 渲染上传模板文件
    upload.render({
        elem: '#btn-upload-model-file', //绑定元素
        url: '/taxTableModels/upload/', //上传接口
        accept: 'file',
        exts: 'xls|xlsx',
        before: function () {
            layer.load();
        },
        done: function (res) {
            //上传完毕回调
            layer.msg('上传成功');
            layer.closeAll('loading');

            var $btn = $('#btn-upload-model-file');
            var $parent = $btn.parent();
            $btn.find('span').text("重新上传");
            $parent.find('input[name=fileId]').val(res.id);
            $parent.find('.upload-file-name')
                .text(res.originName)
                .prop('title', res.originName);
        },
        error: function () {
            //请求异常回调
            var msg = '上传模板文件失败';
            //请求异常回调
            var XMLHttpRequest = arguments[2];
            if (XMLHttpRequest && XMLHttpRequest.responseJSON && XMLHttpRequest.responseJSON.errorMsg) {
                msg = XMLHttpRequest.responseJSON.errorMsg;
            }

            layer.closeAll('loading');
            layer.msg(msg);
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