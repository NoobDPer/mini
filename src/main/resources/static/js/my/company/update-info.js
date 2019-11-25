var id = getUrlParam("id");
var editable = getUrlParam('editable') === 'true';

layui.use(['layer', 'laydate', 'laytpl', 'form'], function () {
    var This = this;
    var layer = layui.layer;
    var laytpl = layui.laytpl;
    var form = layui.form;
    var saveCompanyFromId = 'form-filter-save-company';
    var $saveForm = $('#form-save-company');
    var adminTab = parent.adminTab || top.adminTab;
    var layuiTools = new LayuiTools(This);
    layuiTools.loadRules(form);

    if (!editable) {
        $saveForm.find('input[name],select[name]')
            .prop('disabled', true);
        $saveForm.find('button')
            .addClass('layui-btn-disabled')
            .prop('disabled', true);
    }

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

    function initForm() {
        $.ajax({
            url: '/companys/' + id,
            type: 'GET',
            dataType: 'json'
        }).done(function (data) {
            form.val(saveCompanyFromId, data);
            $saveForm.find('select[name=applicableAccountingType]')
                .attr('data-init-value', data.applicableAccountingType)
                .removeAttr('data-change')
                .parent()
                .find('.vg-tip')
                .hide();
        });
    }

    // 初始化会计准则
    VgReq.getAccounting().done(function (data) {
        VgReq.initSelect.call(This, {
            fn: VgReq.getAccounting,
            $ele: $saveForm.find('select[name=applicableAccountingType]')
        })
    }).done(function () {
        initForm();
    });

    // 适用会计制度select改变事件
    onSelect($saveForm.find('select[name=applicableAccountingType]'), function (data) {
        var initValue = $(data.elem).attr('data-init-value');
        var change = +initValue !== +data.value;
        $(data.elem).attr('data-change', change)
            .parent()
            .find('.vg-tip')[change ? 'show' : 'hide']();
    });

    function saveCompany(params) {
        loadingMonitor(function () {
            return $.ajax({
                url: '/companys',
                type: 'PUT',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(params)
            });
        })().done(function () {
            layer.msg('保存成功');

            // 关联更新编辑企业或新增企业
            var layids = ['tab-id-edit-company', 'tab-id-add-company'];
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
        // 检查会计制度和纳税人资格是否发生了改变
        var change = $saveForm.find('[name=applicableAccountingType][data-change=true]').length > 0;
        if (change) {
            // 会计制度和纳税人资格是否发生了改变并且有税种时提示
            layer.confirm('<p class="vg-text-indent-2">修改会计制度将会重置账套，需要重设税种鉴定和账套数据！</p>', {
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

    // 监听重置按钮
    $('#form-save-company-reset').on('click', function () {
       initForm();
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        // 刷新表单数据
        refresh: function (companyId) {
            if (!id || companyId !== id) {
                return;
            }
            initForm();
        }
    }
});