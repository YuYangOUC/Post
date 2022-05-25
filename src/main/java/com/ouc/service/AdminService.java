package com.ouc.service;

import com.ouc.bean.Admin;

public interface AdminService {

    Admin login(String username, String password);

    boolean isAdminExist(String username);
}
