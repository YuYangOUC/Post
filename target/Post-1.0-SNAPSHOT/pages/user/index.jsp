<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>OUC の 贴吧</title>
	<%@ include file="/pages/common/head.jsp" %>
	<link rel="stylesheet" href="static/css/comment2018.css">
	<style>
        .noPost {
            text-align: center;
            padding: 30px 0;
            color: #777;
        }
	</style>
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>

<div style="position: absolute;height: 0;width:900px; left: 50%;margin-left: -450px;">
	<div class="head">
		<img src="static/img/head.png" class="headImg">
		<div class="headTxt">贴 吧 首 页</div>
	</div>

	<div class="layui-form-item" style="position: fixed;top: 15px;left: 400px;z-index: 1;">
		<form class="layui-form" action="postServlet" method="post">
			<input type="hidden" name="action" value="listPostsLikeTitle">
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="keyword" autocomplete="off" placeholder="根据标题查找"
					   value="${requestScope.keyword}" style="height: 30px">
			</div>
			<button class="layui-btn layui-btn-sm"><i class="layui-icon layui-icon-search"></i></button>
		</form>
	</div>

	<div class="item">
		<c:if test="${empty requestScope.posts}">
			<div class="litem post noPost">—— 暂无帖子 ——</div>
		</c:if>
		<c:forEach items="${requestScope.posts}" var="post" varStatus="status">
			<div class="litem post" id="${status.index}">
				<div class="item_head"><img class="avatar" src=""></div>
				<div class="item_body">
					<div class="item_body_head">
						<a class="item_name rely_c2 username"></a>
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
<script>
    $('#index').addClass('layui-this');
</script>
</body>
</html>