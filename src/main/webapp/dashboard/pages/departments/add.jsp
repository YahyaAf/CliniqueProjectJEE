<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un département</title>
</head>
<body>
<h2>Ajouter un nouveau département</h2>

<form action="${pageContext.request.contextPath}/admin/departments" method="post">
    <input type="hidden" name="action" value="add"/>

    <label>Nom :</label><br>
    <input type="text" name="name" required/><br><br>

    <label>Description :</label><br>
    <textarea name="description" rows="4" cols="40"></textarea><br><br>

    <button type="submit">Enregistrer</button>
    <a href="${pageContext.request.contextPath}/admin/departments">Annuler</a>
</form>
</body>
</html>
