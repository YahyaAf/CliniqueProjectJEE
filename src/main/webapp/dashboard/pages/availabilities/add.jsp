<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.clinique.dto.UserResponseLoginDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Redirect if user not logged in
    UserResponseLoginDTO currentUser = (UserResponseLoginDTO) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/pages/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Availability</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dashboard/assets/css/style.css">
</head>
<body>
<h2>Add Availability</h2>

<!-- Display errors if any -->
<c:if test="${not empty errors}">
    <div style="color: red; border: 1px solid red; padding: 10px; margin-bottom: 15px;">
        <ul>
            <c:forEach var="err" items="${errors}">
                <li>${err}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="<%=request.getContextPath()%>/doctor/availabilities?action=add" method="post">

    <!-- Day of the week -->
    <div>
        <label>Day of the Week:</label>
        <select name="dayOfWeek" required>
            <option value="">-- Select --</option>
            <option value="MONDAY" <c:if test="${param.dayOfWeek == 'MONDAY'}">selected</c:if>>Monday</option>
            <option value="TUESDAY" <c:if test="${param.dayOfWeek == 'TUESDAY'}">selected</c:if>>Tuesday</option>
            <option value="WEDNESDAY" <c:if test="${param.dayOfWeek == 'WEDNESDAY'}">selected</c:if>>Wednesday</option>
            <option value="THURSDAY" <c:if test="${param.dayOfWeek == 'THURSDAY'}">selected</c:if>>Thursday</option>
            <option value="FRIDAY" <c:if test="${param.dayOfWeek == 'FRIDAY'}">selected</c:if>>Friday</option>
            <option value="SATURDAY" <c:if test="${param.dayOfWeek == 'SATURDAY'}">selected</c:if>>Saturday</option>
            <option value="SUNDAY" <c:if test="${param.dayOfWeek == 'SUNDAY'}">selected</c:if>>Sunday</option>
        </select>
    </div>

    <!-- Start Time -->
    <div>
        <label>Start Time:</label>
        <input type="time" name="startTime" required value="${param.startTime}">
    </div>

    <!-- End Time -->
    <div>
        <label>End Time:</label>
        <input type="time" name="endTime" required value="${param.endTime}">
    </div>

    <!-- Slot Duration -->
    <div>
        <label>Slot Duration (minutes):</label>
        <input type="number" name="slotDuration" min="5" required value="${param.slotDuration}">
    </div>

    <!-- Available -->
    <div>
        <label>Available:</label>
        <input type="checkbox" name="isAvailable" <c:if test="${param.isAvailable != 'false'}">checked</c:if>>
    </div>

    <!-- Doctor ID from session -->
    <input type="hidden" name="doctorId" value="<%= currentUser.getId() %>">

    <!-- Submit -->
    <button type="submit">Save</button>
</form>

<a href="<%=request.getContextPath()%>/doctor/availabilities">⬅ Back</a>
</body>
</html>
