/**
 * Created by admin on 2019/12/2.
 */
function tryAgain() {
    // $.ajax({
    //     type: 'get',
    //     url: '/open/content/type/2/random',
    //     success: function (data) {
    //
    //         if (data.code == 0) {
    //             var sentences = data.result.contentList;
    //             chatIframe.window.refresh4out();
    //         } else {
    //             $('#sentence').text("系统开了小差, 客官再试一次呗...");
    //         }
    //     },
    //     error: function (xhr) {
    //         $('#sentence').text("不是开玩笑, 系统维护中...");
    //     }
    // });
    window.setTimeout(function () {
        chatIframe.window.refresh4out();
    }, 100);

}


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