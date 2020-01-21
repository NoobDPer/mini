layui.use(['layer', 'table', 'laytpl', 'form', 'laydate'], function () {
    var This = this;
    var layer = layui.layer;
    var form = layui.form;
    // 内容表单
    var $saveForm = $('#form-save-content');
    var saveContentFromId = 'form-filter-save-content';
    // 缓存企业信息
    var content;

    // 加载自定义验证规则
    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);
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
        renderForm('select');
    }

    /**
     * 渲染过滤数据form
     */
    function renderForm(type) {
        form.render(type || null, saveContentFromId);
    }

    // 设置内容初始值
    function setsaveContentForm(data) {
        form.val(saveContentFromId, data);
        // 设置初始值
        $.each($saveForm.find('[name=type],[name=confirmState]'), function (i, ele) {
            var $ele = $(ele);
            $ele.attr('data-init-value', data[$ele.attr('name')]);
        });
        renderForm();
    }

    // /**
    //  * 加载保存内容信息表单
    //  * @param id 企业id
    //  */
    // function loadsaveContentForm(id) {
    //     return $.ajax({
    //         url: '/contents/' + id,
    //         type: 'GET',
    //         dataType: 'json'
    //     }).done(function (data) {
    //         content = data;
    //         setsaveContentForm(data);
    //     });
    // }

    // 初始化内容信息中的select
    $.when(
        // 初始化审核状态
        miniReq.initSelect.call(This, {
            fn: miniReq.getConfirmStatus,
            $ele: $saveForm.find('select[name=confirmState]')
        }),
        // 初始内容类型
        miniReq.initSelect.call(This, {
            fn: miniReq.getContentTypes,
            $ele: $saveForm.find('select[name=type]')
        })).done(function () {
    });


    // /**
    //  * 监听layui select事件
    //  */
    // function onSelect($ele, fn) {
    //     var filter = $ele.attr('lay-filter');
    //     if (!filter) {
    //         return;
    //     }
    //     var fns = $ele.data('selectFns') || [];
    //     fns.push(fn);
    //     form.on('select(' + filter + ')', function () {
    //         var args = arguments;
    //         var This = this;
    //         $.each(fns, function (i, rowFn) {
    //             rowFn.apply(This, args);
    //         })
    //     });
    //     $ele.data('selectFns', fns);
    // }

    function saveContent(cd) {
        return loadingMonitor(function () {
            return $.ajax({
                url: '/contents',
                type: 'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(cd)
            }).done(function (data) {
                content = data;
                setsaveContentForm(data);
            });
        })().done(function () {
            layer.msg('保存成功');
        });
    }

    form.on('checkbox(checkbox-filter-confirm-state)', function(data){
        $("input[name='confirmState']").prop("checked", false);   //全部取消选中
        $(this).prop("checked", true);                          //勾选当前选中的选择框     
        form.render('checkbox');
    });
    form.render('checkbox');

    var $tableDetailAdd = $('#table-batch-add');

    form.on('select(select-filter-content-content-type)', function (data) {
        var selectedVal = data.value;
        if (selectedVal == "2" || selectedVal == "3") {
            $('#layer-save-detail').removeClass("mini-hide");
            $tableDetailAdd.find('tbody').empty();
            var $tpl = $($('#laytpl-table-tr').html());
            $tableDetailAdd.find('tbody').append($tpl);
        } else {
            $('#layer-save-detail').addClass("mini-hide");
            $tableDetailAdd.find('tbody').empty();
        }
    });

    // 监听保存内容表单提交
    form.on('submit(btn-filter-save-content)', function (data) {

        var $form = $(data.form);
        var formData = $.map($form.find('tbody tr'), function (tr) {
            var rowData = {};
            $(tr).find('[name!=""]').each(function (i1, input) {
                var $input = $(input);
                var name = $input.prop('name');
                if (name) {
                    rowData[name] = $input.val();
                }
            });

            return rowData;
        });
        var reqData = data.field;
        reqData["list"] = formData;

        saveContent(reqData);
        return false;
    });





    $tableDetailAdd.on('mouseover', 'tr', function () {
        var $this = $(this);
        $this.find('.ops > a.a-ops-add').show();
        if ($this.parent().find('tr').length > 1) {
            $this.find('.ops > a.a-ops-del').show();
        }
    });
    $tableDetailAdd.on('mouseout', 'tr', function () {
        var $this = $(this);
        $this.find('.ops > a').hide();
    });
    $tableDetailAdd.on('click', 'a.a-ops-add', function () {
        var $tpl = $($('#laytpl-table-tr').html());
        $(this).parentsUntil('tr').parent().after($tpl);
    });
    $tableDetailAdd.on('click', 'a.a-ops-del', function () {
        $(this).parentsUntil('tr').parent().remove();
    });


    // // 提供给外部的公共方法
    // window.publicMethods = {
    //     refresh: function (contentId) {
    //         if (!id || contentId !== id) {
    //             return;
    //         }
    //         loadsaveContentForm(id);
    //     }
    // }
});
