package com.ouc.dao.impl;

import com.ouc.dao.UserDao;
import com.ouc.bean.User;

import java.util.List;

public class UserDaoImpl extends BaseDao implements UserDao {

    @Override
    public User findUserByUNAndPW(String username, String password) {
        String sql = "select * from User where username = ? and password = ?";
        return querySingle(User.class, sql, username, password);
    }

    @Override
    public User checkUserName(String username) {
        String sql = "select * from User where username = ?";
        return querySingle(User.class, sql, username);
    }

    @Override
    public int saveUser(User user) {
        String sql = "insert into User(username, password, email, avatar, gender, postNum) values(?,?,?,?,?,?)";
        return update(sql, user.getUsername(), user.getPassword(), user.getEmail(), user.getAvatar(), user.getGender(), user.getPostNum());
    }

    @Override
    public User queryUserByUid(Integer uid) {
        String sql = "SELECT * FROM User WHERE uid=?";
        return querySingle(User.class, sql, uid);
    }

    @Override
    public int updatePostNum(Integer uid, Integer postNum) {
        String sql = "UPDATE User SET postNum=? WHERE uid=?";
        return update(sql, postNum, uid);
    }

    @Override
    public List<User> queryUsers() {
        String sql = "SELECT * FROM User";
        return queryMulti(User.class, sql);
    }

    @Override
    public int deleteUserByUid(Integer uid) {
        String sql = "DELETE FROM User WHERE uid=?";
        return update(sql, uid);
    }

    @Override
    public int updateUserByUid(Integer uid, String username, String password, String email, String gender, String avatar) {
        String sql = "UPDATE User SET username=?, password=?, email=?, gender=?, avatar=? WHERE uid=?";
        return update(sql, username, password, email, gender, avatar, uid);
    }

    @Override
    public int updateProfile(Integer uid, String username, String email, String gender, String avatar) {
        String sql = "UPDATE User SET username=?, email=?, gender=?, avatar=? WHERE uid=?";
        return update(sql, username, email, gender, avatar, uid);
    }

    @Override
    public int updatePassword(Integer uid, String password) {
        String sql = "UPDATE User SET password=? WHERE uid=?";
        return update(sql, password, uid);
    }
}
