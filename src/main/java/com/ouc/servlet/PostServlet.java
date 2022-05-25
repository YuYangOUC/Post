package com.ouc.servlet;

import com.google.gson.Gson;
import com.ouc.bean.Post;
import com.ouc.bean.User;
import com.ouc.service.PostService;
import com.ouc.service.UserService;
import com.ouc.service.impl.PostServiceImpl;
import com.ouc.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet(value = "/postServlet")
public class PostServlet extends BaseServlet {

    protected final PostService postService = new PostServiceImpl();
    protected final UserService userService = new UserServiceImpl();

    protected void listPosts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Post> posts = postService.queryPosts();
        Collections.reverse(posts);
        req.setAttribute("posts", posts);
        req.getRequestDispatcher("/pages/user/index.jsp").forward(req, resp);
    }

    protected void listPostsLikeTitle(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Post> posts = postService.queryPostsLikeTitle(keyword);
        Collections.reverse(posts);
        req.setAttribute("posts", posts);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/pages/user/index.jsp").forward(req, resp);
    }

    protected void getAllPosts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Post> posts = postService.queryPosts();

        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("data", posts);

        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void getPostsByUid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        List<Post> posts = postService.queryPostsByUid(uid);

        req.setAttribute("posts", posts);
        req.getRequestDispatcher("/pages/user/profile.jsp").forward(req, resp);
    }

    protected void getPostByPid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer pid = Integer.valueOf(req.getParameter("pid"));
        Post post = postService.queryPostByPid(pid);

        Map<String, Object> map = new HashMap<>();
        map.put("post", post);
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void addPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String imgUrl = req.getParameter("imgUrl");

        if (postService.addPost(new Post(uid, title, content, imgUrl, new Date())) > 0) {
            User user = userService.queryUserByUid(uid);
            userService.updatePostNum(uid, user.getPostNum() + 1);
        }

        resp.sendRedirect(req.getContextPath());
    }

    protected void deletePostByPid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer pid = Integer.valueOf(req.getParameter("pid"));
        Integer uid = Integer.valueOf(req.getParameter("uid"));

        Map<String, Object> map = new HashMap<>();
        if (postService.deletePost(pid) > 0) {
            User user = userService.queryUserByUid(uid);
            userService.updatePostNum(uid, user.getPostNum() - 1);
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void editPostByPid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer pid = Integer.valueOf(req.getParameter("pid"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String imgUrl = req.getParameter("imgUrl");
        String date = req.getParameter("date");

        Map<String, Object> map = new HashMap<>();
        if (postService.updatePost(pid, title, content, imgUrl, date) > 0) {
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }
}
