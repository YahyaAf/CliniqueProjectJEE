<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <h2>Modifier la spécialité</h2>

    <form action="${pageContext.request.contextPath}/admin/specialites" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${specialite.id}">

        <div class="form-group">
            <label>Nom :</label>
            <input type="text" name="name" class="form-control" value="${specialite.name}" required />
        </div>

        <div class="form-group">
            <label>Description :</label>
            <textarea name="description" class="form-control">${specialite.description}</textarea>
        </div>

        <div class="form-group">
            <label>Département :</label>
            <select name="departmentId" class="form-control" required>
                <c:forEach var="dept" items="${departments}">
                    <option value="${dept.id}" <c:if test="${dept.name == specialite.departmentName}">selected</c:if>>
                            ${dept.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label>Active :</label>
            <input type="checkbox" name="isActive" <c:if test="${specialite.isActive}">checked</c:if> />
        </div>

        <button type="submit" class="btn btn-primary">💾 Mettre à jour</button>
        <a href="${pageContext.request.contextPath}/admin/specialites" class="btn btn-secondary">↩️ Retour</a>
    </form>
</div>
