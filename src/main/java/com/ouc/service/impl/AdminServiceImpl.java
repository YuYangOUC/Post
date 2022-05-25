package com.ouc.service.impl;

import com.ouc.bean.Admin;
import com.ouc.dao.AdminDao;
import com.ouc.dao.impl.AdminDaoImpl;
import com.ouc.service.AdminService;

public class AdminServiceImpl implements AdminService {

    private final AdminDao adminDao = new AdminDaoImpl();

    @Override
    public Admin login(String username, String password) {
        return adminDao.findAdminByUNAndPW(username, password);
    }

    @Override
    public boolean isAdminExist(String username) {
        return adminDao.findAdminByUsername(username) != null;
    }
}
