package com.ouc.servlet;

import com.google.gson.Gson;
import com.ouc.bean.Comment;
import com.ouc.bean.Floor;
import com.ouc.service.CommentService;
import com.ouc.service.FloorService;
import com.ouc.service.impl.CommentServiceImpl;
import com.ouc.service.impl.FloorServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/commentServlet")
public class CommentServlet extends BaseServlet {

    protected final CommentService commentService = new CommentServiceImpl();
    protected final FloorService floorService = new FloorServiceImpl();

    protected void getAllComments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Comment> comments = commentService.queryComments();

        HashMap<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("data", comments);

        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void getCommentsByFid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer fid = Integer.valueOf(req.getParameter("fid"));
        List<Comment> comments = commentService.queryCommentsByFid(fid);

        HashMap<String, Object> map = new HashMap<>();
        map.put("comments", comments);
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void addComment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        Integer pid = Integer.valueOf(req.getParameter("pid"));
        Integer fid = Integer.valueOf(req.getParameter("fid"));
        String content = req.getParameter("content");

        Comment comment = null;
        if (req.getParameter("replyFloorth") == null) {
            comment = new Comment(uid, fid, null, null, content, new Date());
        } else {
            Integer replyUid = Integer.valueOf(req.getParameter("replyUid"));
            Integer replyFloorth = Integer.valueOf(req.getParameter("replyFloorth"));
            comment = new Comment(uid, fid, replyUid, replyFloorth, content, new Date());
        }

        if (commentService.addComment(comment) > 0) {
            Floor floor = floorService.queryFloorByFid(fid);
            floorService.updateCommentNum(fid, floor.getCommentNum() + 1);
        }
        resp.sendRedirect(req.getContextPath() + "/pages/post/details.jsp?pid=" + pid);
    }

    protected void deleteCommentByCid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer cid = Integer.valueOf(req.getParameter("cid"));
        Integer fid = Integer.valueOf(req.getParameter("fid"));

        Map<String, Object> map = new HashMap<>();
        if (commentService.deleteComment(cid) > 0) {
            Floor floor = floorService.queryFloorByFid(fid);
            floorService.updateCommentNum(fid, floor.getCommentNum() - 1);
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void editCommentByCid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer cid = Integer.valueOf(req.getParameter("cid"));
        String content = req.getParameter("content");
        String date = req.getParameter("date");

        Map<String, Object> map = new HashMap<>();
        if (commentService.updateComment(cid, content, date) > 0) {
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }
}
