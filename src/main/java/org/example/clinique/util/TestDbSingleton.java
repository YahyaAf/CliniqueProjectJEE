package org.example.clinique.util;

import org.example.clinique.config.DbConnection;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDbSingleton {
    public static void main(String[] args) {
        try {
            Connection conn = DbConnection.getInstance().getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("Singleton CNX SUCCESS");
            } else {
                System.out.println("Singleton CNX FAILED");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

