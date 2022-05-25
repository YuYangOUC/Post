package com.ouc.dao.impl;

import com.ouc.bean.Post;
import com.ouc.dao.PostDao;

import java.util.List;

public class PostDaoImpl extends BaseDao implements PostDao {

    @Override
    public List<Post> queryPosts() {
        String sql = "select * from Post";
        return queryMulti(Post.class, sql);
    }

    @Override
    public List<Post> queryPostsLikeTitle(String keyword) {
        String _keyword = "";
        for (int i = 0; i < keyword.length(); i++) {
            if (keyword.charAt(i) != '\'') {
                _keyword += keyword.charAt(i);
            }
        }

        String sql = "SELECT * FROM Post WHERE title LIKE '%" + _keyword + "%'";
        return queryMulti(Post.class, sql);
    }

    @Override
    public int addPost(Post post) {
        String sql = "insert into Post(uid, title, content, imgUrl, date, floorNum) values(?,?,?,?,?,?)";
        return update(sql, post.getUid(), post.getTitle(), post.getContent(), post.getImgUrl(), post.getDate(), post.getFloorNum());
    }

    @Override
    public int deletePost(Integer pid) {
        String sql = "delete from Post where pid = ?";
        return update(sql, pid);
    }

    @Override
    public Post queryPostByPid(Integer pid) {
        String sql = "SELECT * FROM Post WHERE pid=?";
        return querySingle(Post.class, sql, pid);
    }

    @Override
    public int updateFloorNum(Integer pid, Integer floorNum) {
        String sql = "UPDATE Post SET floorNum=? WHERE pid=?";
        return update(sql, floorNum, pid);
    }

    @Override
    public int updatePost(Integer pid, String title, String content, String imgUrl, String date) {
        String sql = "UPDATE Post SET title=?, content=?, imgUrl=?, date=? WHERE pid=?";
        return update(sql, title, content, imgUrl, date, pid);
    }

    @Override
    public List<Post> queryPostsByUid(Integer uid) {
        String sql = "SELECT * FROM Post WHERE uid=?";
        return queryMulti(Post.class, sql, uid);
    }
}
