package com.ouc.dao.impl;

import com.ouc.bean.Admin;
import com.ouc.dao.AdminDao;

public class AdminDaoImpl extends BaseDao implements AdminDao {

    @Override
    public Admin findAdminByUNAndPW(String username, String password) {
        String sql = "SELECT * FROM Admin WHERE username=? AND password=?";
        return querySingle(Admin.class, sql, username, password);
    }

    @Override
    public Admin findAdminByUsername(String username) {
        String sql = "SELECT * FROM Admin WHERE username=?";
        return querySingle(Admin.class, sql, username);
    }
}
