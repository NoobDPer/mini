/**
 * Created by admin on 2019/12/2.
 */
function tryAgain() {
    $.ajax({
        type: 'get',
        url: '/open/content/type/1/random',
        success: function (data) {
            if (data.code == 0) {
                $('#sentence').text(data.result.contentCn);
            } else {
                $('#sentence').text("系统开了小差, 客官再试一次呗...");
            }

        },
        error: function (xhr) {
            $('#sentence').text("不是开玩笑, 系统维护中...");
        }
    });
}

tryAgain();

layui.use(['layer','form'], function(){
    var This = this;
    var form = layui.form;
    var $saveForm = $('form[lay-filter=form-filter-save-soup]');

    var saveLayerIndex;
    $('#btn-add-soup').on('click', function () {
        saveLayerIndex = layer.open({
            id: 'layer-id-save-soup',
            type: 1,
            title: '投毒',
            content: $('#layer-save-soup'),
            area: '80%',
            resize: false
        })
    });
    // 保存弹窗取消按钮单击事件
    $saveForm.find('.btn-save-soup .btn1').on('click', function () {
        layer.close(saveLayerIndex);
    });

    // 监听保存表单提交
    form.on('submit(submit-filter-save-soup)', function (data) {
        var params = data.field;
        loadingMonitor(function () {
            params['type'] = 1;
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