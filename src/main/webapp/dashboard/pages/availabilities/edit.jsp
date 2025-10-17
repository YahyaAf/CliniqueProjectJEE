<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.clinique.dto.AvailabilityResponseDTO" %>
<%@ page import="org.example.clinique.dto.UserResponseLoginDTO" %>

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
    <title>Modifier disponibilité</title>
</head>
<body>
<h2>Modifier une disponibilité</h2>

<form action="<%=request.getContextPath()%>/doctor/availabilities?action=update" method="post">
    <input type="hidden" name="id" value="<%=availability.getId()%>">
    <input type="hidden" name="doctorId" value="<%= currentUser.getId() %>">

    <div>
        <label>Jour de la semaine :</label>
        <select name="dayOfWeek" required>
            <option value="MONDAY" <%= availability.getDayOfWeek().equals("MONDAY") ? "selected" : "" %>>Lundi</option>
            <option value="TUESDAY" <%= availability.getDayOfWeek().equals("TUESDAY") ? "selected" : "" %>>Mardi</option>
            <option value="WEDNESDAY" <%= availability.getDayOfWeek().equals("WEDNESDAY") ? "selected" : "" %>>Mercredi</option>
            <option value="THURSDAY" <%= availability.getDayOfWeek().equals("THURSDAY") ? "selected" : "" %>>Jeudi</option>
            <option value="FRIDAY" <%= availability.getDayOfWeek().equals("FRIDAY") ? "selected" : "" %>>Vendredi</option>
            <option value="SATURDAY" <%= availability.getDayOfWeek().equals("SATURDAY") ? "selected" : "" %>>Samedi</option>
            <option value="SUNDAY" <%= availability.getDayOfWeek().equals("SUNDAY") ? "selected" : "" %>>Dimanche</option>
        </select>
    </div>

    <div>
        <label>Heure de début :</label>
        <input type="time" name="startTime" value="<%=availability.getStartTime()%>" required>
    </div>

    <div>
        <label>Heure de fin :</label>
        <input type="time" name="endTime" value="<%=availability.getEndTime()%>" required>
    </div>

    <div>
        <label>Durée du créneau (minutes) :</label>
        <input type="number" name="slotDuration" min="5" value="<%=availability.getSlotDuration()%>" required>
    </div>

    <div>
        <label>Disponible :</label>
        <input type="checkbox" name="isAvailable" <%=availability.isAvailable() ? "checked" : ""%>>
    </div>

    <button type="submit">Mettre à jour</button>
</form>

<a href="<%=request.getContextPath()%>/doctor/availabilities">⬅ Retour</a>
</body>
</html>
