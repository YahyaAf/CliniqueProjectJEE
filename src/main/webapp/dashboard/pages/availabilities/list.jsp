<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="org.example.clinique.dto.AvailabilityResponseDTO" %>
<%@ page import="org.example.clinique.dto.UserResponseLoginDTO" %>

<%
    UserResponseLoginDTO currentUser = (UserResponseLoginDTO) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/pages/auth/login.jsp");
        return;
    }

    List<AvailabilityResponseDTO> availabilities = (List<AvailabilityResponseDTO>) request.getAttribute("availabilities");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mes disponibilités</title>
</head>
<body>
<h2>Liste des disponibilités</h2>

<a href="<%=request.getContextPath()%>/dashboard/pages/availabilities/add.jsp">➕ Ajouter une disponibilité</a>

<table border="1" cellpadding="6">
    <thead>
    <tr>
        <th>Jour</th>
        <th>Heure début</th>
        <th>Heure fin</th>
        <th>Durée (min)</th>
        <th>Disponible</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (availabilities == null || availabilities.isEmpty()) {
    %>
    <tr>
        <td colspan="6">Aucune disponibilité trouvée.</td>
    </tr>
    <%
    } else {
        for (AvailabilityResponseDTO a : availabilities) {
    %>
    <tr>
        <td><%=a.getDayOfWeek()%></td>
        <td><%=a.getStartTime()%></td>
        <td><%=a.getEndTime()%></td>
        <td><%=a.getSlotDuration()%></td>
        <td><%=a.isAvailable() ? "Oui" : "Non"%></td>
        <td>
            <a href="<%=request.getContextPath()%>/doctor/availabilities?action=edit&id=<%=a.getId()%>">Modifier</a> |
            <a href="<%=request.getContextPath()%>/doctor/availabilities?action=delete&id=<%=a.getId()%>"
               onclick="return confirm('Supprimer cette disponibilité ?')">Supprimer</a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

</body>
</html>
