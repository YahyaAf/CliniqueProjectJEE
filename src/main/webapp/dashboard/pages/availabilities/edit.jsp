<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.clinique.dto.AvailabilityResponseDTO" %>
<%@ page import="org.example.clinique.dto.UserResponseLoginDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    UserResponseLoginDTO currentUser = (UserResponseLoginDTO) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/pages/auth/login.jsp");
        return;
    }

    AvailabilityResponseDTO availability = (AvailabilityResponseDTO) request.getAttribute("availability");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Availability</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dashboard/assets/css/style.css">
</head>
<body>
<h2>Edit Availability</h2>

<!-- Display validation errors -->
<c:if test="${not empty errors}">
    <div style="color: red; border: 1px solid red; padding: 10px; margin-bottom: 15px;">
        <ul>
            <c:forEach var="err" items="${errors}">
                <li>${err}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="<%=request.getContextPath()%>/doctor/availabilities?action=update" method="post">
    <input type="hidden" name="id" value="${availability.id}">
    <input type="hidden" name="doctorId" value="<%= currentUser.getId() %>">

    <!-- Day of the Week -->
    <div>
        <label>Day of the Week:</label>
        <select name="dayOfWeek" required>
            <option value="MONDAY" <c:if test="${availability.dayOfWeek == 'MONDAY'}">selected</c:if>>Monday</option>
            <option value="TUESDAY" <c:if test="${availability.dayOfWeek == 'TUESDAY'}">selected</c:if>>Tuesday</option>
            <option value="WEDNESDAY" <c:if test="${availability.dayOfWeek == 'WEDNESDAY'}">selected</c:if>>Wednesday</option>
            <option value="THURSDAY" <c:if test="${availability.dayOfWeek == 'THURSDAY'}">selected</c:if>>Thursday</option>
            <option value="FRIDAY" <c:if test="${availability.dayOfWeek == 'FRIDAY'}">selected</c:if>>Friday</option>
            <option value="SATURDAY" <c:if test="${availability.dayOfWeek == 'SATURDAY'}">selected</c:if>>Saturday</option>
            <option value="SUNDAY" <c:if test="${availability.dayOfWeek == 'SUNDAY'}">selected</c:if>>Sunday</option>
        </select>
    </div>

    <!-- Start Time -->
    <div>
        <label>Start Time:</label>
        <input type="time" name="startTime" value="${availability.startTime}" required>
    </div>

    <!-- End Time -->
    <div>
        <label>End Time:</label>
        <input type="time" name="endTime" value="${availability.endTime}" required>
    </div>

    <!-- Slot Duration -->
    <div>
        <label>Slot Duration (minutes):</label>
        <input type="number" name="slotDuration" min="5" value="${availability.slotDuration}" required>
    </div>

    <!-- Available -->
    <div>
        <label>Available:</label>
        <input type="checkbox" name="isAvailable" <c:if test="${availability.available}">checked</c:if>>
    </div>

    <button type="submit">Update</button>
</form>

<a href="<%=request.getContextPath()%>/doctor/availabilities">⬅ Back</a>
</body>
</html>
