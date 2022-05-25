package com.ouc.dao;

import com.ouc.bean.User;

import java.util.List;

public interface UserDao {

    /**
     * 功能：根据用户名和密码搜索用户
     *
     * @param username 用户名
     * @param password 用户密码
     * @return 如果找到对应用户，返回用户信息<br/>反之，返回null
     */
    User findUserByUNAndPW(String username, String password);

    /**
     * 功能：检查用户名是否存在
     *
     * @param username 用户名
     * @return 如果用户名存在，返回用户信息<br>反之，返回null
     */
    User checkUserName(String username);

    /**
     * 功能：保存用户信息
     *
     * @param user 用户对象
     * @return 返回-1，表示操作失败<br>返回其他，表示User表中受影响的行数
     */
    int saveUser(User user);

    /**
     * 通过用户id查询用户
     * @param uid 用户id
     * @return 返回查找的用户
     */
    User queryUserByUid(Integer uid);

    /**
     * 更新用户的postNum属性
     * @param uid 用户id
     * @param postNum 新的postNum
     * @return 返回-1，表示操作失败<br>返回其他，表示User表中受影响的行数
     */
    int updatePostNum(Integer uid, Integer postNum);

    List<User> queryUsers();

    int deleteUserByUid(Integer uid);

    int updateUserByUid(Integer uid, String username, String password, String email, String gender, String avatar);

    int updateProfile(Integer uid, String username, String email, String gender, String avatar);

    int updatePassword(Integer uid, String password);
}
