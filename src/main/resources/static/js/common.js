//form序列化为json
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//获取url后的参数值
function getUrlParam(key) {
    var href = window.location.href;
    var url = href.split("?");
    if (url.length <= 1) {
        return "";
    }
    var params = url[1].split("&");

    for (var i = 0; i < params.length; i++) {
        var param = params[i].split("=");
        if (key === param[0]) {
            return param[1];
        }
    }
}

/**
 * 将对象序列化成url参数
 *
 * @param data 需要序列化的数据
 * @returns {string}
 */
function serialize(data) {
    if (!data) {
        return '';
    }

    var $form = $('<form>');
    $.each(data, function (key, value) {
        if (!key || value === undefined || value === null) {
            return;
        }
        $('<input type="hidden">')
            .prop('name', key)
            .val($.trim(value))
            .appendTo($form);
    });
    var reuslt = $form.serialize();
    $form.empty().remove();
    return reuslt;
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

var userTools = function () {
    var user = localStorage.getItem('user');
    if (!user) {
        return;
    }

    user = JSON.parse(user);
    var roleId = user.roleId;

    var ROLE_DEFINE = {
        // 超级管理员
        superAdmin: {
            id: -1,
            description: '超级管理员'
        },
        // 管理员
        admin: {
            id: 1,
            description: '系统管理员'
        },
        // 教育机构管理员
        eduAdmin: {
            id: 2,
            description: '教育机构管理员'
        },
        // 教育机构用户
        eduUser: {
            id: 3,
            description: '培训讲师'
        }
    };

    function isEmpty(val) {
        return val === undefined || val === null || ('' + val) === ('' + NaN);
    }

    function getRoleId(val) {
        return !isEmpty(val) ? +val : +roleId
    }


    return {
        /**
         * 是否为超级管理员
         * @returns {boolean}
         */
        isSuperAdmin: function (id) {
            return getRoleId(id) === ROLE_DEFINE.superAdmin.id;
        },
        /**
         * 是否为admin用户
         * @returns {boolean}
         */
        isAdmin: function (id) {
            return getRoleId(id) === ROLE_DEFINE.admin.id;
        },
        /**
         * 是否为教育机构管理员
         * @returns {boolean}
         */
        isEduAdmin: function (id) {
            return getRoleId(id) === ROLE_DEFINE.eduAdmin.id;
        },
        /**
         * 是否为教育机构用户
         * @returns {boolean}
         */
        isEduUser: function (id) {
            return getRoleId(id) === ROLE_DEFINE.eduUser.id;
        },
        /**
         * 检查角色
         */
        checkRole: function () {
            var $eles = $('[data-vg-check-role]');
            $.each($eles, function (i, ele) {
                var $ele = $(ele);
                var roles = $ele.attr('data-vg-check-role');
                if (!roles) {
                    return false;
                }
                roles = roles.split(',');

                var flag = false;
                $.each(roles, function (i, role) {
                    if (+role === +roleId) {
                        flag = true;
                        return false;
                    }
                });
                if (!flag) {
                    $ele.empty().remove();
                } else {
                    $ele.removeAttr('data-vg-check-role');
                }
            });
        },
        /**
         * 获取角色
         * @returns {ROLE_DEFINE}
         */
        getRoles: function () {
            return $.extend(true, ROLE_DEFINE, {});
        },
        /**
         * 获取当前用户的所属企业
         * @returns {string}
         */
        getCompanyName: function () {
            return user.companyName;
        }
    }
}();

var miniReq = (function () {
    function convert(ajaxD, fn) {
        var d = $.Deferred();
        ajaxD.done(function () {
            d.resolve(fn.apply(this, arguments));
        }).fail(function () {
            $.Deferred.reject.apply(d, arguments);
        });
        return d;
    }
    function keyValueConverter(data) {
        return $.map(data, function (key, value) {
            return {
                text: key,
                val: value
            }
        });
    }
    return {
        /**
         * 获取审核状态对应关系
         * @returns {$.Deferred}
         */
        getConfirmStatus: function () {
            return convert($.get({
                url: '/common/confirm-status',
                dataType: 'json'
            }), function (data) {
                return $.map(data.result, function (row) {
                    return {
                        text: row.data,
                        val: row.code,
                        data: row
                    }
                })
            });
        },
        /**
         * 获取内容类型对应关系
         * @returns {$.Deferred}
         */
        getContentTypes: function () {
            return convert($.get({
                url: '/common/content-types',
                dataType: 'json'
            }), function (data) {
                return $.map(data.result, function (row) {
                    return {
                        text: row.data,
                        val: row.code,
                        data: row
                    }
                })
            })
        },
        /**
         * 初始化select
         * @param options {{fn:[function], data: [{}], $ele: JQuery, param:[{}]}}
         */
        initSelect: function (options) {
            var This = this;
            if (!options.$ele || !options.$ele[0]) {
                return  $.Deferred().resolve();
            }
            return (options.data ? $.Deferred().resolve(options.data) : options.fn(options.param)).done(function (data) {
                var $ele = (options.$ele && $.isArray(options.$ele)) ? options.$ele : [options.$ele];
                $.each($ele, function () {
                    var $select = $(this);
                    $select.find('option[value!=""]').empty();
                    $.each(data, function (i, row) {
                        var $tpl = $(This.laytpl('<option value="{{ d.val }}">{{ d.text }}</option>').render(row));
                        $tpl.data('source', row);
                        $select.append($tpl);
                    });
                    This.form.render('select', $select.parentsUntil('form').parent().attr('lay-filter'));
                });
            });
        }
    }
})();

var LayuiTools = (function () {
    var TABLE_DEFUALT_PARAMS = {
        page: {
            limit: 15,
            limits: [15, 30, 50, 70, 90]
        },
        loading: true,
        response: {
            statusCode: 200
        },
        parseData: function (res) {
            return {
                code: 200,
                msg: '',
                count: res.recordsTotal,
                data: res.data
            }
        }
    };

    /**
     * val不为undefined/null/NaN/空字符串
     */
    function isEmpty(val) {
        return val === undefined || val === null || (val + '' === 'NaN') || val === '';
    }

    /**
     * 校验自定义规则参数
     */
    function checkVerifyParams(itemData, paramNames) {
        if (!paramNames || paramNames.length === 0) {
            return true;
        }
        var flag = true;
        $.each(paramNames, function (i, name) {
            if (isEmpty(name)) {
                console.error('自定义验证规则执行失败, 缺少参数: ' + name);
                flag = false;
                return false;
            }
        })
    }

    function LayuiTools(content) {
        this.layui = content.layui;
        this.laytpl = layui.laytpl;
        this.device = layui.device();

        this.DANGER = 'layui-form-danger';
    }

    /**
     * 获取错误消息
     * @param itemData {} dom节点上的数据
     * @param renderData [{}] 渲染数据
     * @returns {string} 错误消息
     */
    LayuiTools.prototype._getErrorMsg = function (itemData, renderData) {
        var msg = itemData['vgVerifyMsg'];
        if (!msg) {
            return;
        }
        if (msg.indexOf('{{') !== -1 && msg.indexOf('}}') !== -1) {
            // 用laytpl渲染
            msg = this.laytpl(msg).render(renderData);
        }
        return msg;
    };

    /**
     * 手动校验
     * @param $ele 需要校验的元素
     * @param fn 校验函数
     */
    LayuiTools.prototype.verify = function ($ele, fn) {
        var val = $ele.val();
        var result = fn(val, $ele);
        if (!result.success) {
            //非移动设备自动定位焦点
            if (!this.device.android && !this.device.ios) {
                setTimeout(function () {
                    $ele.focus();
                }, 7);
            }
            $ele.addClass(this.DANGER);
            layer.msg(result.msg || '校验出错', {icon: 5, shift: 6});
            return false;
        }
        return true;
    };

    /**
     * 自定义的验证规则
     */
    LayuiTools.prototype.verifyRules = function () {
        var This = this;
        return {
            /**
             * 检测长度是否为指定的值
             *
             * @param value 表单的值
             * @param item 表单的DOM对象
             * @returns {string} 错误信息
             */
            length: function (value, item) {
                if (!value) {
                    return;
                }

                // vg-rule-length 长度限制
                var $item = $(item);
                var data = $item.data();
                if (checkVerifyParams(data, ['vgVerifyLength'])) {
                    return;
                }

                var length = data.vgVerifyLength;
                if (value.length !== length) {
                    return This._getErrorMsg(data, {
                        value: value,
                        length: length
                    }) || ('长度必须为' + length);
                }
            },
            regex: function (value, item) {
                if (!value) {
                    return;
                }

                var $item = $(item);
                var data = $item.data();
                if (checkVerifyParams(data, ['vgVerifyRegex'])) {
                    return;
                }

                var regex = data.vgVerifyRegex;
                if (!new RegExp(regex).test(value)) {
                    return This._getErrorMsg(data, {
                        value: value,
                        regex: regex
                    }) || '参数不符合规则';
                }
            }
        }
    };

    /**
     * 加载自定义验证规则
     * @param form
     */
    LayuiTools.prototype.loadRules = function (form) {
        form.verify(this.verifyRules());
    };

    /**
     * 切分范围日期控件的值为数组
     * @param val 日期空间值
     * @returns {*|string[]} 如果没有值返回undefined, 否则返回开始日期和结束日期数组
     */
    LayuiTools.splitDateRange = function (val) {
        if (!val) {
            return;
        }

        return val.split(' - ');
    };

    /**
     * 合并参数生成范围日期控件的值
     * @param start 起始时间
     * @param end 结束时间
     * @returns {string} 合并后的值
     */
    LayuiTools.joinDateRange = function (start, end) {
        if (!start || !end) {
            return '';
        }
        return start + ' - ' + end;
    };

    /**
     * 继承表格默认参数
     * @param params 自定义表格而参数
     * @returns {{}}
     */
    LayuiTools.extendTableDefaultParams = function (params) {
        return $.extend(true, TABLE_DEFUALT_PARAMS, params || {});
    };

    return LayuiTools;
})();

(function () {
    //仅在不支持 placeholder 的时候执行
    if (!('placeholder' in document.createElement('input'))) {

        var listenerName = 'attachEvent';
        var listenerPrefix = 'on';
        if ('addEventListener' in window) {
            listenerName = 'addEventListener';
            listenerPrefix = '';
        }

        window[listenerName](listenerPrefix + 'load', function () {
            var placeholderListener = {
                //添加输入项
                add: function (tagName) {
                    var list = document.getElementsByTagName(tagName);
                    for (var i = 0; i < list.length; i++) {
                        this.render(list[i]);
                    }
                    return this;
                },
                //渲染
                render: function (input) {
                    var text = input.getAttribute('placeholder');
                    if (!!text) {
                        this.attachEvent(input, this.getPlaceholderDiv(input, text));
                    }
                },
                //设置样式
                getPlaceholderDiv: function (input, text) {
                    var placeholderDiv = document.createElement('div');

                    placeholderDiv.style.position = 'absolute';
                    placeholderDiv.style.width = this.getPosition(input, 'Width') + 'px';
                    placeholderDiv.style.height = this.getPosition(input, 'Height') + 'px';
                    placeholderDiv.style.color = '#91D3F8';
                    placeholderDiv.style.textIndent = '5px';
                    placeholderDiv.style.zIndex = 999;
                    placeholderDiv.style.background = input.style.background;
                    placeholderDiv.style.border = input.style.border;
                    placeholderDiv.style.cursor = 'text';
                    placeholderDiv.innerHTML = text;

                    if ('TEXTAREA' == input.tagName.toUpperCase()) {
                        placeholderDiv.style.lineHeight = '35px';
                    } else {
                        placeholderDiv.style.lineHeight = placeholderDiv.style.height;
                    }
                    document.getElementsByTagName('body')[0].appendChild(placeholderDiv);

                    //窗口改变大小时自动调整位置
                    placeholderDiv.resize = (function (that) {
                        return function () {
                            placeholderDiv.style.left = that.getPosition(input, 'Left') + 'px';
                            placeholderDiv.style.top = that.getPosition(input, 'Top') + 'px';
                        }
                    })(this);
                    window[listenerName](listenerPrefix + 'resize', placeholderDiv.resize);
                    placeholderDiv.resize();

                    return placeholderDiv;
                },
                //计算当前输入项目的位置
                getPosition: function (input, name, parentDepth) {
                    var offsetName = 'offset' + name;
                    var offsetVal = input[offsetName];
                    var parentDepth = parentDepth || 0;
                    if (!offsetVal && parentDepth < 3) {
                        offsetVal = this.getPosition(input.parentNode, name, ++parentDepth);
                    }
                    return offsetVal;
                },
                //添加事件
                attachEvent: function (input, placeholderDiv) {

                    //激活时，隐藏 placeholder
                    input[listenerName](listenerPrefix + 'focus', function () {
                        placeholderDiv.style.display = 'none';
                    });

                    //失去焦点时，隐藏 placeholder
                    input[listenerName](listenerPrefix + 'blur', function (e) {
                        if (e.srcElement.value == '') {
                            placeholderDiv.style.display = '';
                        }
                    });

                    //placeholder 点击时，对应的输入框激活
                    placeholderDiv[listenerName](listenerPrefix + 'click', function (e) {
                        e.srcElement.style.display = 'none';
                        input.focus();
                    });

                    if (input.value !== '') {
                        placeholderDiv.style.display = 'none';
                    }
                }
            };

            //防止在 respond.min.js和html5shiv.min.js之前执行
            setTimeout(function () {
                placeholderListener.add('input').add('textarea');
            }, 0);
        });
    }
})();