<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Modifier le département</title>
</head>
<body>
<h2>Modifier le département</h2>

<form action="${pageContext.request.contextPath}/admin/departments" method="post">
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="id" value="${department.id}"/>

    <label>Nom :</label><br>
    <input type="text" name="name" value="${department.name}" required/><br><br>

    <label>Description :</label><br>
    <textarea name="description" rows="4" cols="40">${department.description}</textarea><br><br>

    <label>Actif :</label>
    <input type="checkbox" name="isActive" <c:if test="${department.isActive}">checked</c:if> /><br><br>

    <button type="submit">Mettre à jour</button>
    <a href="${pageContext.request.contextPath}/admin/departments">Annuler</a>
</form>
</body>
</html>
