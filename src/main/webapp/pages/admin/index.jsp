<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>OUC の 贴吧</title>
	<%@ include file="/pages/common/head.jsp" %>
	<style>
        .layui-table-view {
            margin-top: -15px;
        }
	</style>
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>

<%--选项卡--%>
<div class="layui-tab layui-tab-brief" style="margin-top: 60px;background-color: #FFFFFF;opacity: 0.9">
	<ul class="layui-tab-title">
		<li class="layui-this">用户表</li>
		<li>帖子表</li>
		<li>楼层表</li>
		<li>评论表</li>
	</ul>
	<div class="layui-tab-content" style="height: 100px;">
		<div class="layui-tab-item layui-show">
			<table id="userTable" lay-filter="userTable"></table>
		</div>
		<div class="layui-tab-item">
			<table id="postTable" lay-filter="postTable"></table>
		</div>
		<div class="layui-tab-item">
			<table id="floorTable" lay-filter="floorTable"></table>
		</div>
		<div class="layui-tab-item">
			<table id="commentTable" lay-filter="commentTable"></table>
		</div>
	</div>
</div>

<%--头部工具栏--%>
<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-primary layui-border-green layui-btn-sm" lay-event="reload"
				style="margin-left: 8px;font-weight: bold">
			<i class="layui-icon layui-icon-refresh" style="font-size: 14px;"> 刷新</i>
		</button>
	</div>
</script>

<%--行工具栏--%>
<script type="text/html" id="rowToolbar">
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<%--edit页面（用户表）--%>
<div id="editUser" style="display: none;padding: 20px 20px 0 20px;">
	<form class="layui-form layui-form-pane" lay-filter="editUser">
		<div class="layui-form-item">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="uid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户名</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="username" autocomplete="off"
					   lay-verify="required" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="password" autocomplete="off"
					   lay-verify="required|password" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">邮箱</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="email" autocomplete="off"
					   lay-verify="required|email" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
				<input type="radio" name="gender" value="male" title="男">
				<input type="radio" name="gender" value="female" title="女">
				<input type="radio" name="gender" value="notSet" title="未设置">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">头像</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="avatar" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">发帖数</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="postNum" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block" style="float: right">
				<button type="button" class="layui-btn" lay-submit lay-filter="user_edit">立即提交</button>
			</div>
		</div>
	</form>
</div>

<%--edit页面（帖子表）--%>
<div id="editPost" style="display: none;padding: 20px 20px 0 20px;">
	<form class="layui-form layui-form-pane" lay-filter="editPost">
		<div class="layui-form-item">
			<label class="layui-form-label">帖子ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="pid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="uid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">标题</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="title" autocomplete="off"
					   lay-verify="required" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">内容</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea" name="content" autocomplete="off"
						  lay-verify="required" lay-vertype="tips">
				</textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">图片Url</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="imgUrl" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">日期</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="date" id="post_date" autocomplete="off"
					   lay-verify="required" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">楼层数</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="floorNum" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block" style="float: right">
				<button type="button" class="layui-btn" lay-submit lay-filter="post_edit">立即提交</button>
			</div>
		</div>
	</form>
</div>

<%--edit页面（楼层表）--%>
<div id="editFloor" style="display: none;padding: 20px 20px 0 20px;">
	<form class="layui-form layui-form-pane" lay-filter="editFloor">
		<div class="layui-form-item">
			<label class="layui-form-label">楼层ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="fid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="uid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">帖子ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="pid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">内容</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea" name="content" autocomplete="off"
						  lay-verify="required" lay-vertype="tips">
				</textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">日期</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="date" id="floor_date" autocomplete="off"
					   lay-verify="required" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">评论数</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="commentNum" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block" style="float: right">
				<button type="button" class="layui-btn" lay-submit lay-filter="floor_edit">立即提交</button>
			</div>
		</div>
	</form>
</div>

<%--edit页面（评论表）--%>
<div id="editComment" style="display: none;padding: 20px 20px 0 20px;">
	<form class="layui-form layui-form-pane" lay-filter="editComment">
		<div class="layui-form-item">
			<label class="layui-form-label">评论ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="cid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="uid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">楼层ID</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="fid" autocomplete="off"
					   lay-verify="required" lay-vertype="tips" disabled>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">内容</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea" name="content" autocomplete="off"
						  lay-verify="required" lay-vertype="tips">
				</textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">日期</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="date" id="comment_date" autocomplete="off"
					   lay-verify="required" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block" style="float: right">
				<button type="button" class="layui-btn" lay-submit lay-filter="comment_edit">立即提交</button>
			</div>
		</div>
	</form>
</div>

