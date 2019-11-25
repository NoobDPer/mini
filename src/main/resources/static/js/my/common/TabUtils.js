var TabUtils = (function () {
    var DEFAULT_OPTIONS = {
        layui: null,
        filter: null
    };

    var DEFAULT_ADD_OPTIONS = {
        layId: null,
        title: null,
        url: null,
        icon: null
    };

    //iframe自适应
    function resize() {
        var $content = $('.admin-nav-card .layui-tab-content');
        $content.height($(this).height() - 147);
        $content.find('iframe').each(function () {
            $(this).height($content.height());
        });
    }

    function TabUtils(options) {
        options = $.extend(true, DEFAULT_OPTIONS, options || {});
        if (!options.layui || !options.filter) {
            throw new Error("缺少参数.");
        }
        this.options = options;
        this.element = layui.element;
        this.$ele = $('.layui-tab[lay-filter=' + options.filter + ']');
        this.$tabs = this.$ele.find('.layui-tab-title');
        this.$tabContents = this.$ele.find('.layui-tab-content');
    }

    TabUtils.prototype.exists = function (layId) {
        return this.$ele.find('li[lay-id=' + layId + ']').length > 0;
    };

    TabUtils.prototype.add = function (options) {
        options = $.extend(true, DEFAULT_ADD_OPTIONS, options || {});
        if (!options.layId || !options.title || !options.url) {
            throw new Error("缺少参数.");
        }

        if (this.exists(options.layId)) {
            this.change(options.layId);
            return;
        }

        if (options.icon) {
            var icon = '<i class="fa ' + options.icon + '" aria-hidden="true" title="' + options.title + '" unreadNotice></i>';

        }
        var title = (icon || '') +
            '<cite>' + options.title + '</cite>' +
            '<i class="layui-icon" data-id="' + options.layId + '"></i>';
        //新增一个Tab项
        this.element.tabAdd(this.options.filter, {
            title: title,
            content: '<iframe src="' + options.url + '"></iframe>',
            id: options.layId
        });
        this.element.tabChange(this.options.filter, options.layId);
        resize();
    };

    TabUtils.prototype.del = function (layId) {
        this.element.tabDelete(this.options.filter, layId);
    };

    TabUtils.prototype.change = function (layId) {
        this.element.tabChange(this.options.filter, layId);
    };

    TabUtils.prototype.getTabWindow = function (layid) {
        var $tab = this.$tabs.find('li[lay-id=' + layid +']');
        if (!$tab[0]) {
            return;
        }
        var index = $tab.index();
        var $content = this.$tabContents.find('.layui-tab-item:eq(' + index +')');
        if (!$content[0]) {
            return;
        }
        return $content.find('iframe')[0].contentWindow;
    };

    return TabUtils;
})();