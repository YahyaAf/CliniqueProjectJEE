<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>List of Doctors</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <h2>Doctors List (Total: ${count})</h2>

    <table border="1" cellpadding="10" cellspacing="0">
        <thead>
        <tr>
            <th>#</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Matricule</th>
            <th>Specialité</th>
            <th>Department</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="doc" items="${doctors}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${doc.fullName}</td>
                <td>${doc.email}</td>
                <td>${doc.isActive}</td>
                <td>${doc.matricule}</td>
                <td>${doc.specialiteName}</td>
                <td>${doc.departmentName}</td>
                <td>
                    <!-- Edit button -->
                    <a href="${pageContext.request.contextPath}/admin/update-doctor?id=${doc.id}"
                       title="Edit Doctor">
                        <i class="fas fa-edit"></i>
                    </a>

                    <!-- Delete button -->
                    <a href="${pageContext.request.contextPath}/admin/delete-doctor?id=${doc.id}"
                       onclick="return confirm('Are you sure you want to delete this doctor?');"
                       title="Delete Doctor">
                        <i class="fas fa-trash" style="color:red;"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/admin/register-doctor">Add New Doctor</a>

</div>
</body>
</html>
