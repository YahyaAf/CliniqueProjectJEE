package org.example.clinique.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.clinique.dto.SpecialiteRequestDTO;
import org.example.clinique.dto.SpecialiteResponseDTO;
import org.example.clinique.dto.DepartmentResponseDTO;
import org.example.clinique.repository.implementation.SpecialiteRepositoryImpl;
import org.example.clinique.repository.implementation.DepartmentRepositoryImpl;
import org.example.clinique.service.SpecialiteService;
import org.example.clinique.service.DepartmentService;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/admin/specialites")
public class SpecialiteServlet extends HttpServlet {

    private SpecialiteService specialiteService;
    private DepartmentService departmentService;

    @Override
    public void init() throws ServletException {
        this.specialiteService = new SpecialiteService(
                new SpecialiteRepositoryImpl(),
                new DepartmentRepositoryImpl()
        );
        this.departmentService = new DepartmentService(new DepartmentRepositoryImpl());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                List<DepartmentResponseDTO> departmentsAdd = departmentService.getAllDepartments();
                req.setAttribute("departments", departmentsAdd);
                req.getRequestDispatcher("/dashboard/pages/specialites/add.jsp").forward(req, resp);
                break;

            case "edit":
                String id = req.getParameter("id");
                Optional<SpecialiteResponseDTO> specialiteOpt = specialiteService.getSpecialiteById(UUID.fromString(id));

                if (specialiteOpt.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/admin/specialites");
                    return;
                }

                SpecialiteResponseDTO specialite = specialiteOpt.get();
                List<DepartmentResponseDTO> departmentsEdit = departmentService.getAllDepartments();

                req.setAttribute("specialite", specialite);
                req.setAttribute("departments", departmentsEdit);
                req.getRequestDispatcher("/dashboard/pages/specialites/edit.jsp").forward(req, resp);
                break;

            case "delete":
                handleDelete(req, resp);
                break;

            default:
                List<SpecialiteResponseDTO> specialites = specialiteService.getAllSpecialites();
                req.setAttribute("specialites", specialites);
                req.setAttribute("count", specialites.size());
                req.getRequestDispatcher("/dashboard/pages/specialites/list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            handleAdd(req, resp);
        } else if ("update".equals(action)) {
            handleUpdate(req, resp);
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        UUID departmentId = UUID.fromString(req.getParameter("departmentId"));

        SpecialiteRequestDTO dto = new SpecialiteRequestDTO();
        dto.setName(name);
        dto.setDescription(description);
        dto.setDepartmentId(departmentId);
        dto.setIsActive(true);

        specialiteService.createSpecialite(dto);
        resp.sendRedirect(req.getContextPath() + "/admin/specialites");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        UUID departmentId = UUID.fromString(req.getParameter("departmentId"));
        Boolean isActive = req.getParameter("isActive") != null;

        SpecialiteRequestDTO dto = new SpecialiteRequestDTO();
        dto.setName(name);
        dto.setDescription(description);
        dto.setDepartmentId(departmentId);
        dto.setIsActive(isActive);

        specialiteService.updateSpecialite(id, dto);
        resp.sendRedirect(req.getContextPath() + "/admin/specialites");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID id = UUID.fromString(req.getParameter("id"));
        specialiteService.deleteSpecialite(id);
        resp.sendRedirect(req.getContextPath() + "/admin/specialites");
    }
}
