initMenu();

function initMenu() {
    $.ajax({
        url: "/permissions/current",
        type: "get",
        async: false,
        success: function (data) {
            if (!$.isArray(data)) {
                location.href = '/login.html';
                return;
            }
            var menu = $("#menu");
            $.each(data, function (i, item) {
                var a = $("<a href='javascript:;'></a>");

                var css = item.css;
                if (css != null && css !== "") {
                    a.append("<i aria-hidden='true' class='fa " + css + "'></i>");
                }
                a.append("<cite>" + item.name + "</cite>");
                a.attr("lay-id", item.id);

                var href = item.href;
                if (href != null && href !== "") {
                    a.attr("data-url", href);
                }

                var li = $("<li class='layui-nav-item'></li>");
                if (i === 0) {
                    li.addClass("layui-nav-itemed");
                }
                li.append(a);
                menu.append(li);

                //多级菜单
                setChild(li, item.child)

            });
        }
    });
}

function setChild(parentElement, child) {
    if (child != null && child.length > 0) {
        $.each(child, function (j, item2) {
            var ca = $("<a href='javascript:;'></a>");
            ca.attr("data-url", item2.href);
            ca.attr("lay-id", item2.id);

            var css2 = item2.css;
            if (css2 != null && css2 != "") {
                ca.append("<i aria-hidden='true' class='fa " + css2 + "'></i>");
            }

            ca.append("<cite>" + item2.name + "</cite>");

            var dd = $("<dd></dd>");
            dd.append(ca);

            var dl = $("<dl class='layui-nav-child'></dl>");
            dl.append(dd);

            parentElement.append(dl);

            // 递归
            setChild(dd, item2.child);
        });
    }
}

// 登陆用户头像昵称
showLoginInfo();

function showLoginInfo() {
    $.ajax({
        type: 'get',
        url: '/users/current',
        async: false,
        success: function (data) {
            $(".admin-header-user span").text(data.nickname);

            /*var pro = window.location.protocol;
            var host = window.location.host;
            var domain = pro + "//" + host;

            var sex = data.sex;
            var url = data.headImgUrl;
            if (url == null || url == "") {
                if (sex == 1) {
                    url = "/img/avatars/sunny.png";
                } else {
                    url = "/img/avatars/1.png";
                }

                url = domain + url;
            } else {
                url = domain + "/statics" + url;
            }
            var img = $(".admin-header-user img");
            img.attr("src", url);*/
        }
    });
}

function logout() {
    layer.confirm('<p class="vg-text-indent-2">确定登出？</p>', {icon: 3, title:'提示'}, function(index){
        $.ajax({
            type: 'get',
            url: '/logout',
            success: function () {
                localStorage.removeItem("token");
                location.href = '/login.html';
            }
        });
        layer.close(index);
    });


}

var active;

layui.use(['layer', 'element'], function () {
    var $ = layui.jquery,
        layer = layui.layer;
    var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
    window.adminTab = new TabUtils({
        layui: layui,
        filter: 'admin-tab'
    });

    //触发事件
    active = {
        tabAdd: function (obj) {
            var lay_id = $(this).attr("lay-id");
            var title = $(this).html() + '<i class="layui-icon" data-id="' + lay_id + '"></i>';
            //新增一个Tab项
            element.tabAdd('admin-tab', {
                title: title,
                content: '<iframe src="' + $(this).attr('data-url') + '"></iframe>',
                id: lay_id
            });
            element.tabChange("admin-tab", lay_id);
        },
        tabDelete: function (lay_id) {
            element.tabDelete("admin-tab", lay_id);
        },
        tabChange: function (lay_id) {
            element.tabChange('admin-tab', lay_id);
        }
    };

    //添加tab
    $(document).on('click', 'a', function () {
        if (!$(this)[0].hasAttribute('data-url') || $(this).attr('data-url') === '') {
            return;
        }
        var tabs = $(".layui-tab-title").children();
        var lay_id = $(this).attr("lay-id");

        for (var i = 0; i < tabs.length; i++) {
            if ($(tabs).eq(i).attr("lay-id") == lay_id) {
                active.tabChange(lay_id);
                return;
            }
        }
        active["tabAdd"].call(this);
        resize();
    });

    element.on('tab', function (data) {
        var $elem = $(data.elem);
        var $iframe = $elem.find('.layui-tab-content .layui-tab-item:eq(' + data.index + ') iframe')
        var win = $iframe[0].contentWindow;
        if (win.publicMethods && win.publicMethods.tabChange) {
            win.publicMethods.tabChange();
        }
    });

    //iframe自适应
    function resize() {
        $('.admin-nav-card .layui-tab-content').height(window.innerHeight - 147);
    }

    $(window).on('resize', function () {
        resize();
    });
    resize();

    //toggle左侧菜单
    $('.vg-admin-side-toggle').on('click', function () {
        var sideWidth = $('#admin-side').width();
        var expand = sideWidth !== 200;
        $('.vg-admin-header').toggleClass('vg-admin-header-shrink');
        $(this).find('a')
            .attr('title', expand ? '收起' : '展开')
            .find('i')
            .toggleClass('layui-icon-shrink-right')
            .toggleClass('layui-icon-spread-left');
        $('#admin-body, #admin-footer, .vg-admin-nav-left').animate({
            left: expand ? 200 : 0
        });
        $('#admin-side, .layui-logo').animate({
            width: expand ? 200 : 0
        });
    });

    // 刷新
    $('.vg-admin-refresh').on('click', function () {
        var $tab = $('.vg-layui-tab .layui-tab-content > .layui-tab-item.layui-show');
        if ($tab.index()) {
            var iframeWindow = $tab.find('iframe')[0].contentWindow;
            iframeWindow.location.reload();
        }
    });
});