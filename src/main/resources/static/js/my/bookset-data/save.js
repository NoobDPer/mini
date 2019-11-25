var id = getUrlParam("id");
var companyId = getUrlParam('companyId');
var editable = getUrlParam('editable') === 'true';
var pers = checkPermission();

layui.use(['layer', 'table', 'form', 'upload', 'laydate'], function () {
    var This = this;
    var table = layui.table;
    var adminTab = parent.adminTab || top.adminTab;
    var form = layui.form;
    var upload = layui.upload;
    var laytpl = layui.laytpl;
    var laydate = layui.laydate;

    // 初始化延迟对象, 全部结束后加载数据
    var initDefs = [];
    // 初始化各种select
    var $formDp = $('#form-data-package');
    var $formSc = $('#form-show-company');

    // 可编辑状态
    if (!editable) {
        $('button[lay-filter=submit-filter-bookset-data]')
            .addClass('layui-btn-disabled')
            .prop('disabled', true);
        $formDp.find('input, select').prop('disabled', true);
    }

    // 初始化select
    var initSelects = [
        // 初始化账套数据类型
        {fn: VgReq.getBooksetType, $ele: $formDp.find('select[name=booksetType]')},
        // 初始化申报期类型
        {fn: VgReq.getReportPeriodType, $ele: $formDp.find('select[name=reportPeriodType]')},
        // 初始化适用行业
        {fn: VgReq.getApplicableIndustry, $ele: $formDp.find('select[name=applicableIndustry]')},
        // 初始化账套难度等级
        {fn: VgReq.getDifficultyLevel, $ele: $formDp.find('select[name=difficultyLevel]')},
        // 初始化存货核算
        {fn: VgReq.getStockAccounting, $ele: $formDp.find('select[name=stockAccounting]')},
        // 初始化税表已设比例
        {fn: VgReq.getTaxTableStatus, $ele: $formDp.find('select[name=status]')},
        // 初始化适用会计制度
        {fn: VgReq.getAccounting, $ele: $formSc.find('select[name=applicableAccountingType]')},
        // 初始化纳税人资格
        {fn: VgReq.getTaxpayerSeniority, $ele: $formSc.find('select[name=taxpayerSeniorityType]')}
    ];
    $.each(initSelects, function (i, row) {
        initDefs.push(VgReq.initSelect.call(This, row));
    });

    /**
     * 初始化上传数据包按钮组
     */
    function renderUploadDataPackage(url) {
        var html = laytpl($('#laytpl-upload-data-package').html()).render({
            url: url,
            editable: editable
        });
        $('.upload-data-package-btn-group').empty().append(html);

        var clipboard = new ClipboardJS('.copy-data-package-url');
        clipboard.on('success', function (e) {
            layer.msg('复制成功');
            e.clearSelection();
        });
        clipboard.on('error', function (e) {
            layer.msg("复制失败");
        });

        // 渲染上传数据包
        upload.render({
            elem: $('.upload-data-package'), //绑定元素
            url: '/booksetDatas/' + id + '/file', //上传接口
            accept: 'file',
            field: 'file',
            exts: 'xls|xlsx|doc|docx|rar|zip',
            extsTxt: '文件格式不支持，仅支持xls，xlsx，doc，docx，rar，zip',
            before: function () {
                layer.load();
            },
            done: function (data) {
                layer.closeAll('loading');
                layer.msg('上传账套数据包文件成功');
                renderUploadDataPackage(data.result);
            },
            error: function () {
                var msg = '上传账套数据包文件失败';
                //请求异常回调
                var XMLHttpRequest = arguments[2];
                if (XMLHttpRequest && XMLHttpRequest.responseJSON && XMLHttpRequest.responseJSON.errorMsg) {
                    msg = XMLHttpRequest.responseJSON.errorMsg;
                }
                //请求异常回调
                layer.closeAll('loading');
                layer.msg(msg);
            }
        });
    }

    // 初始化 启用期限
    laydate.render({
        elem: $formSc.find('[name=startDate]')[0],
        type: 'month',
        min: '2019-01-01 00:00:00',
        max: '2019-12-31 23:59:59'
    });

    // 全部加载完成, 开始加载基本数据
    $.when.apply(this, initDefs).done(function () {
        $.ajax({
            url: '/booksetDatas/' + id,
            type: 'GET',
            dateType: 'JSON'
        }).done(function (data) {
            // 处理启用期间
            data.startDate = '' + data.startYear + '-' + (data.startMonth < 10 ? '0' + data.startMonth : data.startMonth);

            form.val($formDp.attr('lay-filter'), data);
            form.val($formSc.attr('lay-filter'), data);

            // 设置上传
            renderUploadDataPackage(data.dataPackageUrl);
        })
    });

    // 账套数据包标签form提交事件监听
    form.on('submit(submit-filter-bookset-data)', function (data) {
        var params = data.field;
        params.booksetYear = 2019;
        loadingMonitor(function () {
            return $.ajax({
                url: '/booksetDatas',
                type: 'PUT',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(params)
            });
        })().done(function () {
            layer.msg('保存成功');
        });
        return false;
    });

    // 账套数据表
    var tableId = 'table-id-bookset-tax-table';
    var tableLns = table.render({
        id: tableId,
        elem: '#table-bookset-tax-table',
        url: '/taxSpeciesIdentifications/answers/company-id/' + companyId, //数据接口
        page: false, //开启分页
        cols: [[ //表头
            {type: 'numbers', title: '序号'},
            {field: 'taxKind', title: '税种'},
            {field: 'taxSubject', title: '税目'},
            {field: 'taxPeriod', title: '纳税期限'},
            {field: 'taxTableName', title: '税表名称'},
            {
                field: 'setStatus', title: '税表数据', templet: function (d) {
                    return '<span style="color: ' + (+d.setStatusId === 0 ? '#FF5722' : '#009688') + '">' + d.setStatus + '</span>';
                }
            },
            {title: '操作', templet: editable ? '#laytpl-table-ops' : '#laytpl-table-show-ops'}
        ]],
        response: {
            statusCode: 200
        },
        parseData: function (res) {
            res = res || [];
            $.each(res, function (i, row) {
                row.editable = editable;
            });
            return {
                code: 200,
                msg: '',
                count: res.length,
                data: res
            }
        },
        done: function () {
            $('.table-btn-import').each(function () {
                var data = $(this).data();
                var param = {
                    booksetDataId: id,
                    modelId: data.id,
                    taxTableModelId: data.taxTableModelId
                };
                // 渲染上传文件
                upload.render({
                    elem: $(this), //绑定元素
                    url: '/models/import/answer?' + serialize(param), //上传接口
                    accept: 'file',
                    exts: 'xls|xlsx',
                    field: 'excel',
                    before: function () {
                        layer.load();
                    },
                    done: function (data) {
                        layer.closeAll('loading');
                        if (!data.result) {
                            layer.confirm('<p class="vg-text-indent-2">此税表未设数据，系统将默认设置其数据为0，请确定是否继续导入？</p>', {
                                btn: ['确定', '取消']
                            }, function () {
                                loadingMonitor(function () {
                                    return $.ajax({
                                        type: 'post',
                                        url: '/models/import/answer/fix?' + serialize(param)
                                    });
                                })().done(function () {
                                    layer.msg("上传成功");
                                    tableLns.reload();
                                });
                            });
                        } else {
                            layer.msg('上传成功');
                            tableLns.reload();
                        }
                    },
                    error: function () {
                        var msg = '上传模板文件失败';
                        //请求异常回调
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

        }
    });

    // 清空税表数据
    var $body = $('body');
    $body.on('click', '.table-btn-clear', function () {
        var data = $(this).data();
        var booksetDataId = id;
        layer.confirm('<p class="vg-text-indent-2">确定清空此税表数据？</p>', {
            btn: ['确定', '取消']
        }, function () {
            loadingMonitor(function () {
                return $.ajax({
                    type: 'delete',
                    url: '/models/answer/book-set-data/' + booksetDataId + '/tax-table-model/' + data.taxTableModelId
                });
            })().done(function () {
                layer.msg("清空税表数据成功");
                tableLns.reload();
            });
            layer.close(1);
        });
    });

    // 查看/编辑/设置税表数据
    $body.on('click', '.table-btn-show, .table-btn-edit, .table-btn-set', function () {
        var data = $(this).data();
        var param = {
            id: data.id,
            booksetDataId: id,
            taxTableModelId: data.taxTableModelId,
            editable: data.editable
        };
        adminTab.del(data.tabId);
        adminTab.add({
            layId: data.tabId,
            title: data.tabTitle,
            url: 'pages/bookset-data/updateTable.html?' + serialize(param),
            icon: 'fa-book'
        });
    });

    // 下载文件
    $body.on('click', '[vg-download]', function () {
        var data = $(this).data();
        data.url && window.open(data.url, '_blank');
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 切换到当前标签
        tabChange: function () {
            tableLns.reload();
        }
    }
});