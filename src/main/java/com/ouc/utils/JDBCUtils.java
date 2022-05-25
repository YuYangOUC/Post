package com.ouc.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 此类是通过Druid数据库连接池获取连接对象
 */

public class JDBCUtils {
    private static final DataSource ds;

    static {
        Properties properties = new Properties();
        InputStream inputStream = JDBCUtils.class.getClassLoader().getResourceAsStream("druid.properties");

        try {
            // 读取配置文件
            properties.load(inputStream);

            // 1.创建了一个指定参数的数据库连接池
            ds = DruidDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 功能：从数据库连接池中获取可用的连接对象
     *
     * @return 连接对象(Connection对象)
     */
    public static Connection getConnection() {
        // 2.从数据库连接池中获取可用的连接对象
        try {
            return ds.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 功能：释放资源
     *
     * @param connection 连接对象
     */
    public static void close(Connection connection) {
        // 3.关闭连接
        try {
            if (connection != null)
                connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
