package com.ouc.dao.impl;

import com.ouc.bean.Comment;
import com.ouc.dao.CommentDao;

import java.util.List;

public class CommentDaoImpl extends BaseDao implements CommentDao {

    @Override
    public List<Comment> queryCommentsByFid(Integer fid) {
        String sql = "SELECT * FROM Comment WHERE fid=?";
        return queryMulti(Comment.class, sql, fid);
    }

    @Override
    public int addComment(Comment comment) {
        String sql = "INSERT INTO Comment(uid, fid, replyUid, replyFloorth, content, date) VALUES(?,?,?,?,?,?)";
        return update(sql, comment.getUid(), comment.getFid(), comment.getReplyUid(), comment.getReplyFloorth(), comment.getContent(), comment.getDate());
    }

    @Override
    public int deleteComment(Integer cid) {
        String sql = "DELETE FROM Comment WHERE cid=?";
        return update(sql, cid);
    }

    @Override
    public Comment queryCommentByCid(Integer cid) {
        String sql = "SELECT * FROM Comment WHERE cid=?";
        return querySingle(Comment.class, sql, cid);
    }

    @Override
    public List<Comment> queryComments() {
        String sql = "SELECT * FROM Comment";
        return queryMulti(Comment.class, sql);
    }

    @Override
    public int updateComment(Integer cid, String content, String date) {
        String sql = "UPDATE Comment SET content=?, date=? WHERE cid=?";
        return update(sql, content, date, cid);
    }
}
