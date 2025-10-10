<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 09/10/2025
  Time: 22:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register Patient</title>
</head>
<body>
<h2>Register a new patient</h2>
<form action="${pageContext.request.contextPath}/register-patient" method="post">
    Full Name: <input type="text" name="fullName" required><br>
    Email: <input type="email" name="email" required><br>
    Password: <input type="password" name="password" required><br>
    CIN: <input type="text" name="cin" required><br>
    Date of Birth: <input type="date" name="dateOfBirth" required><br>
    Gender:
    <select name="gender" required>
        <option value="MALE">Male</option>
        <option value="FEMALE">Female</option>
    </select><br>
    Blood Type:
    <select name="bloodType">
        <option value="A_POSITIVE">A+</option>
        <option value="A_NEGATIVE">A-</option>
        <option value="B_POSITIVE">B+</option>
        <option value="B_NEGATIVE">B-</option>
        <option value="O_POSITIVE">O+</option>
        <option value="O_NEGATIVE">O-</option>
        <option value="AB_POSITIVE">AB+</option>
        <option value="AB_NEGATIVE">AB-</option>
    </select><br>
    Insurance Number: <input type="text" name="insuranceNumber"><br>

    <button type="submit">Register</button>
</form>

</body>
</html>
