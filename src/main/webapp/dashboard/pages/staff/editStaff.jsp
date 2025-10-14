<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h1>Modifier Staff</h1>

<c:if test="${not empty errors}">
    <div style="color: red;">
        <ul>
            <c:forEach var="error" items="${errors}">
                <li>${error}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/update-staff" method="post">
    <input type="hidden" name="id" value="${staff.id}" />

    <label>Full Name:</label>
    <input type="text" name="fullName" value="${staff.fullName}" required />
    <br/>

    <label>Email:</label>
    <input type="email" name="email" value="${staff.email}" required />
    <br/>

    <label>Password:</label>
    <input type="password" name="password" placeholder="Leave blank if unchanged" />
    <br/>

    <label>Position:</label>
    <input type="text" name="position" value="${staff.position}" required />
    <br/>

    <br/><br/>

    <button type="submit" class="btn btn-primary">Modifier</button>
    <a href="${pageContext.request.contextPath}/admin/staff">annuler</a>

</form>
