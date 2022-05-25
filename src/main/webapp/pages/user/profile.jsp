<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>个人主页</title>
	<%@ include file="/pages/common/head.jsp" %>
	<link rel="stylesheet" href="static/css/comment2018.css">
	<style>
        .container {
            width: 960px;
            margin: auto;
            padding: 60px 0 10px 0;
            background-color: #FFFFFF;
            opacity: 0.9;
        }

        .user-box {
            display: flex;
            width: 910px;
            padding: 20px 0;
            margin: auto
        }

        #user-avatar {
            border: 2px solid #ccc;
            border-radius: 50%;
            width: 90px;
            height: 90px;
        }

        .user-body {
            margin-left: 30px;
            height: 140px;
        }

        .litem {
            opacity: 1;
        }

        .noPost {
            text-align: center;
            padding: 20px 0;
            color: #777;
        }
	</style>
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>

<div style="height: 0;">
	<div class="container">
		<div class="user-box">
			<div class="user-head">
				<img src="${sessionScope.user.avatar}" id="user-avatar">
			</div>
			<div class="user-body">
				<form class="layui-form layui-form-pane" action="userServlet" method="post">
					<input type="hidden" name="action" value="editProfile">
					<input type="hidden" name="uid" value="${sessionScope.user.uid}">
					<input type="hidden" name="avatar" value="${sessionScope.user.avatar}">
					<div class="layui-form-item">
						<label class="layui-form-label">用户名</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" name="username" autocomplete="off"
								   lay-verify="required" lay-vertype="tips"
								   value="${sessionScope.user.username}" disabled="disabled">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">邮箱</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" name="email" autocomplete="off"
								   lay-verify="required|email" lay-vertype="tips"
								   value="${sessionScope.user.email}" disabled="disabled">
						</div>
					</div>
					<div class="layui-form-item" style="position: relative;top: -106px;left: 410px;">
						<label class="layui-form-label">性别</label>
						<div class="layui-input-block">
							<input type="radio" name="gender" value="male" title="男" disabled>
							<input type="radio" name="gender" value="female" title="女" disabled>
							<input type="radio" name="gender" value="notSet" title="未设置" disabled>
						</div>
					</div>
					<div class="layui-form-item" style="position: relative;top: -106px;left: 410px;">
						<label class="layui-form-label">发帖数</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" name="postNum" autocomplete="off"
								   lay-verify="required" lay-vertype="tips"
								   value="${sessionScope.user.postNum}" disabled="disabled">
						</div>
					</div>
					<div class="layui-form-item" style="display:none;position: relative;top: -106px;">
						<button type="submit" id="edit-confirm" class="layui-btn" lay-submit lay-filter="edit-confirm"
								style="width: 110px">确认修改
						</button>
					</div>
					<div class="layui-form-item" style="position: relative;top: -106px;">
						<button type="button" id="edit" class="layui-btn layui-btn-primary layui-border-green"
								style="width: 110px">
							修改信息
						</button>
					</div>
					<div class="layui-form-item"
						 style="display:none;position: relative;top: -166px;left: -120px;width: 88px;">
						<div class="layui-upload">
							<button type="button" class="layui-btn layui-btn-xs" id="uploadImg" style="width: 88px">上传头像
							</button>
							<div id="progress" style="margin-top: 4px;display: none">
								<div class="layui-progress layui-progress-big" lay-showpercent="yes"
									 lay-filter="uploadProgress">
									<div class="layui-progress-bar" lay-percent=""></div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>

		<hr class="layui-border-orange">

		<div class="item" style="top: 0;">
			<c:if test="${empty requestScope.posts}">
				<div class="noPost">—— 暂未发帖 ——</div>
			</c:if>
			<c:forEach items="${requestScope.posts}" var="post" varStatus="status">
				<div class="litem post" id="${status.index}">
					<div class="item_head"><img class="avatar" src=""></div>
					<div class="item_body">
						<div class="item_body_head">
							<a class="item_name rely_c2 username" target="_blank" href=""></a>
						</div>
						<div class="item_title title">
							<a class="title" href="pages/post/details.jsp?pid=${post.pid}">${post.title}</a>
						</div>
						<div class="item_txt content">　　${post.content}</div>
						<c:if test="${!empty post.imgUrl}">
							<img class="imgUrl" src="${post.imgUrl}">
						</c:if>
						<div class="item_footer">
							<div class="item_footer2 date"><i class="layui-icon layui-icon-time"></i> ${post.date}</div>
							<div class="item_footer2">
								<a href="pages/post/details.jsp?pid=${post.pid}">
								<span class="rely_c2 floorNum"><i
										class="layui-icon layui-icon-chat"></i> 共${post.floorNum}楼</span>
								</a>
							</div>
						</div>
					</div>
				</div>

				<script>
                    $.getJSON(
                        '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                        {
                            'action': 'getUserByUid',
                            'uid': ${post.uid}
                        },
                        function (data) {
                            $('#${status.index} .avatar').attr('src', data.user.avatar);
                            $('#${status.index} .username').text(data.user.username);
                        }
                    )
				</script>
			</c:forEach>
		</div>
	</div>
</div>

<script>
    // 检查user是否登录
    if (${empty sessionScope.user}) {
        window.location.href = 'pages/user/login.jsp';
    }

    if ('${sessionScope.user.gender}' === 'male') {
        $('[value=male]').prop('checked', true);
    } else if ('${sessionScope.user.gender}' === 'female') {
        $('[value=female]').prop('checked', true);
    } else {
        $('[value=notSet]').prop('checked', true);
    }

    $('#edit').on('click', function () {
        $('#uploadImg').parent().parent().show();
        $('input').not('[name=postNum]').attr("disabled", false);
        $(':radio').next().removeClass('layui-radio-disbaled').removeClass('layui-disabled');

        $('#edit').parent().hide();
        $('#edit-confirm').parent().show();
        layer.msg('可直接在页面上修改');
    });

    let uploadInst = upload.render({
        elem: '#uploadImg',
        url: 'uploadServlet',
        accept: 'images',
        acceptMime: 'image/*',
        size: 0.5 * 1024,
        before: function (obj) {
            //预读本地文件示例，不支持ie8
            obj.preview(function (index, file, result) {
                $('#user-avatar').attr('src', result); // 图片链接（base64）
            });

            element.progress('uploadProgress', '0%'); // 进度条复位
            $('#progress').show(); // 显示进度条
            layer.msg('上传中', {icon: 16, time: 0});
        },
        done: function (res) {
            // 如果上传失败
            if (res.code > 0) {
                return layer.msg('上传失败', {icon: 2});
            } else {
                $('[name=avatar]').val(res.data.src); // 已经上传在服务器中的路径
            }
        },
        //进度条
        progress: function (n, index, e) {
            element.progress('uploadProgress', n + '%'); // 可配合 layui 进度条元素使用
            if (n === 100) {
                layer.msg('上传完毕', {icon: 1});
            }
        }
    });

    form.on('submit(edit-confirm)', function (data) {
        layer.load(2);
    });
</script>
</body>
</html>