<%@ page import="org.example.clinique.dto.UserResponseLoginDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Redirection si utilisateur non connecté
    UserResponseLoginDTO currentUser = (UserResponseLoginDTO) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/pages/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mes disponibilités</title>
</head>
<body>
<h2>Liste des disponibilités</h2>

<a href="${pageContext.request.contextPath}/dashboard/pages/availabilities/add.jsp">➕ Ajouter une disponibilité</a>

<table border="1" cellpadding="6">
    <thead>
    <tr>
        <th>Jour</th>
        <th>Heure début</th>
        <th>Heure fin</th>
        <th>Durée (min)</th>
        <th>Disponible</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <!-- Vérifier si la liste est vide -->
    <c:choose>
        <c:when test="${empty availabilities}">
            <tr>
                <td colspan="6">Aucune disponibilité trouvée.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <!-- Boucle sur les disponibilités -->
            <c:forEach var="a" items="${availabilities}">
                <tr>
                    <td>${a.dayOfWeek}</td>
                    <td>${a.startTime}</td>
                    <td>${a.endTime}</td>
                    <td>${a.slotDuration}</td>
                    <td><c:choose>
                        <c:when test="${a.available}">Oui</c:when>
                        <c:otherwise>Non</c:otherwise>
                    </c:choose>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/doctor/availabilities?action=edit&id=${a.id}">Modifier</a> |
                        <a href="${pageContext.request.contextPath}/doctor/availabilities?action=delete&id=${a.id}" onclick="return confirm('Supprimer cette disponibilité ?')">Supprimer</a>
                    </td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>
</body>
</html>
