<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des départements</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<h2>Liste des Départements (Total : ${count})</h2>

<a href="${pageContext.request.contextPath}/admin/departments?action=add">+ Ajouter un département</a>

<table border="1" cellpadding="10" cellspacing="0">
    <thead>
    <tr>
        <th>Nom</th>
        <th>Description</th>
        <th>Statut</th>
        <th>Date de création</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${not empty departments}">
        <c:forEach var="d" items="${departments}">
            <tr>
                <td>${d.name}</td>
                <td>${d.description}</td>
                <td>
                    <c:choose>
                        <c:when test="${d.isActive}">Actif</c:when>
                        <c:otherwise>Inactif</c:otherwise>
                    </c:choose>
                </td>
                <td>${d.createdAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/departments?action=edit&id=${d.id}">Modifier</a> |
                    <a href="${pageContext.request.contextPath}/admin/departments?action=delete&id=${d.id}"
                       onclick="return confirm('Voulez-vous vraiment supprimer ce département ?');">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    <c:if test="${empty departments}">
        <tr><td colspan="5">Aucun département trouvé.</td></tr>
    </c:if>
    </tbody>
</table>
</body>
</html>
