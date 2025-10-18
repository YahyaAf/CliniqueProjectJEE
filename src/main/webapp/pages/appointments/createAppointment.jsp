<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Appointment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .time-slot {
            cursor: pointer;
            padding: 10px;
            border: 2px solid #dee2e6;
            border-radius: 5px;
            margin: 5px;
            text-align: center;
            transition: all 0.3s;
            display: inline-block;
            width: 100%;
        }
        .time-slot:hover:not(.occupied) {
            background: #e9ecef;
            transform: scale(1.05);
        }
        .time-slot.available {
            border-color: #28a745;
            background: #d4edda;
        }
        .time-slot.occupied {
            border-color: #dc3545;
            background: #f8d7da;
            cursor: not-allowed;
            opacity: 0.6;
        }
        .time-slot.selected {
            background: #007bff !important;
            color: white !important;
            border-color: #0056b3 !important;
        }
        .btn-submit-container {
            position: sticky;
            bottom: 0;
            background: white;
            padding: 20px 0;
            z-index: 100;
        }
    </style>
</head>
<body>
<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">Book an Appointment</h3>
                </div>
                <div class="card-body">

                    <!-- Success Message -->
                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>

                    <!-- Error Message -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Patient Info -->
                    <div class="alert alert-info">
                        <strong>Patient:</strong> ${patient.fullName} |
                        <strong>Email:</strong> ${patient.email}
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/appointments/create" id="appointmentForm">

                        <!-- Step 1: Select Speciality -->
                        <div class="form-section">
                            <h5 class="mb-3">Step 1: Select Speciality</h5>
                            <div class="mb-3">
                                <label for="specialiteId" class="form-label">Speciality *</label>
                                <select class="form-select" id="specialiteId" name="specialiteId" required onchange="loadDoctors()">
                                    <option value="">-- Select a Speciality --</option>
                                    <c:forEach var="specialite" items="${specialites}">
                                        <option value="${specialite.id}"
                                            ${selectedSpecialiteId == specialite.id ? 'selected' : ''}>
                                                ${specialite.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Step 2: Select Doctor -->
                        <c:if test="${not empty doctors}">
                            <div class="form-section">
                                <h5 class="mb-3">Step 2: Select Doctor</h5>
                                <div class="mb-3">
                                    <label for="doctorId" class="form-label">Doctor *</label>
                                    <select class="form-select" id="doctorId" name="doctorId" required onchange="enableDateSelection()">
                                        <option value="">-- Select a Doctor --</option>
                                        <c:forEach var="doctor" items="${doctors}">
                                            <option value="${doctor.id}"
                                                ${selectedDoctorId == doctor.id ? 'selected' : ''}>
                                                Dr. ${doctor.fullName} - ${doctor.matricule}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </c:if>

                        <!-- Step 3: Select Date -->
                        <c:if test="${not empty doctors}">
                            <div class="form-section">
                                <h5 class="mb-3">Step 3: Select Date</h5>
                                <div class="mb-3">
                                    <label for="date" class="form-label">Appointment Date *</label>
                                    <input type="date"
                                           class="form-control"
                                           id="date"
                                           name="date"
                                           value="${selectedDate}"
                                           onchange="loadTimeSlots()">
                                </div>
                            </div>
                        </c:if>

                        <!-- Step 4: Select Time Slot -->
                        <c:if test="${not empty timeSlots}">
                            <div class="form-section">
                                <h5 class="mb-3">Step 4: Select Time Slot</h5>
                                <div class="row g-2">
                                    <c:forEach var="slot" items="${timeSlots}">
                                        <div class="col-md-3 col-sm-6">
                                            <div class="time-slot ${slot.available ? 'available' : 'occupied'}"
                                                 data-start="${slot.startTime}"
                                                 data-end="${slot.endTime}"
                                                ${slot.available ? 'onclick="selectTimeSlot(this)"' : ''}>
                                                <div>
                                                    <strong>${slot.startTime}</strong> - <strong>${slot.endTime}</strong>
                                                </div>
                                                <small>${slot.available ? 'Available' : 'Occupied'}</small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Hidden Fields for Selected Time -->
                            <input type="hidden" id="appointmentDate" name="appointmentDate" value="${selectedDate}">
                            <input type="hidden" id="startTime" name="startTime">
                            <input type="hidden" id="endTime" name="endTime">
                        </c:if>

                        <!-- Submit Button (Always visible) -->
                        <div class="btn-submit-container">
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg" id="submitBtn" disabled>
                                    <i class="bi bi-calendar-check"></i> Book Appointment
                                </button>
                                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                                    <i class="bi bi-x-circle"></i> Cancel
                                </a>
                            </div>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Load doctors when speciality is selected
    function loadDoctors() {
        const specialiteId = document.getElementById('specialiteId').value;
        if (specialiteId) {
            window.location.href = '${pageContext.request.contextPath}/appointments/create?specialiteId=' + specialiteId;
        }
    }

    // Enable date selection when doctor is selected
    function enableDateSelection() {
        const doctorId = document.getElementById('doctorId').value;
        const dateInput = document.getElementById('date');
        if (doctorId && dateInput) {
            dateInput.disabled = false;
            // Set min date to today
            const today = new Date().toISOString().split('T')[0];
            dateInput.min = today;
        }
    }

    // Load time slots when date is selected
    function loadTimeSlots() {
        const doctorId = document.getElementById('doctorId').value;
        const date = document.getElementById('date').value;
        const specialiteId = document.getElementById('specialiteId').value;

        if (doctorId && date) {
            window.location.href = '${pageContext.request.contextPath}/appointments/create?specialiteId=' + specialiteId + '&doctorId=' + doctorId + '&date=' + date;
        }
    }

    // Select time slot
    function selectTimeSlot(element) {
        // Remove previous selection
        document.querySelectorAll('.time-slot').forEach(slot => {
            slot.classList.remove('selected');
        });

        // Add selection to clicked slot
        element.classList.add('selected');

        // Set hidden fields
        const startTime = element.getAttribute('data-start');
        const endTime = element.getAttribute('data-end');

        document.getElementById('startTime').value = startTime;
        document.getElementById('endTime').value = endTime;

        // Enable submit button
        const submitBtn = document.getElementById('submitBtn');
        if (submitBtn) {
            submitBtn.disabled = false;
        }

        console.log('Selected slot:', startTime, '-', endTime);
    }

    // Initialize date input
    document.addEventListener('DOMContentLoaded', function() {
        const doctorSelect = document.getElementById('doctorId');
        const dateInput = document.getElementById('date');

        if (dateInput && doctorSelect) {
            const doctorId = doctorSelect.value;
            dateInput.disabled = !doctorId;

            // Set min date to today
            const today = new Date().toISOString().split('T')[0];
            dateInput.min = today;
        }

        console.log('Page loaded successfully');
    });
</script>
</body>
</html>