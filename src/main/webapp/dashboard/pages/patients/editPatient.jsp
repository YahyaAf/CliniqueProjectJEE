<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h1>Modifier Patient</h1>

<c:if test="${not empty errors}">
    <div style="color: red;">
        <ul>
            <c:forEach var="error" items="${errors}">
                <li>${error}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/update-patient" method="post">
    <input type="hidden" name="id" value="${patient.id}" />

    <label>Nom complet:</label>
    <input type="text" name="fullName" value="${patient.fullName}" required />
    <br/>

    <label>Email:</label>
    <input type="email" name="email" value="${patient.email}" required />
    <br/>

    <label>Mot de passe:</label>
    <input type="password" name="password" placeholder="Laissez vide si inchangé" />
    <br/>

    <label>CIN:</label>
    <input type="text" name="cin" value="${patient.cin}" required />
    <br/>

    <label>Date de naissance:</label>
    <input type="date" name="dateOfBirth" value="${patient.dateOfBirth}" />
    <br/>

    <label>Genre:</label>
    <select name="gender" required>
        <option value="">-- Choisir un genre --</option>
        <option value="MALE" <c:if test="${patient.gender == 'MALE'}">selected</c:if>>Homme</option>
        <option value="FEMALE" <c:if test="${patient.gender == 'FEMALE'}">selected</c:if>>Femme</option>
        <option value="OTHER" <c:if test="${patient.gender == 'OTHER'}">selected</c:if>>Autre</option>
    </select>
    <br/>

    <label>Type de sang:</label>
    <select name="bloodType" required>
        <option value="">-- Choisir un type sanguin --</option>
        <c:forEach var="type" items="${['A_POSITIVE','A_NEGATIVE','B_POSITIVE','B_NEGATIVE','AB_POSITIVE','AB_NEGATIVE','O_POSITIVE','O_NEGATIVE']}">
            <option value="${type}" <c:if test="${patient.bloodType == type}">selected</c:if>>${type}</option>
        </c:forEach>
    </select>
    <br/>

    <label>Numéro d'assurance:</label>
    <input type="text" name="insuranceNumber" value="${patient.insuranceNumber}" />
    <br/><br/>

    <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
    <a href="${pageContext.request.contextPath}/admin/patients" class="btn btn-secondary">Annuler</a>
</form>
