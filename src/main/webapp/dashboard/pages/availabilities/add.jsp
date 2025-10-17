<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.clinique.dto.UserResponseLoginDTO" %>
<%
    UserResponseLoginDTO currentUser = (UserResponseLoginDTO) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/pages/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une disponibilité</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/dashboard/assets/css/style.css">
</head>
<body>
<h2>Ajouter une disponibilité</h2>

<form action="<%=request.getContextPath()%>/doctor/availabilities?action=add" method="post">
    <div>
        <label>Jour de la semaine :</label>
        <select name="dayOfWeek" required>
            <option value="">-- Sélectionner --</option>
            <option value="MONDAY">Lundi</option>
            <option value="TUESDAY">Mardi</option>
            <option value="WEDNESDAY">Mercredi</option>
            <option value="THURSDAY">Jeudi</option>
            <option value="FRIDAY">Vendredi</option>
            <option value="SATURDAY">Samedi</option>
            <option value="SUNDAY">Dimanche</option>
        </select>
    </div>

    <div>
        <label>Heure de début :</label>
        <input type="time" name="startTime" required>
    </div>

    <div>
        <label>Heure de fin :</label>
        <input type="time" name="endTime" required>
    </div>

    <div>
        <label>Durée du créneau (minutes) :</label>
        <input type="number" name="slotDuration" min="5" required>
    </div>

    <div>
        <label>Disponible :</label>
        <input type="checkbox" name="isAvailable" checked>
    </div>

    <!-- Doctor ID from session -->
    <input type="hidden" name="doctorId" value="<%= currentUser.getId() %>">

    <button type="submit">Enregistrer</button>
</form>

<a href="<%=request.getContextPath()%>/admin/availabilities">⬅ Retour</a>
</body>
</html>
