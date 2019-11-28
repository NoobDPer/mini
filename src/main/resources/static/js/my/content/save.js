var id = getUrlParam("id");

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

    // 新增企业
    $('#btn-add-content').click(function () {
        adminTab.del('tab-id-add-content');
        adminTab.add({
            layId: 'tab-id-add-content',
            title: '新增企业',
            url: 'pages/content/saveBizContent.html',
            icon: 'fa-flask'
        });
    });

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

    /**
     * 加载保存内容信息表单
     * @param id 企业id
     */
    function loadsaveContentForm(id) {
        return $.ajax({
            url: '/contents/' + id,
            type: 'GET',
            dataType: 'json'
        }).done(function (data) {
            content = data;
            setsaveContentForm(data);
        });
    }

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
        if (!id) {
            return;
        }
        loadsaveContentForm(id);
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

    function saveContent(cd) {
        return loadingMonitor(function () {
            return $.ajax({
                url: '/contents',
                type: cd.id ? 'PUT' : 'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(cd)
            }).done(function (data) {
                content = data;
                setId(data.id);
                setsaveContentForm(data);
            });
        })().done(function () {
            layer.msg('保存成功');
        });
    }

    // 监听保存内容表单提交
    form.on('submit(btn-filter-save-content)', function (data) {
        saveContent(data.field);
        return false;
    });

    // 提供给外部的公共方法
    window.publicMethods = {
        refresh: function (contentId) {
            if (!id || contentId !== id) {
                return;
            }
            loadsaveContentForm(id);
        }
    }
});