<script>
    $('#admin').addClass('layui-this');
    // 检查admin是否登录
    if (${empty sessionScope.admin}) {
        window.location.href = 'pages/admin/login.jsp';
    }

    // 日期转换
    Date.prototype.Format = function (fmt) {
        let o = {
            "M+": this.getMonth() + 1,					//月份
            "d+": this.getDate(),						//日
            "h+": this.getHours(),						//小时
            "m+": this.getMinutes(),					//分
            "s+": this.getSeconds(),					//秒
            "q+": Math.floor((this.getMonth() + 3) / 3),//季度
            "S": this.getMilliseconds()					//毫秒
        };
        if (/(y+)/.test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        }
        for (let k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };

    // 用户表
    table.render({
        elem: '#userTable',
        url: '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet?action=getAllUsers',
        toolbar: '#toolbar',
        defaultToolbar: ['filter', 'exports'],
        title: '用户表',
        skin: 'row',
        even: true,
        cols: [[
            {title: '操作', minWidth: 140, align: 'center', toolbar: '#rowToolbar', fixed: 'left'},
            {type: 'numbers', title: '序号', width: 100, align: 'center', fixed: 'left'},
            {field: 'uid', title: '用户ID', minWidth: 100, align: 'center', sort: true},
            {field: 'username', title: '用户名', minWidth: 150, align: 'center'},
            {field: 'password', title: '密码', minWidth: 150, align: 'center'},
            {field: 'email', title: '邮箱', minWidth: 200, align: 'center'},
            {
                field: 'gender', title: '性别', minWidth: 100, align: 'center', templet: function (res) {
                    return res.gender === 'female' ? '女' : res.gender === 'male' ? '男' : '未设置';
                }
            },
            {field: 'avatar', title: '头像', minWidth: 400, align: 'center'},
            {field: 'postNum', title: '发帖数', minWidth: 100, align: 'center', sort: true}
        ]]
    });

    // 帖子表
    table.render({
        elem: '#postTable',
        url: '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/postServlet?action=getAllPosts',
        toolbar: '#toolbar',
        defaultToolbar: ['filter', 'exports'],
        title: '帖子表',
        skin: 'row',
        even: true,
        cols: [[
            {title: '操作', minWidth: 140, align: 'center', toolbar: '#rowToolbar', fixed: 'left'},
            {type: 'numbers', title: '序号', width: 100, align: 'center', fixed: 'left'},
            {field: 'pid', title: '帖子ID', minWidth: 100, align: 'center', sort: true},
            {field: 'uid', title: '用户ID', minWidth: 100, align: 'center', sort: true},
            {field: 'title', title: '标题', minWidth: 250, align: 'center'},
            {field: 'content', title: '内容', minWidth: 450, align: 'center'},
            {field: 'imgUrl', title: '图片Url', minWidth: 400, align: 'center'},
            {
                field: 'date', title: '日期', minWidth: 200, align: 'center', sort: true, templet: function (res) {
                    return new Date(res.date).Format('yyyy-MM-dd hh:mm:ss');
                }
            },
            {field: 'floorNum', title: '楼层数', minWidth: 100, align: 'center', sort: true}
        ]]
    });

    // 楼层表
    table.render({
        elem: '#floorTable',
        url: '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/floorServlet?action=getAllFloors',
        toolbar: '#toolbar',
        defaultToolbar: ['filter', 'exports'],
        title: '楼层表',
        skin: 'row',
        even: true,
        cols: [[
            {title: '操作', minWidth: 140, align: 'center', toolbar: '#rowToolbar', fixed: 'left'},
            {type: 'numbers', title: '序号', width: 100, align: 'center', fixed: 'left'},
            {field: 'fid', title: '楼层ID', minWidth: 100, align: 'center', sort: true},
            {field: 'uid', title: '用户ID', minWidth: 100, align: 'center', sort: true},
            {field: 'pid', title: '帖子ID', minWidth: 100, align: 'center', sort: true},
            {field: 'content', title: '内容', minWidth: 450, align: 'center'},
            {
                field: 'date', title: '日期', minWidth: 200, align: 'center', sort: true, templet: function (res) {
                    return new Date(res.date).Format('yyyy-MM-dd hh:mm:ss');
                }
            },
            {field: 'commentNum', title: '评论数', minWidth: 100, align: 'center', sort: true}
        ]]
    });

    // 评论表
    table.render({
        elem: '#commentTable',
        url: '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/commentServlet?action=getAllComments',
        toolbar: '#toolbar',
        defaultToolbar: ['filter', 'exports'],
        title: '评论表',
        skin: 'row',
        even: true,
        cols: [[
            {title: '操作', minWidth: 140, align: 'center', toolbar: '#rowToolbar', fixed: 'left'},
            {type: 'numbers', title: '序号', width: 100, align: 'center', fixed: 'left'},
            {field: 'cid', title: '评论ID', minWidth: 100, align: 'center', sort: true},
            {field: 'uid', title: '用户ID', minWidth: 100, align: 'center', sort: true},
            {field: 'fid', title: '楼层ID', minWidth: 100, align: 'center', sort: true},
            {field: 'replyUid', title: '回复用户ID', minWidth: 130, align: 'center', sort: true},
            {field: 'replyFloorth', title: '回复楼层', minWidth: 130, align: 'center', sort: true},
            {field: 'content', title: '内容', minWidth: 450, align: 'center'},
            {
                field: 'date', title: '日期', minWidth: 200, align: 'center', sort: true, templet: function (res) {
                    return new Date(res.date).Format('yyyy-MM-dd hh:mm:ss');
                }
            }
        ]]
    });


    // edit中的日期显示（帖子表）
    laydate.render({
        elem: '#post_date',
        type: 'datetime'
    });
    // edit中的日期显示（楼层表）
    laydate.render({
        elem: '#floor_date',
        type: 'datetime'
    });
    // edit中的日期显示（评论表）
    laydate.render({
        elem: '#comment_date',
        type: 'datetime'
    });


    // 监听头部工具栏（用户表）
    table.on('toolbar(userTable)', function (obj) {
        let checkStatus = table.checkStatus(obj.config.id);
        switch (obj.event) {
            case 'reload':
                table.reload('userTable');
                break;
        }
    });

    // 监听头部工具栏（帖子表）
    table.on('toolbar(postTable)', function (obj) {
        let checkStatus = table.checkStatus(obj.config.id);
        switch (obj.event) {
            case 'reload':
                table.reload('postTable');
                break;
        }
    });

    // 监听头部工具栏（楼层表）
    table.on('toolbar(floorTable)', function (obj) {
        let checkStatus = table.checkStatus(obj.config.id);
        switch (obj.event) {
            case 'reload':
                table.reload('floorTable');
                break;
        }
    });

    // 监听头部工具栏（评论表）
    table.on('toolbar(commentTable)', function (obj) {
        let checkStatus = table.checkStatus(obj.config.id);
        switch (obj.event) {
            case 'reload':
                table.reload('commentTable');
                break;
        }
    });


    // 监听行工具事件（用户表）
    table.on('tool(userTable)', function (obj) {
        let data = obj.data;
        data.date = new Date(data.date).Format('yyyy-MM-dd hh:mm:ss');

        switch (obj.event) {
            case 'edit':
                layer.open({
                    type: 1,
                    title: '编辑用户',
                    content: $('#editUser'),
                    area: [700, 500],
                    success: function () {
                        $('#editUser').children()[0].reset();
                        form.val('editUser', data);
                    },
                    end: function (index, layero) {
                        $('#editUser').hide();
                    },
                });
                break;
            case 'del':
                layer.confirm('确认删除吗', function (index) {
                    $.getJSON(
                        '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                        {
                            'action': 'deleteUserByUid',
                            'uid': data.uid
                        },
                        function (data) {
                            if (data.status === 'success') {
                                table.reload('userTable');
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 2});
                            }
                        }
                    )
                    layer.close(index);
                });
                break;
        }
    });

    // 监听行工具事件（帖子表）
    table.on('tool(postTable)', function (obj) {
        let data = obj.data;
        data.date = new Date(data.date).Format('yyyy-MM-dd hh:mm:ss');

        switch (obj.event) {
            case 'edit':
                layer.open({
                    type: 1,
                    title: '编辑帖子',
                    content: $('#editPost'),
                    area: [700, 500],
                    success: function () {
                        $('#editPost').children()[0].reset();
                        form.val('editPost', data);
                    },
                    end: function (index, layero) {
                        $('#editPost').hide();
                    },
                });
                layer.msg('aaa');
                break;
            case 'del':
                layer.confirm('确认删除吗', function (index) {
                    $.getJSON(
                        '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/postServlet',
                        {
                            'action': 'deletePostByPid',
                            'pid': data.pid,
                            'uid': data.uid
                        },
                        function (data) {
                            if (data.status === 'success') {
                                table.reload('postTable');
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 2});
                            }
                        }
                    )
                    layer.close(index);
                });
                break;
        }
    });

    // 监听行工具事件（楼层表）
    table.on('tool(floorTable)', function (obj) {
        let data = obj.data;
        data.date = new Date(data.date).Format('yyyy-MM-dd hh:mm:ss');

        switch (obj.event) {
            case 'edit':
                layer.open({
                    type: 1,
                    title: '编辑楼层',
                    content: $('#editFloor'),
                    area: [700, 500],
                    success: function () {
                        $('#editFloor').children()[0].reset();
                        form.val('editFloor', data);
                    },
                    end: function (index, layero) {
                        $('#editFloor').hide();
                    },
                });
                break;
            case 'del':
                layer.confirm('确认删除吗', function (index) {
                    $.getJSON(
                        '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/floorServlet',
                        {
                            'action': 'deleteFloorByFid',
                            'fid': data.fid,
                            'pid': data.pid
                        },
                        function (data) {
                            if (data.status === 'success') {
                                table.reload('floorTable');
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 2});
                            }
                        }
                    )
                    layer.close(index);
                });
                break;
        }
    });

    // 监听行工具事件（评论表）
    table.on('tool(commentTable)', function (obj) {
        let data = obj.data;
        data.date = new Date(data.date).Format('yyyy-MM-dd hh:mm:ss');

        switch (obj.event) {
            case 'edit':
                layer.open({
                    type: 1,
                    title: '编辑评论',
                    content: $('#editComment'),
                    area: [700, 500],
                    success: function () {
                        $('#editComment').children()[0].reset();
                        form.val('editComment', data);
                    },
                    end: function (index, layero) {
                        $('#editComment').hide();
                    },
                });
                break;
            case 'del':
                layer.confirm('确认删除吗', function (index) {
                    $.getJSON(
                        '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/commentServlet',
                        {
                            'action': 'deleteCommentByCid',
                            'cid': data.cid,
                            'fid': data.fid
                        },
                        function (data) {
                            if (data.status === 'success') {
                                table.reload('commentTable');
                                layer.msg('删除成功！', {icon: 1});
                            } else {
                                layer.msg('删除失败！', {icon: 2});
                            }
                        }
                    )
                    layer.close(index);
                });
                break;
        }
    });

    form.verify({
        password: [
            /^\w{5,8}$/
            , '密码应只含数字字母，长度5-8位'
        ]
    });

    // edit中的表单提交事件（用户表）
    form.on('submit(user_edit)', function (data) {
        data = data.field;

        layer.confirm('确认修改吗？', function (index) {
            $.getJSON(
                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                {
                    'action': 'editUserByUid',
                    'uid': data.uid,
                    'username': data.username,
                    'password': data.password,
                    'email': data.email,
                    'gender': data.gender,
                    'avatar': data.avatar
                },
                function (data) {
                    if (data.status === 'success') {
                        layer.closeAll();
                        table.reload('userTable');
                        layer.msg('修改成功！', {icon: 1});
                    } else {
                        layer.msg('修改失败！', {icon: 2});
                    }
                }
            )
            layer.close(index);
        });
    });

    // edit中的表单提交事件（帖子表）
    form.on('submit(post_edit)', function (data) {
        data = data.field;

        layer.confirm('确认修改吗？', function (index) {
            $.getJSON(
                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/postServlet',
                {
                    'action': 'editPostByPid',
                    'pid': data.pid,
                    'title': data.title,
                    'content': data.content,
                    'imgUrl': data.imgUrl,
                    'date': data.date
                },
                function (data) {
                    if (data.status === 'success') {
                        layer.closeAll();
                        table.reload('postTable');
                        layer.msg('修改成功！', {icon: 1});
                    } else {
                        layer.msg('修改失败！', {icon: 2});
                    }
                }
            )
            layer.close(index);
        });
    });

    // edit中的表单提交事件（楼层表）
    form.on('submit(floor_edit)', function (data) {
        data = data.field;

        layer.confirm('确认修改吗？', function (index) {
            $.getJSON(
                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/floorServlet',
                {
                    'action': 'editFloorByFid',
                    'fid': data.fid,
                    'content': data.content,
                    'date': data.date
                },
                function (data) {
                    if (data.status === 'success') {
                        layer.closeAll();
                        table.reload('floorTable');
                        layer.msg('修改成功！', {icon: 1});
                    } else {
                        layer.msg('修改失败！', {icon: 2});
                    }
                }
            )
            layer.close(index);
        });
    });

    // edit中的表单提交事件（评论表）
    form.on('submit(comment_edit)', function (data) {
        data = data.field;

        layer.confirm('确认修改吗？', function (index) {
            $.getJSON(
                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/commentServlet',
                {
                    'action': 'editCommentByCid',
                    'cid': data.cid,
                    'content': data.content,
                    'date': data.date
                },
                function (data) {
                    if (data.status === 'success') {
                        layer.closeAll();
                        table.reload('commentTable');
                        layer.msg('修改成功！', {icon: 1});
                    } else {
                        layer.msg('修改失败！', {icon: 2});
                    }
                }
            )
            layer.close(index);
        });
    });
</script>
</body>
</html>