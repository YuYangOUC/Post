<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>发表帖子</title>
	<%@ include file="/pages/common/head.jsp" %>
	<link rel="stylesheet" href="static/css/comment2018.css">
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>

<div style="margin:auto;max-width:900px;padding-top:8%;">
	<form class="layui-form" action="postServlet">
		<input type="hidden" name="action" value="addPost">
		<input type="hidden" name="uid" value="${sessionScope.user.uid}">
		<input type="hidden" name="imgUrl" value="">
		<input type="text" name="title" placeholder="请输入标题（最大长度30）" autocomplete="off" maxlength="30"
			   class="reply_inputborder reply_input_title" style="width: 100%;margin-bottom: 10px">
		<textarea name="content" placeholder="请书写帖子内容" cols="65" rows="8"
				  class="reply_inputborder" style="width: 100%;"></textarea>
		<div style="margin-top: 60px;float: right;font-weight: bold">
			<button class="layui-btn layui-btn-normal layui-btn-radius" lay-submit lay-filter="post">发 表 帖 子</button>
		</div>
	</form>

	<%--上传图片--%>
	<div class="layui-upload" style="margin-top: 20px">
		<button type="button" class="layui-btn layui-btn-normal layui-btn-sm" id="uploadImg">
			<i class="layui-icon layui-icon-upload"></i> 上传图片
		</button>
		<div id="progress" style="width: 150px;margin-top: 10px;display: none">
			<div class="layui-progress layui-progress-big" lay-showpercent="yes" lay-filter="uploadProgress">
				<div class="layui-progress-bar" lay-percent=""></div>
			</div>
		</div>
		<div class="layui-upload-list">
			<img class="layui-upload-img" id="uploadPreview" style="width: 150px;border-radius: 5px">
			<p id="errorText" style="margin-top: 5px"></p>
		</div>
	</div>
</div>

<script>
    $('#upload').addClass('layui-this');
    // 检查user是否登录
    if (${empty sessionScope.user}) {
        window.location.href = 'pages/user/login.jsp';
    }

    let uploadInst = upload.render({
        elem: '#uploadImg',
        url: 'uploadServlet',
        accept: 'images',
        acceptMime: 'image/*',
        size: 2 * 1024,
        before: function (obj) {
            //预读本地文件示例，不支持ie8
            obj.preview(function (index, file, result) {
                $('#uploadPreview').attr('src', result); // 图片链接（base64）
            });

            element.progress('uploadProgress', '0%'); // 进度条复位
			$('#progress').show(); // 显示进度条
            layer.msg('上传中', {icon: 16, time: 0});
        },
        done: function (res) {
            //如果上传失败
            if (res.code > 0) {
                return layer.msg('上传失败', {icon: 2});
            } else {
                $('[name=imgUrl]').val(res.data.src); // 已经上传在服务器中的路径
                $('#errorText').html(''); // 置空上传失败的状态
            }
        },
        error: function () {
            // 演示失败状态，并实现重传
            let errorText = $('#errorText');
            errorText.html('<span style="color: #ff5722;">上传失败！</span> <a class="layui-btn layui-btn-xs layui-btn-normal reload">重试</a>');
            errorText.find('.reload').on('click', function () {
                uploadInst.upload();
            });
        },
        //进度条
        progress: function (n, index, e) {
            element.progress('uploadProgress', n + '%'); // 可配合 layui 进度条元素使用
            if (n === 100) {
                layer.msg('上传完毕', {icon: 1});
            }
        }
    });

    form.on('submit(post)', function (data) {
        data = data.field;
        if (data.title === '') {
            layer.msg('标题不能为空');
            return false;
        }
        if (data.content === '') {
            layer.msg('内容不能为空');
            return false;
        }
        layer.load(2);
    });
</script>
</body>
</html>
