<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h1>Modifier Doctor</h1>

<c:if test="${not empty errors}">
    <div style="color: red;">
        <ul>
            <c:forEach var="error" items="${errors}">
                <li>${error}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/update-doctor" method="post">
    <input type="hidden" name="id" value="${doctor.id}" />

    <label>Full Name:</label>
    <input type="text" name="fullName" value="${doctor.fullName}" required />
    <br/>

    <label>Email:</label>
    <input type="email" name="email" value="${doctor.email}" required />
    <br/>

    <label>Password:</label>
    <input type="password" name="password" placeholder="Leave blank if unchanged" />
    <br/>

    <label>Matricule:</label>
    <input type="text" name="matricule" value="${doctor.matricule}" required />
    <br/>

    <label>Spécialité:</label>
    <select name="specialiteId" required>
        <option value="">-- Choisir une spécialité --</option>
        <c:forEach var="spec" items="${specialites}">
            <option value="${spec.id}" <c:if test="${doctor.specialiteName == spec.name}">selected</c:if>>
                    ${spec.name} (${spec.departmentName})
            </option>
        </c:forEach>
    </select>
    <br/><br/>

    <button type="submit" class="btn btn-primary">Modifier</button>
    <a href="${pageContext.request.contextPath}/admin/doctors">annuler</a>

</form>
