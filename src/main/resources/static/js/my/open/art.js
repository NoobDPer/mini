/**
 * Created by admin on 2019/12/2.
 */
function tryAgain() {
    $.ajax({
        type: 'get',
        url: '/open/content/type/3/random',
        success: function (data) {
            if (data.code == 0) {
                $('#sentence').text(data.result.contentCn);
            } else {
                $('#sentence').text("系统开了小差, 儒雅随和...");
            }

        },
        error: function (xhr) {
            $('#sentence').text("系统维护中, 儒雅随和...");
        }
    });
}

tryAgain();


layui.use(['layer','form'], function(){
    var This = this;
    var form = layui.form;
    var $saveForm = $('form[lay-filter=form-filter-save-art]');

    var saveLayerIndex;
    $('#btn-add-art').on('click', function () {
        saveLayerIndex = layer.open({
            id: 'layer-id-save-art',
            type: 1,
            title: '抽象艺术',
            content: $('#layer-save-art'),
            area: '80%',
            resize: false
        })
    });
    // 保存弹窗取消按钮单击事件
    $saveForm.find('.btn-save-art .btn1').on('click', function () {
        layer.close(saveLayerIndex);
    });

    // 监听保存表单提交
    form.on('submit(submit-filter-save-art)', function (data) {
        var params = data.field;
        loadingMonitor(function () {
            params['type'] = 3;
            params['showQqState'] = 0;
            params['source'] = 1;
            return $.ajax({
                url: '/open/content',
                type: 'POST',
                contentType: 'application/json',
                dataType: 'JSON',
                data: JSON.stringify(params)
            })
        })().done(function () {
            layer.msg('保存成功');
            if (saveLayerIndex) {
                layer.close(saveLayerIndex);
            }
        });
        return false;
    });
});

/**
 * 加载状态监听器, 包装处理方法, 自动开启loading以及关闭loading
 */
function loadingMonitor(fn) {
    return function () {
        if (!$.isFunction(fn)) {
            return fn;
        }

        var index = layer.load();
        try {
            var result = fn.apply(this, arguments);
        } finally {
            if (result && result.always && $.isFunction(result.always)) {
                result.always(function () {
                    layer.close(index);
                })
            } else {
                layer.close(index);
            }
        }
        return result;
    }
}