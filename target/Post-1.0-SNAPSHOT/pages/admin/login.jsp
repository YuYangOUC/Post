<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>管理员登录</title>
	<%@ include file="/pages/common/head.jsp" %>
	<link rel="stylesheet" href="static/css/login&register.css">
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>
<div class="admin-login-background">
	<div class="admin-header">
		<span>管理员登录</span>
	</div>
	<form class="layui-form" action="adminServlet" method="post">
		<input type="hidden" name="action" value="login">
		<div>
			<i class="layui-icon layui-icon-username admin-icon"></i>
			<input type="text" name="username" placeholder="用户名" autocomplete="off"
				   lay-verify="required" lay-vertype="tips"
				   class="layui-input admin-input admin-input-username" value="${requestScope.username}">
		</div>
		<div>
			<i class="layui-icon layui-icon-password admin-icon"></i>
			<input type="password" name="password" placeholder="密码（只含数字字母，长度5-8位）" autocomplete="off"
				   lay-verify="required|password" lay-vertype="tips"
				   class="layui-input admin-input admin-input-verify" value="${requestScope.password}">
		</div>
		<button class="layui-btn admin-button" lay-submit lay-filter="login">登 录</button>
	</form>
</div>
<script>
    $('#login').addClass('layui-this');

    if ('${requestScope.msg}' !== '') {
        layer.msg('${requestScope.msg}')
    }

    form.verify({
        password: [
            /^\w{5,8}$/
            , '密码应只含数字字母，长度5-8位'
        ]
    });

    // 进行登录操作
    form.on('submit(login)', function (data) {
        layer.load(2);
    });
</script>
</body>
</html>
