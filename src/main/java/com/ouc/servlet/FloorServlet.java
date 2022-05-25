package com.ouc.servlet;

import com.google.gson.Gson;
import com.ouc.bean.Floor;
import com.ouc.bean.Post;
import com.ouc.service.FloorService;
import com.ouc.service.PostService;
import com.ouc.service.impl.FloorServiceImpl;
import com.ouc.service.impl.PostServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/floorServlet")
public class FloorServlet extends BaseServlet {

    protected final FloorService floorService = new FloorServiceImpl();
    protected final PostService postService = new PostServiceImpl();

    protected void getAllFloors(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Floor> floors = floorService.queryFloors();

        HashMap<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("data", floors);

        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void getFloorsByPid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Integer pid = Integer.valueOf(req.getParameter("pid"));
        List<Floor> floors = floorService.queryFloorsByPid(pid);

        HashMap<String, Object> map = new HashMap<>();
        map.put("floors", floors);
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void addFloor(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        Integer pid = Integer.valueOf(req.getParameter("pid"));
        String content = req.getParameter("content");

        if (floorService.addFloor(new Floor(uid, pid, content, new Date())) > 0) {
            Post post = postService.queryPostByPid(pid);
            postService.updateFloorNum(pid, post.getFloorNum() + 1);
        }
        resp.sendRedirect(req.getContextPath() + "/pages/post/details.jsp?pid=" + pid);
    }

    protected void deleteFloorByFid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer fid = Integer.valueOf(req.getParameter("fid"));
        Integer pid = Integer.valueOf(req.getParameter("pid"));

        Map<String, Object> map = new HashMap<>();
        if (floorService.deleteFloor(fid) > 0) {
            Post post = postService.queryPostByPid(pid);
            postService.updateFloorNum(pid, post.getFloorNum() - 1);
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void editFloorByFid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer fid = Integer.valueOf(req.getParameter("fid"));
        String content = req.getParameter("content");
        String date = req.getParameter("date");

        Map<String, Object> map = new HashMap<>();
        if (floorService.updateFloor(fid, content, date) > 0) {
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }
}
