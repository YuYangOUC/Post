package com.ouc.servlet;

import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.*;

@WebServlet(value = "/uploadServlet")
public class uploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (ServletFileUpload.isMultipartContent(req)) {
            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);

            try {
                List<FileItem> fileItems = servletFileUpload.parseRequest(req);
                for (FileItem fileItem : fileItems) {
                    if (!fileItem.isFormField()) {
                        // 如果上传了图片
                        if (!fileItem.getName().equals("")) {

                            // 获取上传文件名
                            String name = fileItem.getName();
                            // 获取后缀名（扩展名）
                            String extension = name.substring(name.lastIndexOf("."));
                            // 给文件重新命名防止重复
                            String newName = UUID.randomUUID() + extension;
                            // 将上传的文件保存到服务器
                            fileItem.write(new File(this.getServletContext().getRealPath("upload"), newName));
                            // 把服务器中的路径添加到数据库中
                            String fileUrl = "upload/" + newName;

                            Map<String, Object> map = new HashMap<>();
                            map.put("code", 0);
                            map.put("msg", "");
                            Map<String, Object> data = new HashMap<>();
                            data.put("src", fileUrl);
                            map.put("data", data);

                            String json = new Gson().toJson(map);
                            resp.getWriter().write(json);
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
