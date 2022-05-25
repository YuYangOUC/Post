package com.ouc.service;

import com.ouc.bean.User;

import java.util.List;

public interface UserService {

    /**
     * 检查用户名是否存在
     * @param username 用户名
     * @return 返回true，表示用户名存在<br>返回false，表示用户名不存在
     */
    boolean isUsernameExist(String username);

    /**
     * 登录
     * @param username 用户名
     * @param password 用户密码
     * @return 如果用户名或者密码错误，返回null<br>反之，返回的是当前登录的user对象
     */
    User login(String username, String password);

    /**
     * 注册
     * @param user 用户对象
     * @return 返回-1，表示操作失败<br>返回其他，表示注册的用户数
     */
    int register(User user);

    List<User> queryUsers();

    User queryUserByUid(Integer uid);

    int deleteUserByUid(Integer uid);

    int updatePostNum(Integer uid, Integer postNum);

    int updateUserByUid(Integer uid, String username, String password, String email, String gender, String avatar);

    int updateProfile(Integer uid, String username, String email, String gender, String avatar);

    int updatePassword(Integer uid, String password);
}
