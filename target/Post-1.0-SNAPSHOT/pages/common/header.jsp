<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%--修改密码页面--%>
<div id="editPassword" style="display: none;padding: 20px 20px 0 20px;">
	<form class="layui-form layui-form-pane" lay-filter="editPassword">
		<input type="hidden" name="uid" value="${sessionScope.user.uid}">
		<div class="layui-form-item">
			<label class="layui-form-label">旧密码</label>
			<div class="layui-input-block">
				<input type="password" class="layui-input" name="password_old" autocomplete="off"
					   lay-verify="required|password" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码</label>
			<div class="layui-input-block">
				<input type="password" class="layui-input" name="password_new" autocomplete="off"
					   lay-verify="required|password" lay-vertype="tips">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block" style="float: right">
				<button type="button" class="layui-btn" lay-submit lay-filter="submitEdit">立即修改</button>
			</div>
		</div>
	</form>
</div>

<div class="layui-layout layui-layout-admin" style="position: relative;z-index:1;opacity: 0.9;">
	<div class="layui-header">
		<div class="layui-logo" style="font-size: 20px;font-weight: bold">OUC の 贴吧</div>

		<c:if test="${empty sessionScope.admin}">
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item" id="index"><a href="">首页</a></li>
				<li class="layui-nav-item" id="upload"><a href="pages/post/upload.jsp">发表帖子</a></li>
			</ul>
		</c:if>
		<c:if test="${not empty sessionScope.admin}">
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item" id="index"><a href="">首页</a></li>
				<li class="layui-nav-item" id="admin"><a href="pages/admin/index.jsp">后台管理</a></li>
			</ul>
		</c:if>

		<c:if test="${empty sessionScope.user && empty sessionScope.admin}">
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item" id="login" style="margin-right: 10px">
					<a href="javascript:">登录</a>
					<dl class="layui-nav-child">
						<dd><a href="pages/user/login.jsp">用户登录</a></dd>
						<dd><a href="pages/admin/login.jsp">管理员登录</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item" id="register"><a href="pages/user/register.jsp">注册</a></li>
			</ul>
		</c:if>
		<c:if test="${not empty sessionScope.user}">
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
					<a href="javascript:">
						<img src="${sessionScope.user.avatar}" class="layui-nav-img">
							${sessionScope.user.username}
					</a>
					<dl class="layui-nav-child">
						<dd><a href="postServlet?action=getPostsByUid&uid=${sessionScope.user.uid}">个人主页</a></dd>
						<dd><a href="javascript:" id="editPassword_btn">修改密码</a></dd>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="userServlet?action=logout">Sign out</a></li>
			</ul>
		</c:if>
		<c:if test="${not empty sessionScope.admin}">
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
					<img src="static/img/default_avatar.png" class="layui-nav-img">
						${sessionScope.admin.username}
				</li>
				<li class="layui-nav-item"><a href="adminServlet?action=logout">Sign out</a></li>
			</ul>
		</c:if>
	</div>
</div>
<script>
    let form = layui.form;
    let table = layui.table;
    let laydate = layui.laydate;
    let upload = layui.upload;
    let element = layui.element;

    $('#upload').on('click', function () {
        if (${empty sessionScope.user}) {
            layer.confirm('登录可发帖，是否登录?',
                {
                    icon: 3,
                    title: '提示',
                    anim: 4,
                    end: function (index) {
                        $('#upload').removeClass('layui-this');
                    }
                },
                function (index) {
                    location.href = '${pageContext.request.contextPath}/pages/user/login.jsp'
                }
            );
            return false;
        }
    })

    // 弹出修改密码页面
    $('#editPassword_btn').on('click', function () {
        layer.open({
            type: 1,
            title: '修改密码',
            content: $('#editPassword'),
            area: [400, 235],
            success: function () {
                $('#editPassword').children()[0].reset();
            },
            end: function (index, layero) {
                $('#editPassword').hide();
            },
        });
    });

    form.verify({
        password: [
            /^\w{5,8}$/
            , '密码应只含数字字母，长度5-8位'
        ]
    });

    // 修改密码的表单提交事件（用户表）
    form.on('submit(submitEdit)', function (data) {
        data = data.field;

        layer.confirm('确认修改吗？', function (index) {
            $.getJSON(
                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                {
                    'action': 'editPassword',
                    'uid': data.uid,
                    'password_old': data.password_old,
                    'password_new': data.password_new,
                },
                function (data) {
                    if (data.status === 'wrong') {
                        layer.msg('旧密码错误！');
                    } else if (data.status === 'success') {
                        window.location.href = 'pages/user/login.jsp?editPW=success';
                    } else {
                        layer.msg('修改失败！');
                    }
                }
            )
            layer.close(index);
        });
    });
</script>


