package com.ouc.service;

import com.ouc.bean.Post;

import java.util.List;

public interface PostService {

    List<Post> queryPosts();

    List<Post> queryPostsLikeTitle(String keyword);

    int addPost(Post post);

    int deletePost(Integer pid);

    Post queryPostByPid(Integer pid);

    int updateFloorNum(Integer pid, Integer floorNum);

    int updatePost(Integer pid, String title, String content, String imgUrl, String date);

    List<Post> queryPostsByUid(Integer uid);
}
