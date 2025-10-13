<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <h2>Liste des Spécialités (${count})</h2>
    <a href="${pageContext.request.contextPath}/admin/specialites?action=add" class="btn btn-primary">➕ Ajouter une spécialité</a>

    <table border="1" cellpadding="10" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Nom</th>
            <th>Description</th>
            <th>Département</th>
            <th>Active</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="spec" items="${specialites}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${spec.name}</td>
                <td>${spec.description}</td>
                <td>${spec.departmentName}</td>
                <td>
                    <c:choose>
                        <c:when test="${spec.isActive}">✅</c:when>
                        <c:otherwise>❌</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/specialites?action=edit&id=${spec.id}" class="btn btn-warning">✏️ Modifier</a>
                    <a href="${pageContext.request.contextPath}/admin/specialites?action=delete&id=${spec.id}" class="btn btn-danger" onclick="return confirm('Supprimer cette spécialité ?');">🗑️ Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
