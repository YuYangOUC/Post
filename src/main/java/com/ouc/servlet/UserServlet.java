package com.ouc.servlet;

import com.google.gson.Gson;
import com.ouc.bean.User;
import com.ouc.service.UserService;
import com.ouc.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

@WebServlet(value = "/userServlet")
public class UserServlet extends BaseServlet {

    private final UserService userService = new UserServiceImpl();

    protected void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 获取Session中的验证码
        String sessionCaptcha = (String) req.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        // 删除Session中的验证码
        req.getSession().removeAttribute(KAPTCHA_SESSION_KEY);

        // 1.获取请求参数
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String repwd = req.getParameter("repwd");
        String email = req.getParameter("email");
        String captcha = req.getParameter("captcha");

        // 2.检查验证码是否正确
        if (sessionCaptcha != null && sessionCaptcha.equalsIgnoreCase(captcha)) {
            // 3.检查用户名是否可用
            if (!userService.isUsernameExist(username)) {
                if (userService.register(new User(username, password, email)) > 0) {
                    req.getSession().setAttribute("reg", "success");
                    resp.sendRedirect(req.getContextPath() + "/pages/user/login.jsp");
                } else {
                    req.setAttribute("msg", "注册失败！");
                    req.setAttribute("username", username);
                    req.setAttribute("password", password);
                    req.setAttribute("repwd", repwd);
                    req.setAttribute("email", email);
                    req.getRequestDispatcher("/pages/user/register.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("msg", "用户名已存在！");
                req.setAttribute("username", username);
                req.setAttribute("password", password);
                req.setAttribute("repwd", repwd);
                req.setAttribute("email", email);
                req.getRequestDispatcher("/pages/user/register.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("msg", "验证码错误！");
            req.setAttribute("username", username);
            req.setAttribute("password", password);
            req.setAttribute("repwd", repwd);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/pages/user/register.jsp").forward(req, resp);
        }
    }

    protected void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1.获取请求参数
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 2.验证用户名是否存在
        if (userService.isUsernameExist(username)) {
            // 3.验证用户名与密码是否匹配
            User user = userService.login(username, password);
            if (user != null) {
                req.getSession().removeAttribute("admin");
                req.getSession().setAttribute("user", user);
                resp.sendRedirect(req.getContextPath());
            } else {
                req.setAttribute("msg", "密码错误！");
                req.setAttribute("username", username);
                req.setAttribute("password", password);
                req.getRequestDispatcher("/pages/user/login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("msg", "用户名不存在！");
            req.setAttribute("username", username);
            req.setAttribute("password", password);
            req.getRequestDispatcher("/pages/user/login.jsp").forward(req, resp);
        }
    }

    protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1.销毁Session中用户登录的信息(销毁Session)
        req.getSession().invalidate();
        // 2.重定向到首页
        resp.sendRedirect(req.getContextPath());
    }

    protected void getAllUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userService.queryUsers();

        HashMap<String, Object> map = new HashMap<>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("data", users);

        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void getUserByUid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        User user = userService.queryUserByUid(uid);

        // 对密码进行抹除
        user.setPassword("UnKnow");

        Map<String, Object> map = new HashMap<>();
        map.put("user", user);
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void deleteUserByUid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));

        HashMap<String, Object> map = new HashMap<>();
        if (userService.deleteUserByUid(uid) > 0) {
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void editUserByUid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String gender = req.getParameter("gender");
        String avatar = req.getParameter("avatar");

        HashMap<String, Object> map = new HashMap<>();
        if (userService.updateUserByUid(uid, username, password, email, gender, avatar) > 0) {
            map.put("status", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }

    protected void editProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String gender = req.getParameter("gender");
        String avatar = req.getParameter("avatar");

        if (userService.updateProfile(uid, username, email, gender, avatar) > 0) {
            User user = userService.queryUserByUid(uid);
            req.getSession().setAttribute("user", user);
        }
        resp.sendRedirect(req.getContextPath() + "/postServlet?action=getPostsByUid&uid=" + uid);
    }

    protected void editPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer uid = Integer.valueOf(req.getParameter("uid"));
        String password_old = req.getParameter("password_old");
        String password_new = req.getParameter("password_new");

        HashMap<String, Object> map = new HashMap<>();
        if (!password_old.equals(userService.queryUserByUid(uid).getPassword())) {
            map.put("status", "wrong");
        } else if (userService.updatePassword(uid, password_new) > 0) {
            map.put("status", "success");
            req.getSession().invalidate();
            req.getSession().setAttribute("editPW", "success");
        } else {
            map.put("status", "fail");
        }
        String json = new Gson().toJson(map);
        resp.getWriter().write(json);
    }
}