package org.example.clinique.servlet.test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/test-jpa")
public class TestJpaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
            EntityManager em = emf.createEntityManager();

            resp.getWriter().println("JPA SUCCESS: connexion & persistence.xml OK");

            em.close();
            emf.close();
        } catch (Exception e) {
            resp.getWriter().println("JPA FAILED: " + e.getMessage());
            e.printStackTrace(resp.getWriter());
        }
    }
}
