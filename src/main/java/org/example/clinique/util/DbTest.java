package org.example.clinique.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbTest {
    private static final String URL = "jdbc:postgresql://localhost:5433/clinique_db";
    private static final String USER = "clinique_user";
    private static final String PASS = "secret123";

    public static void main(String[] args) {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Postgres driver not found");
            e.printStackTrace();
            return;
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("CNX SUCCESS");
            } else {
                System.err.println("CNX FAILED: connection is null/closed");
            }
        } catch (SQLException e) {
            System.err.println("CNX FAILED: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
