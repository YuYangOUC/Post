package com.ouc.service.impl;

import com.ouc.bean.Post;
import com.ouc.dao.PostDao;
import com.ouc.dao.impl.PostDaoImpl;
import com.ouc.service.PostService;

import java.util.List;

public class PostServiceImpl implements PostService {

    private final PostDao postDao = new PostDaoImpl();

    @Override
    public List<Post> queryPosts() {
        return postDao.queryPosts();
    }

    @Override
    public List<Post> queryPostsLikeTitle(String keyword) {
        return postDao.queryPostsLikeTitle(keyword);
    }

    @Override
    public int addPost(Post post) {
        return postDao.addPost(post);
    }

    @Override
    public int deletePost(Integer pid) {
        return postDao.deletePost(pid);
    }

    @Override
    public Post queryPostByPid(Integer pid) {
        return postDao.queryPostByPid(pid);
    }

    @Override
    public int updateFloorNum(Integer pid, Integer floorNum) {
        return postDao.updateFloorNum(pid, floorNum);
    }

    @Override
    public int updatePost(Integer pid, String title, String content, String imgUrl, String date) {
        return postDao.updatePost(pid, title, content, imgUrl, date);
    }

    @Override
    public List<Post> queryPostsByUid(Integer uid) {
        return postDao.queryPostsByUid(uid);
    }
}
