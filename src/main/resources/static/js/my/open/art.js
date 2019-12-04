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