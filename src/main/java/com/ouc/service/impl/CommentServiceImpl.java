package com.ouc.service.impl;

import com.ouc.bean.Comment;
import com.ouc.dao.CommentDao;
import com.ouc.dao.impl.CommentDaoImpl;
import com.ouc.service.CommentService;

import java.util.List;

public class CommentServiceImpl implements CommentService {

    private final CommentDao commentDao = new CommentDaoImpl();

    @Override
    public List<Comment> queryCommentsByFid(Integer fid) {
        return commentDao.queryCommentsByFid(fid);
    }

    @Override
    public int addComment(Comment comment) {
        return commentDao.addComment(comment);
    }

    @Override
    public int deleteComment(Integer cid) {
        return commentDao.deleteComment(cid);
    }

    @Override
    public Comment queryCommentByCid(Integer cid) {
        return commentDao.queryCommentByCid(cid);
    }

    @Override
    public List<Comment> queryComments() {
        return commentDao.queryComments();
    }

    @Override
    public int updateComment(Integer cid, String content, String date) {
        return commentDao.updateComment(cid, content, date);
    }
}
