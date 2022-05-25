package com.ouc.dao;

import com.ouc.bean.Post;
import com.ouc.dao.impl.PostDaoImpl;
import org.junit.jupiter.api.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

class PostDaoTest {

    PostDao postDao = new PostDaoImpl();

    @Test
    void listPosts() {
        for (Post post : postDao.queryPosts()) {
            System.out.println(post);
        }
    }

    @Test
    void addPost() {
        if (postDao.addPost(new Post(20, "aaaa", "bbbb", "imgpath", new Date())) > 0) {
            System.out.println("添加成功");

        } else {
            System.out.println("添加失败");
        }
    }

    @Test
    void deletePost() {
        if (postDao.deletePost(4) > 0) {
            System.out.println("删除成功！");
        } else {
            System.out.println("删除失败！");
        }
    }

    @Test
    void CurrentTime() {
        // Date -> String
        System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        // String -> Date
        try {
            System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse("2000-01-01 00:00:05"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}