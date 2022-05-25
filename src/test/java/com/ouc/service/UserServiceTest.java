package com.ouc.service;

import com.ouc.bean.User;
import com.ouc.service.UserService;
import com.ouc.service.impl.UserServiceImpl;
import org.junit.jupiter.api.Test;

public class UserServiceTest {

    private final UserService userService = new UserServiceImpl();

    @Test
    public void isUsernameExist() {
        if (userService.isUsernameExist("ouc")) {
            System.out.println("用户名已存在");
        } else {
            System.out.println("用户名可用");
        }
    }

    @Test
    public void register() {
        System.out.println(userService.register(new User("bbj168", "666", "bbj168@.com")));
    }

    @Test
    public void login() {
        if (userService.login("bbj168", "666") == null) {
            System.out.println("用户名或者密码错误，登录失败");
        } else {
            System.out.println("登录成功");
        }
    }

    @Test
    public void updatePostNum() {
        System.out.println(userService.updatePostNum(21, 0));
    }
}