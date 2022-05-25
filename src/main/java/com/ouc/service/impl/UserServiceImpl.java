package com.ouc.service.impl;

import com.ouc.dao.UserDao;
import com.ouc.dao.impl.UserDaoImpl;
import com.ouc.bean.User;
import com.ouc.service.UserService;

import java.util.List;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public boolean isUsernameExist(String username) {
        return userDao.checkUserName(username) != null;
    }

    @Override
    public User login(String username, String password) {
        return userDao.findUserByUNAndPW(username, password);
    }

    @Override
    public int register(User user) {
        return userDao.saveUser(user);
    }

    @Override
    public List<User> queryUsers() {
        return userDao.queryUsers();
    }

    @Override
    public User queryUserByUid(Integer uid) {
        return userDao.queryUserByUid(uid);
    }

    @Override
    public int deleteUserByUid(Integer uid) {
        return userDao.deleteUserByUid(uid);
    }

    @Override
    public int updatePostNum(Integer uid, Integer postNum) {
        return userDao.updatePostNum(uid, postNum);
    }

    @Override
    public int updateUserByUid(Integer uid, String username, String password, String email, String gender, String avatar) {
        return userDao.updateUserByUid(uid, username, password, email, gender, avatar);
    }

    @Override
    public int updateProfile(Integer uid, String username, String email, String gender, String avatar) {
        return userDao.updateProfile(uid, username, email, gender, avatar);
    }

    @Override
    public int updatePassword(Integer uid, String password) {
        return userDao.updatePassword(uid, password);
    }
}
