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

layui.use('layer', function(){ //独立版的layer无需执行这一句
    var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

    //触发事件
    var active = {
        add: function(){
            //示范一个公告层
            layer.open({
                type: 1
                ,title: false //不显示标题栏
                ,closeBtn: true
                ,area: '80%'
                ,shade: 0.8
                ,id: 'btn-add-a-sentence-id' //设定一个id，防止重复弹出
                ,btn: ['保存']
                ,btnAlign: 'r'
                ,moveType: 1 //拖拽模式，0或者1
                ,content: $('#hidden-add-div').html()
                ,yes: function(index, layero){
                    var sentence = layero.find('.layui-textarea');
                    console.log(sentence.attr());
                    alert(sentence.attr())
                    // btn.find('.layui-layer-btn0').attr({
                    //     href: 'http://www.layui.com/'
                    //     ,target: '_blank'
                    // });
                }
            });
        }
    };

    $('#div-add-sentence .layui-btn').on('click', function(){
        var othis = $(this), method = othis.data('method');
        active[method] ? active[method].call(this, othis) : '';
    });

});