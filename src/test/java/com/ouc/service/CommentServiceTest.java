package com.ouc.service;

import com.ouc.bean.Comment;
import com.ouc.service.impl.CommentServiceImpl;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CommentServiceTest {

    private final CommentService commentService = new CommentServiceImpl();

    @Test
    void addComment() {
        System.out.println(commentService.addComment(new Comment(26, 10, null, null, "测试2", new Date())));
    }

    @Test
    void deleteComment() {
        System.out.println(commentService.deleteComment(2));
    }

    @Test
    void queryCommentsByFid() {
        List<Comment> comments = commentService.queryCommentsByFid(10);
        for (Comment comment : comments) {
            System.out.println(comment);
        }
    }

    @Test
    void queryCommentByCid() {
        System.out.println(commentService.queryCommentByCid(5));
    }
}