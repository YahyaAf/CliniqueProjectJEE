package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/test-db")
public class TestDbServlet extends HttpServlet {
    private static final String URL = "jdbc:postgresql://localhost:5433/clinique_db";
    private static final String USER = "clinique_user";
    private static final String PASS = "secret123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");

        try {
            // Load driver PostgreSQL
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            resp.getWriter().println("Driver not found");
            return;
        }

        try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {
            if (conn != null && !conn.isClosed()) {
                resp.getWriter().println("CNX SUCCESS: database reachable!");
            } else {
                resp.getWriter().println("CNX FAILED: null or closed connection");
            }
        } catch (SQLException e) {
            resp.getWriter().println("CNX FAILED: " + e.getMessage());
            e.printStackTrace(resp.getWriter());
        }
    }

    @WebServlet(name = "helloServlet", value = "/hello-servlet")
    public static class HelloServlet extends HttpServlet {
        private String message;

        public void init() {
            message = "Hello World!";
        }

        public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
            response.setContentType("text/html");

            // Hello
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h1>" + message + "</h1>");
            out.println("</body></html>");
        }

        public void destroy() {
        }
    }
}
