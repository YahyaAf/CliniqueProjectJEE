<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <h2>Ajouter une spécialité</h2>

    <form action="${pageContext.request.contextPath}/admin/specialites" method="post">
        <input type="hidden" name="action" value="add">

        <div class="form-group">
            <label>Nom :</label>
            <input type="text" name="name" class="form-control" required />
        </div>

        <div class="form-group">
            <label>Description :</label>
            <textarea name="description" class="form-control"></textarea>
        </div>

        <div class="form-group">
            <label>Département :</label>
            <select name="departmentId" class="form-control" required>
                <option value="">-- Sélectionner un département --</option>
                <c:forEach var="dept" items="${departments}">
                    <option value="${dept.id}">${dept.name}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-success">💾 Enregistrer</button>
        <a href="${pageContext.request.contextPath}/admin/specialites" class="btn btn-secondary">↩️ Annuler</a>
    </form>
</div>
