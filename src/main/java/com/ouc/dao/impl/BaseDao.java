package com.ouc.dao.impl;

import com.ouc.utils.JDBCUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public abstract class BaseDao {

    // 使用DBUtils操作数据库
    private final QueryRunner qr = new QueryRunner();

    /**
     * 功能：通用的增删改方法，适用于任何表
     *
     * @param sql 要执行的sql语句
     * @param params sql语句的参数
     * @return 如果返回-1，说明执行失败<br>返回其他，表示影响的行数
     */
    public int update(String sql, Object... params) {
        Connection connection = JDBCUtils.getConnection();
        try {
            return qr.update(connection, sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            JDBCUtils.close(connection);
        }
    }

    /**
     * 功能：查询并返回单个对象，适用于任何表
     *
     * @param type 返回的对象类型
     * @param sql 要执行的sqL语句
     * @param params sql语句的参数
     * @return 返回一个JavaBean对象<br>如果执行失败，返回null
     */
    public <T> T querySingle(Class<T> type, String sql, Object... params) {
        Connection connection = JDBCUtils.getConnection();
        try {
            return qr.query(connection, sql, new BeanHandler<>(type), params);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            JDBCUtils.close(connection);
        }
    }

    /**
     * 功能：查询并返回多个对象，适用于任何表
     *
     * @param type 返回的List中对象的类型
     * @param sql 要执行的sqL语句
     * @param params sql语句的参数
     * @return 返回一个JavaBean对象的List<br>如果执行失败，返回null
     */
    public <T> List<T> queryMulti(Class<T> type, String sql, Object... params) {
        Connection connection = JDBCUtils.getConnection();
        try {
            return qr.query(connection, sql, new BeanListHandler<>(type), params);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            JDBCUtils.close(connection);
        }
    }

    /**
     * 功能：查询单个值，适用于任何表
     *
     * @param sql 要执行的sqL语句
     * @param params sql语句的参数
     * @return 返回单个值<br>如果执行失败，返回null
     */
    public Object queryScalar(String sql, Object... params) {
        Connection connection = JDBCUtils.getConnection();
        try {
            return qr.query(connection, sql, new ScalarHandler(), params);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            JDBCUtils.close(connection);
        }
    }
}
