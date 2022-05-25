package com.ouc.dao;

import com.ouc.bean.Comment;

import java.util.List;

public interface CommentDao {

    List<Comment> queryCommentsByFid(Integer fid);

    int addComment(Comment comment);

    int deleteComment(Integer cid);

    Comment queryCommentByCid(Integer cid);

    List<Comment> queryComments();

    int updateComment(Integer cid, String content, String date);
}
