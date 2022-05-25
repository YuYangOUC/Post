package com.ouc.servlet;

import com.ouc.bean.Admin;
import com.ouc.service.AdminService;
import com.ouc.service.impl.AdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/adminServlet")
public class AdminServlet extends BaseServlet {

    protected final AdminService adminService = new AdminServiceImpl();

    protected void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (adminService.isAdminExist(username)) {
            Admin admin = adminService.login(username, password);
            if (admin != null) {
                req.getSession().removeAttribute("user");
                req.getSession().setAttribute("admin", admin);
                resp.sendRedirect(req.getContextPath() + "/pages/admin/index.jsp");
            } else {
                req.setAttribute("msg", "密码错误！");
                req.setAttribute("username", username);
                req.setAttribute("password", password);
                req.getRequestDispatcher("/pages/admin/login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("msg", "用户名不存在！");
            req.setAttribute("username", username);
            req.setAttribute("password", password);
            req.getRequestDispatcher("/pages/admin/login.jsp").forward(req, resp);
        }
    }

    protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();
        resp.sendRedirect(req.getContextPath());
    }
}
