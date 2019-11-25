$.ajaxSetup({
    async: true,
    cache: false,
    headers: {
        "token": localStorage.getItem("token")
    },
    error: function (xhr) {
        var msg = xhr.responseText;
        var response = JSON.parse(msg);
        var code = xhr.status;
        var message = response.errorMsg;
        if (code === 400) {
            layer.msg(message);
        } else if (code === 401) {
            localStorage.removeItem("token");
            location.href = '/login.html';
        } else if (code === 403) {
            console.log("未授权:" + message);
            layer.msg('未授权');
        } else if (code === 500) {
            layer.msg('系统错误：' + message);
        }
    }
});

function hasPermission(permission, pers) {
    if (permission) {
        if ($.inArray(permission, pers) < 0) {
            return false;
        }
    }
    return true;
}

function buttonDel(data, permission, pers) {
    if (!hasPermission(permission, pers)) {
        return "";
    }

    var btn = $("<span><button class='layui-btn layui-btn-xs' title='删除' onclick='del(\"" + data + "\")'><i class='layui-icon'>&#xe640;</i></button></span>");
    return btn.prop("outerHTML");
}

function buttonEdit(href, permission, pers) {
    if (!hasPermission(permission, pers)) {
        return "";
    }

    var btn = $("<span style='margin-left: 10px'><button class='layui-btn layui-btn-xs' title='编辑' style='display:inline-block;vertical-align:middle;' onclick='window.location=\"" + href + "\"'><i class='layui-icon'>&#xe642;</i></button></span>");
    return btn.prop("outerHTML");
}


function deleteCurrentTab() {
    var lay_id = $(parent.document).find("ul.layui-tab-title").children("li.layui-this").attr("lay-id");
    parent.active.tabDelete(lay_id);
}


function allCheckBox(data, permission, pers) {
    if (permission != "") {
        if ($.inArray(permission, pers) < 0) {
            return "";
        }
    }
    var content = '<label   style="display: inline-block;width: 100%;text-align: center;"  class="mt-checkbox mt-checkbox-single mt-checkbox-outline" >';
    content += '    <input type="checkbox"  name="line-ckeckbox" permission="knowledge:del" class="group-checkable" value="'
        + data + '" />';
    content += '</label>';
    return content;
}