package com.ouc.dao;

import com.ouc.dao.impl.UserDaoImpl;
import com.ouc.bean.User;
import org.junit.jupiter.api.Test;

public class UserDaoTest {

    private final UserDao userDao = new UserDaoImpl();

    @Test
    public void findUserByUNAndPW() {
        if (userDao.findUserByUNAndPW("00000", "00000") != null) {
            System.out.println("登录成功");
        } else {
            System.out.println("用户名或密码错误");
        }
    }

    @Test
    public void checkUserName() {
        if (userDao.checkUserName("00000") == null) {
            System.out.println("用户名可用");
        } else {
            System.out.println("用户名已存在");
        }
    }

    @Test
    public void saveUser() {
        if (userDao.saveUser(new User("ababab", "ababab", "abab@ab.com")) >= 0) {
            System.out.println("注册成功");
        } else {
            System.out.println("注册失败");
        }
    }

    @Test
    public void queryUserByUid() {
        System.out.println(userDao.queryUserByUid(20));
    }

}