package com.ouc.service;

import com.ouc.bean.Post;
import com.ouc.service.impl.PostServiceImpl;
import org.junit.jupiter.api.Test;

import java.util.Date;

class PostServiceTest {

    PostService postService = new PostServiceImpl();

    @Test
    void listPosts() {
        for (Post post : postService.queryPosts()) {
            System.out.println(post);
        }
    }

    @Test
    void addPost() {
        if (postService.addPost(new Post(20, "aaaa", "bbbb", "imgpath", new Date())) > 0) {
            System.out.println("添加成功");

        } else {
            System.out.println("添加失败");
        }
    }

    @Test
    void deletePost() {
        if (postService.deletePost(4) > 0) {
            System.out.println("删除成功！");
        } else {
            System.out.println("删除失败！");
        }
    }

    @Test
    void queryPostByPid() {
        System.out.println(postService.queryPostByPid(69));
    }

    @Test
    void updateFloorNum() {
        System.out.println(postService.updateFloorNum(87, 0));
    }
}