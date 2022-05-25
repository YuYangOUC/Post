package com.ouc.dao;

import com.ouc.bean.Admin;

public interface AdminDao {

    Admin findAdminByUNAndPW(String username, String password);

    Admin findAdminByUsername(String username);
}
