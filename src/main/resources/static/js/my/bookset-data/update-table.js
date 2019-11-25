var id = getUrlParam("id");
var booksetDataId = getUrlParam("booksetDataId");
var taxTableModelId = getUrlParam('taxTableModelId');
var editable = getUrlParam('editable') === 'true';

layui.use(['layer', 'laydate', 'laytpl', 'form', 'upload'], function () {
    var layer = layui.layer;
    var laytpl = layui.laytpl;
    var form = layui.form;
    var upload = layui.upload;

    // 可编辑状态
    if (!editable) {
        $('#btn-save, #btn-import').addClass('layui-btn-disabled')
            .prop('disabled', true);
    }

    /**
     * 初始化表格
     *
     * @param sheetData sheet页数据
     * @param $table 表格DOM
     */
    function initTable(sheetData, $table) {
        var tableData = sheetData.modelSheetContentDTOS;
        var rowIndex = -1;
        var $row;
        $.each(tableData, function (i, col) {
            if (rowIndex + 1 <= col.rowIndex) {
                for (; rowIndex < col.rowIndex;) {
                    // 整行合并需要添加空行
                    $row = $('<tr>')
                        .attr('data-row-index', ++rowIndex)
                        .appendTo($table);
                }
            }

            var $td = $('<td>')
                .prop('rowspan', col.rowspan)
                .prop('colspan', col.colspan)
                .attr("data-editable", col.editable)
                .data('source', col)
                .appendTo($row);
            if (col.editable === 1) {
                $('<input type="text">')
                    .val(col.content)
                    .appendTo($td);
            } else {
                $td.text(col.content);
            }
        });
        form.render(null, 'form-filter-sheet-' + sheetData.sheetIndex);
    }

    loadingMonitor(function () {
        return $.ajax({
            url: '/models/answer/' + booksetDataId + "/" + id,
            type: 'GET',
            dataType: 'JSON'
        })
    })().done(function (data) {
        var $tabTpl = $('#tpl-table-tab');
        var $tabContentTpl = $('#tpl-table-tab-content');
        var $tabMenu = $('.table-tab-menu');
        var $tabContents = $('.table-tab-contents');

        $.each(data, function (i, sheetData) {
            var current = false;
            if (i === 0) {
                current = true;
            }

            // 增加一个tab
            var $tab = $(laytpl($tabTpl.html()).render(sheetData))
                .appendTo($tabMenu);
            // 增加一个content
            var $tabContent = $(laytpl($tabContentTpl.html()).render(sheetData))
                .hide()
                .appendTo($tabContents);
            if (current) {
                $tabContent.show();
                $tab.addClass('table-tab-current');
            }

            var $table = $tabContent.find('table');
            initTable(sheetData, $table);

            // 显示按钮
            $('.btn-ops').show();

            if (!editable) {
                $('.table-tab-content input').prop('disabled', true);
            }
        });
    });

    // sheet标签
    $('body').on('click', '.table-tab-menu .table-tab', function () {
        $('.table-tab-menu .table-tab').removeClass('table-tab-current');
        var index = $(this).addClass('table-tab-current').index();
        $('.table-tab-contents .table-tab-content').hide().eq(index).show();
    });

    // 重新导入
    upload.render({
        elem: '#btn-import', //绑定元素
        url: '/models/import/answer?' + serialize({
            booksetDataId: booksetDataId,
            modelId: id,
            taxTableModelId: taxTableModelId
        }), //上传接口
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
                            url: '/models/import/answer/fix?' + serialize({
                                booksetDataId: booksetDataId,
                                modelId: id,
                                taxTableModelId: taxTableModelId
                            })
                        });
                    })().done(function () {
                        layer.msg('上传成功');
                        window.setTimeout(function () {
                            location.reload();
                        }, 500);
                    });
                });
            } else {
                layer.msg('上传成功');
                window.setTimeout(function () {
                    location.reload();
                }, 500);
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

    // 保存
    $('#btn-save').on('click', function () {
        var datas = $.map($('.table-tab-content  td[data-editable="1"]'), function (dom) {
            var $this = $(dom);
            var $input = $this.find('input');
            var val = $input.val().trim();
            if (val) {
                var data = $this.data('source');
                data = $.extend(true, data, {});
                data.content = val;
                data.booksetDataId = booksetDataId;
                return data;
            }
        });
        loadingMonitor(function () {
            return $.ajax({
                url: '/models/save/answer/tax-table-model/' + taxTableModelId,
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                dataType: 'JSON',
                data: JSON.stringify(datas)
            });
        })().done(function () {
            layer.msg("保存成功");
        });
    });
});