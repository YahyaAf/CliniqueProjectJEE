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
    <h2>Patients List (Total: ${count})</h2>

    <table border="1" cellpadding="10" cellspacing="0">
        <thead>
        <tr>
            <th>#</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Date of birth</th>
            <th>Gender</th>
            <th>Blood Type</th>
            <th>Insurance Number</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="pat" items="${patients}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${pat.fullName}</td>
                <td>${pat.email}</td>
                <td>${pat.isActive}</td>
                <td>${pat.dateOfBirth}</td>
                <td>${pat.gender}</td>
                <td>${pat.bloodType}</td>
                <td>${pat.insuranceNumber}</td>
                <td>
                    <!-- Edit button -->
                    <a href="${pageContext.request.contextPath}/admin/update-patient?id=${pat.id}"
                       title="Edit Patient">
                        <i class="fas fa-edit"></i>
                    </a>

                    <!-- Delete button -->
                    <a href="${pageContext.request.contextPath}/admin/delete-patient?id=${pat.id}"
                       onclick="return confirm('Are you sure you want to delete this patient?');"
                       title="Delete Patient">
                        <i class="fas fa-trash" style="color:red;"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
</body>
</html>
