<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>List of Staff</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<div class="container">
    <h2>Staff List (Total: ${count})</h2>

    <table border="1" cellpadding="10" cellspacing="0">
        <thead>
        <tr>
            <th>#</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Position</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="st" items="${staff}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${st.fullName}</td>
                <td>${st.email}</td>
                <td>${st.isActive}</td>
                <td>${st.position}</td>
                <td>
                    <!-- Edit button -->
                    <a href="${pageContext.request.contextPath}/admin/update-staff?id=${st.id}"
                       title="Edit Doctor">
                        <i class="fas fa-edit"></i>
                    </a>

                    <!-- Delete button -->
                    <a href="${pageContext.request.contextPath}/admin/delete-staff?id=${st.id}"
                       onclick="return confirm('Are you sure you want to delete this staff?');"
                       title="Delete Staff">
                        <i class="fas fa-trash" style="color:red;"></i>
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="${pageContext.request.contextPath}/dashboard/pages/staff/registerStaff.jsp">Add New Staff</a>

</div>
</body>
</html>
