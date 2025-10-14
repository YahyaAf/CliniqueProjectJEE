<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register Doctor</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="container">
    <h2>Register New Doctor</h2>

    <!-- Display validation errors -->
    <c:if test="${not empty errors}">
        <div class="errors">
            <ul>
                <c:forEach var="error" items="${errors}">
                    <li style="color:red;">${error}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/register-doctor" method="post">
        <!-- Full Name -->
        <div>
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required value="${param.fullName}">
        </div>

        <!-- Email -->
        <div>
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required value="${param.email}">
        </div>

        <!-- Password -->
        <div>
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>

        <!-- Matricule -->
        <div>
            <label for="matricule">Matricule</label>
            <input type="text" id="matricule" name="matricule" required value="${param.matricule}">
        </div>

        <!-- Specialite Select -->
        <div>
            <label for="specialite">Specialité</label>
            <select id="specialite" name="specialiteId" required>
                <option value="">-- Choose a Specialité --</option>
                <c:forEach var="s" items="${specialites}">
                    <option value="${s.id}" <c:if test="${param.specialiteId == s.id}">selected</c:if>>${s.name}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit">Register Doctor</button>
        <a href="${pageContext.request.contextPath}/admin/doctors">annuler</a>
    </form>
</div>
</body>
</html>
