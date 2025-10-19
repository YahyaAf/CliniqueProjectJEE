package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.DepartmentRequestDTO;
import org.example.clinique.dto.DepartmentResponseDTO;
import org.example.clinique.dto.UserResponseLoginDTO;
import org.example.clinique.model.Department;
import org.example.clinique.repository.implementation.DepartmentRepositoryImpl;
import org.example.clinique.service.DepartmentService;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/admin/departments")
public class DepartmentServlet extends HttpServlet {
    private DepartmentService departmentService;

    public void init() throws ServletException {
        this.departmentService = new DepartmentService(new DepartmentRepositoryImpl());
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect("/clinique/pages/auth/login.jsp");
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Admins only.");
            resp.sendRedirect("/clinique/");
            return;
        }

        String action = req.getParameter("action");

        if (action == null) action = "list";
        switch (action){
            case "add":
                req.getRequestDispatcher("/dashboard/pages/departments/add.jsp").forward(req, resp);
                break;
            case "edit":
                String id = req.getParameter("id");
                Optional<DepartmentResponseDTO> departmentOpt = departmentService.getDepartmentById(UUID.fromString(id));
                DepartmentResponseDTO department = departmentOpt.get();
                req.setAttribute("department", department);
                req.getRequestDispatcher("/dashboard/pages/departments/edit.jsp").forward(req, resp);
                break;
            case "delete":
                handleDelete(req, resp);
                break;
            default:
                List<DepartmentResponseDTO> departments = departmentService.getAllDepartments();
                req.setAttribute("departments", departments);
                req.setAttribute("count", departments.size());
                req.getRequestDispatcher("/dashboard/pages/departments/list.jsp").forward(req, resp);
        }

    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserResponseLoginDTO currentUser = (UserResponseLoginDTO) req.getSession().getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect("/clinique/pages/auth/login.jsp");
            return;
        }

        if (!"ADMIN".equals(currentUser.getRole())) {
            req.getSession().setAttribute("errorMessage", "Access denied. Admins only.");
            resp.sendRedirect("/clinique/");
            return;
        }

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(req, resp);
        } else if ("update".equals(action)) {
            handleUpdate(req, resp);
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        DepartmentRequestDTO dto = new DepartmentRequestDTO();
        dto.setName(req.getParameter("name"));
        dto.setDescription(req.getParameter("description"));
        dto.setActive(true);

        departmentService.createDepartment(dto);
        resp.sendRedirect(req.getContextPath() + "/admin/departments");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        DepartmentRequestDTO dto = new DepartmentRequestDTO();
        dto.setName(req.getParameter("name"));
        dto.setDescription(req.getParameter("description"));
        dto.setActive(req.getParameter("isActive") != null);

        String id = req.getParameter("id");
        departmentService.updateDepartment(UUID.fromString(id), dto);
        resp.sendRedirect(req.getContextPath() + "/admin/departments");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        departmentService.deleteDepartment(UUID.fromString(id));
        resp.sendRedirect(req.getContextPath() + "/admin/departments");
    }

}
