<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>帖子详情</title>
	<%@ include file="/pages/common/head.jsp" %>
	<link rel="stylesheet" href="static/css/comment2018.css">
</head>
<body>
<%@ include file="/pages/common/header.jsp" %>

<div style="position: absolute;height: 0;width:900px; left: 50%;margin-left: -450px;">
	<div class="head">
		<img src="static/img/head.png" class="headImg">
		<div class="headTxt"></div>
	</div>
	<div class="item">
		<div class="litem post">
			<div class="item_head"><img class="avatar" src=""></div>
			<div class="item_body">
				<div class="item_body_head">
					<a class="item_name"><span class="rely_c2 username"></span></a>
				</div>
				<div class="item_title title"></div>
				<div class="item_txt content"></div>
				<div class="post_img"></div>
				<div class="item_footer">
					<div class="item_footer2 date"><i class="layui-icon layui-icon-time"></i></div>
					<div class="item_footer2 floorNum"><i class="layui-icon layui-icon-chat"></i></div>
				</div>
			</div>
		</div>

		<form class="layui-form" action="floorServlet" method="post" style="margin: 4px 0">
			<input type="hidden" name="action" value="addFloor">
			<input type="hidden" name="uid" value="${sessionScope.user.uid}">
			<input type="hidden" name="pid" value="${param.pid}">

			<div class="replyPost_btn layui-btn layui-btn-sm layui-btn-normal layui-btn-radius"
				 style="font-weight: bold;">
				<i class="layui-icon layui-icon-dialogue"></i> 发表评论
			</div>
			<div class="reply replyPost" style="position: relative;margin-top: 10px;display: none;">
			<textarea name="content" placeholder="请输入评论内容" rows="5"
					  class="reply_inputborder" style="width: 100%;"></textarea>
				<button class="reply_comment_send" lay-submit lay-filter="reply"
						style="position: absolute;top: 70px;right: -10px">发表评论
				</button>
			</div>
		</form>
	</div>
</div>

