<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>用户注册</title>
	<%@ include file="/pages/common/head.jsp" %>
	<link rel="stylesheet" href="static/css/login&register.css">
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>
<div class="admin-login-background">
	<div class="admin-header">
		<span>用户注册</span>
	</div>
	<form class="layui-form" action="userServlet" method="post" lay-filter="register">
		<input type="hidden" name="action" value="register">
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
				   class="layui-input admin-input" value="${requestScope.password}">
		</div>
		<div>
			<i class="layui-icon layui-icon-password admin-icon"></i>
			<input type="password" name="repwd" placeholder="确认密码" autocomplete="off"
				   lay-verify="required|repwd" lay-vertype="tips"
				   class="layui-input admin-input" value="${requestScope.repwd}">
		</div>
		<div>
			<i class="layui-icon layui-icon-email admin-icon"></i>
			<input type="text" name="email" placeholder="请输入邮箱" autocomplete="off"
				   lay-verify="required|email" lay-vertype="tips"
				   class="layui-input admin-input" value="${requestScope.email}">
		</div>
		<div>
			<input type="text" name="captcha" placeholder="请输入验证码" autocomplete="off"
				   lay-verify="required" lay-vertype="tips"
				   class="layui-input admin-input admin-input-verify">
			<a href="javascript:"><img class="admin-captcha" width="90" height="30" src="kaptchaServlet"></a>
		</div>
		<button class="layui-btn admin-button" lay-submit lay-filter="register">注 册</button>
	</form>
</div>

<script>
    $('#register').addClass('layui-this');

    if ('${requestScope.msg}' !== '') {
        layer.msg('${requestScope.msg}')
    }

    $('.admin-captcha').on('click', function () {
        $(this).attr('src', 'kaptchaServlet');
	})

    form.verify({
        password: [
            /^\w{5,8}$/
            , '密码应只含数字字母，长度5-8位'
        ],
		repwd: function (value, item) {
            if(value !== form.val('register').password){
                return '确认密码与密码不一致';
            }
		},
    });

    form.on('submit(register)', function (data) {
        layer.load(2);
    });
</script>
</body>
</html>