package org.example.clinique.servlet.test;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "greetServlet", value = "/greet")
public class GreetServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        if(name == null || name.trim().isEmpty()){
            name="invité(e)";
        }
        response.getWriter().println("<h1>Bienvennue "+ name  +" </h1>");
    }
}