<%--填充页面信息--%>
<script>
    let floorStr =
        '<div class="litem">' +
        '	<div class="item_head"><img class="avatar" src=""></div>' +
        '	<div class="item_body">' +
        '		<div class="item_body_head"><a class="item_name"><span class="rely_c2 username"></span></a></div>' +
        '		<div class="item_txt content"></div>' +
        '		<div class="item_footer">' +
        '			<div class="item_footer2 floorth"></div>' +
        '			<div class="item_footer2 date"><i class="layui-icon layui-icon-time"></i> </div>' +
        '			<div class="item_footer2 commentNum"><i class="layui-icon layui-icon-chat"></i> </div>' +
        '			<div class="item_footer2 replyFloor_btn rely_c2"><i class="layui-icon layui-icon-dialogue"></i> 回复</div>' +
        '		</div>' +
        '		<div class="reply replyFloor" style="background-color: #ddd;margin-bottom: 10px;border-radius: 10px;display: none;">' +
        '			<form class="layui-form" action="commentServlet" method="post">' +
        '				<input type="hidden" name="action" value="addComment">' +
        '				<input type="hidden" name="uid" value="">' +
        '				<input type="hidden" name="pid" value="">' +
        '				<input type="hidden" name="fid" value="">' +
        '				<div class="body" style="padding: 6px;position: relative;">' +
        '					<textarea name="content" placeholder="请输入评论内容" rows="3" class="reply_inputborder" style="width: 100%;"></textarea>' +
        '					<button class="reply_comment_send" lay-submit lay-filter="reply" style="position: absolute;top: 44px;right: -4px">发表评论</button>' +
        '				</div>' +
        '			</form>' +
        '		</div>' +
        '	</div>' +
        '</div>';

    let commentStr =
        '<div class="item_reply_sub">' +
        '	<div class="litem">' +
        '		<div class="item_head"><img class="avatar" src=""></div>' +
        '		<div class="item_body">' +
        '			<div class="item_body_head"><a class="item_name"><span class="rely_c2 username"></span></a></div>' +
        '			<div class="reply_txt"></div>' +
        '			<div class="item_txt content"></div>' +
        '			<div class="post_img"></div>' +
        '			<div class="item_footer">' +
        '				<div class="item_footer2 floorth"></div>' +
        '				<div class="item_footer2 date"><i class="layui-icon layui-icon-time"></i> </div>' +
        '				<div class="item_footer2 replyComment_btn rely_c2"><i class="layui-icon layui-icon-dialogue"></i> 回复</div>' +
        '			</div>' +
        '			<div class="reply replyComment" style="margin-bottom: 10px;border-radius: 8px;display: none">' +
        '				<form class="layui-form" action="commentServlet" method="post">' +
        '					<input type="hidden" name="action" value="addComment">' +
        '					<input type="hidden" name="uid" value="">' +
        '					<input type="hidden" name="pid" value="">' +
        '					<input type="hidden" name="fid" value="">' +
        '					<input type="hidden" name="replyUid" value="">' +
        '					<input type="hidden" name="replyFloorth" value="">' +
        '					<div class="body" style="position: relative;border: 2px #aaa solid;border-radius: 8px">' +
        '						<textarea name="content" placeholder="请输入评论内容" class="reply_inputborder" style="height: 38px;width: 100%;"></textarea>' +
        '						<button class="reply_comment_send" lay-submit lay-filter="reply" style="position: absolute;top: 6px;right: -7px">发表评论</button>' +
        '					</div>' +
        '				</form>' +
        '			</div>' +
        '		</div>' +
        '	</div>' +
        '</div>';


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

    // 请求该post的信息
    $.ajax({
        url: '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/postServlet',

        data: {
            'action': 'getPostByPid',
            'pid': ${param.pid}
        },
        dataType: 'json',
        async: false,
        success: function (data) {
            let post = data.post;

            // 向页面中填充post信息
            $.getJSON(
                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                {
                    'action': 'getUserByUid',
                    'uid': post.uid
                },
                function (data) {
                    let user = data.user;
                    $('.post .avatar').attr('src', user.avatar);
                    $('.post .username').text(user.username);
                }
            )
            $('.post .title').text(post.title);
            $('.headTxt').text(post.title);
            $('.post .content').text('　　' + post.content);
            if (post.imgUrl !== '') {
                $('.post .post_img').append('<img class="imgUrl">');
                $('.imgUrl').attr('src', post.imgUrl);
            }
            $('.post .date').append(new Date(post.date).Format('yyyy-MM-dd hh:mm:ss'));
            $('.post .floorNum').append('共' + post.floorNum + '楼');
        }
    });

    // 为发表评论按钮绑定事件
    $('.replyPost_btn').on('click', function () {
        if (${empty sessionScope.user && empty sessionScope.admin}) {
            layer.confirm('登录可评论，是否登录?',
                {
                    icon: 3,
                    title: '提示',
                    anim: 4
                },
                function () {
                    location.href = '${pageContext.request.contextPath}/pages/user/login.jsp'
                },
                function () {
                }
            );
            return false;
        } else if (${not empty sessionScope.admin}) {
            layer.msg('管理员不可以评论哦~');
            return false;
        }
        $('.reply').slideUp();
        let $replyPost = $('.replyPost');
        if ($replyPost.css('display') === 'none') {
            $replyPost.slideDown();
        } else {
            $replyPost.slideUp();
        }
    });

    // 请求该post的floors
    $.getJSON(
        '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/floorServlet',
        {
            'action': 'getFloorsByPid',
            'pid': ${param.pid}
        },
        function (data) {
            let floors = data.floors;

            // 向页面中添加floors
            for (let i = 0; i < floors.length; i++) {
                let $floor = $(floorStr).addClass('floor' + i);
                $('.item').append($floor);

                // 向floor中添加信息
                $.ajax({
                    url: '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                    data: {
                        'action': 'getUserByUid',
                        'uid': floors[i].uid
                    },
                    dataType: 'json',
                    async: false,
                    success: function (data) {
                        let floor_user = data.user;
                        $('.floor' + i + ' .avatar').first().attr('src', floor_user.avatar);
                        $('.floor' + i + ' .username').first().text(floor_user.username);
                    }
                });
                $('.floor' + i + ' .content').first().text('　　' + floors[i].content);
                $('.floor' + i + ' .floorth').first().text(i + 1 + '楼');
                $('.floor' + i + ' .date').first().append(new Date(floors[i].date).Format('yyyy-MM-dd hh:mm:ss'));
                $('.floor' + i + ' .commentNum').first().append(floors[i].commentNum + '条评论');
                $('.floor' + i + ' .replyFloor [name="uid"]').first().val(${sessionScope.user.uid});
                $('.floor' + i + ' .replyFloor [name="pid"]').first().val(${param.pid});
                $('.floor' + i + ' .replyFloor [name="fid"]').first().val(floors[i].fid);

                // 请求该floor的comments
                $.getJSON(
                    '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/commentServlet',
                    {
                        'action': 'getCommentsByFid',
                        'fid': floors[i].fid
                    },
                    function (data) {
                        let comments = data.comments;

                        // 向页面中添加comments
                        for (let j = 0; j < comments.length; j++) {
                            let $comment = $(commentStr);
                            $comment.children('.litem').addClass('comment' + j);
                            $('.floor' + i).children('.item_body').append($comment);

                            // 向comment中添加信息
                            $.getJSON(
                                '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                                {
                                    'action': 'getUserByUid',
                                    'uid': comments[j].uid
                                },
                                function (data) {
                                    let comment_user = data.user;
                                    $('.floor' + i + ' .comment' + j + ' .avatar').attr('src', comment_user.avatar);
                                    $('.floor' + i + ' .comment' + j + ' .username').text(comment_user.username);
                                    // 为form表单中的replyUid字段赋值
                                    $('.floor' + i + ' .comment' + j + ' .replyComment [name="replyUid"]').val(comment_user.uid);
                                }
                            );

                            $('.floor' + i + ' .comment' + j + ' .content').text('　　' + comments[j].content);
                            $('.floor' + i + ' .comment' + j + ' .floorth').text(j + 1 + '楼');
                            $('.floor' + i + ' .comment' + j + ' .date').append(new Date(comments[j].date).Format('yyyy-MM-dd hh:mm:ss'));
                            $('.floor' + i + ' .comment' + j + ' .replyComment [name="uid"]').val(${sessionScope.user.uid});
                            $('.floor' + i + ' .comment' + j + ' .replyComment [name="pid"]').val(${param.pid});
                            $('.floor' + i + ' .comment' + j + ' .replyComment [name="fid"]').val(floors[i].fid);
                            $('.floor' + i + ' .comment' + j + ' .replyComment [name="replyFloorth"]').val(j + 1);

                            // 添加要回复的人及其所在楼层
                            if (comments[j].replyUid !== undefined && comments[j].replyFloorth !== undefined) {
                                $.getJSON(
                                    '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/userServlet',
                                    {
                                        'action': 'getUserByUid',
                                        'uid': comments[j].replyUid
                                    },
                                    function (data) {
                                        let reply_user = data.user;
                                        $('.floor' + i + ' .comment' + j + ' .reply_txt').text('回复 ' + reply_user.username + ' (' + comments[j].replyFloorth + '楼)：');
                                    }
                                );
                            } else {
                                $('.floor' + i + ' .comment' + j + ' .reply_txt').text('回复 ' + $('.floor' + i + ' .username').first().text() + ' (楼主)：');
                            }

                            // 为回复按钮绑定事件
                            $('.floor' + i + ' .comment' + j + ' .replyComment_btn').on('click', function (e) {
                                if (${empty sessionScope.user && empty sessionScope.admin}) {
                                    layer.confirm('登录可评论，是否登录?',
                                        {
                                            icon: 3,
                                            title: '提示',
                                            anim: 4
                                        },
                                        function () {
                                            location.href = '${pageContext.request.contextPath}/pages/user/login.jsp'
                                        },
                                        function () {
                                        }
                                    );
                                    return false;
                                } else if (${not empty sessionScope.admin}) {
                                    layer.msg('管理员不可以评论哦~');
                                    return false;
                                }

                                $('.reply').slideUp();
                                let $replyComment = $('.floor' + i + ' .comment' + j + ' .replyComment');
                                if ($replyComment.css('display') === 'none') {
                                    $replyComment.slideDown();
                                } else {
                                    $replyComment.slideUp();
                                }
                            });
                        }
                    }
                );

                // 为回复按钮绑定事件
                $('.floor' + i + ' .replyFloor_btn').on('click', function () {
                    if (${empty sessionScope.user && empty sessionScope.admin}) {
                        layer.confirm('登录可评论，是否登录?',
                            {
                                icon: 3,
                                title: '提示',
                                anim: 4
                            },
                            function () {
                                location.href = '${pageContext.request.contextPath}/pages/user/login.jsp'
                            },
                            function () {
                            }
                        );
                        return false;
                    } else if (${not empty sessionScope.admin}) {
                        layer.msg('管理员不可以评论哦~');
                        return false;
                    }
                    $('.reply').slideUp();
                    let $replyFloor = $('.floor' + i + ' .replyFloor');
                    if ($replyFloor.css('display') === 'none') {
                        $replyFloor.slideDown();
                    } else {
                        $replyFloor.slideUp();
                    }
                });
            }
        }
    );
</script>

<script>
    form.on('submit(reply)', function (data) {
        data = data.field;
        if (data.content === '') {
            layer.msg('评论内容不能为空');
            return false;
        }
        layer.load(2);
    });
</script>
</body>
</html>