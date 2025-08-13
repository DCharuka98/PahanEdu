package com.PahanaEdu.dao;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnectionFactory {

    // Throws SQLException so caller can handle or declare it
    public static Connection getConnection() throws SQLException {
        return DBConnection.getInstance().getConnection();
    }
}
