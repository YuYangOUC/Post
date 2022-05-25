package com.ouc.utils;

import com.ouc.utils.JDBCUtils;
import org.junit.jupiter.api.Test;

import java.sql.Connection;

public class JDBCUtilsTest {
    @Test
    public void test1() {
        for (int i = 0; i < 100; i++) {
            Connection connection = JDBCUtils.getConnection();
            System.out.println(connection);
            JDBCUtils.close(connection);
        }
    }
}
