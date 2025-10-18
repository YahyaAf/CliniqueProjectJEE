<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments Calendar</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header avec titre et bouton Book Now -->
        <div class="mb-8 flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-bold text-gray-900">Appointments Calendar</h1>
                <p class="mt-2 text-gray-600">View and manage your appointments</p>
            </div>
            <a href="${pageContext.request.contextPath}/appointments/create"
               class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                <i class="fas fa-plus mr-2"></i>Book Now
            </a>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg shadow-md" role="alert">
                <div class="flex items-center">
                    <i class="fas fa-check-circle mr-3 text-xl"></i>
                    <p>${sessionScope.successMessage}</p>
                </div>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg shadow-md" role="alert">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-3 text-xl"></i>
                    <p>${errorMessage}</p>
                </div>
            </div>
        </c:if>

        <!-- Calendar Card -->
        <div class="bg-white rounded-xl shadow-xl overflow-hidden">

            <!-- Calendar Header avec navigation -->
            <div class="bg-gradient-to-r from-blue-600 to-blue-800 px-6 py-4">
                <div class="flex justify-between items-center">
                    <!-- Previous Month Button -->
                    <a href="${pageContext.request.contextPath}/appointments/calendar?year=${previousYear}&month=${previousMonth}"
                       class="text-white hover:bg-blue-700 rounded-lg px-4 py-2 transition duration-200">
                        <i class="fas fa-chevron-left mr-2"></i>Previous
                    </a>

                    <!-- Current Month/Year Display -->
                    <h2 class="text-2xl font-bold text-white">
                        ${monthName} ${currentYear}
                    </h2>

                    <!-- Next Month Button -->
                    <a href="${pageContext.request.contextPath}/appointments/calendar?year=${nextYear}&month=${nextMonth}"
                       class="text-white hover:bg-blue-700 rounded-lg px-4 py-2 transition duration-200">
                        Next<i class="fas fa-chevron-right ml-2"></i>
                    </a>
                </div>
            </div>

            <!-- Days of Week Header -->
            <div class="grid grid-cols-7 bg-gray-100 border-b border-gray-200">
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Mon</div>
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Tue</div>
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Wed</div>
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Thu</div>
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Fri</div>
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Sat</div>
                <div class="py-3 text-center text-sm font-semibold text-gray-700">Sun</div>
            </div>

            <!-- Calendar Grid -->
            <div class="grid grid-cols-7 gap-px bg-gray-200">

                <!-- Empty cells pour les jours avant le 1er du mois -->
                <c:forEach begin="1" end="${firstDayOfWeek - 1}">
                    <div class="bg-gray-50 h-32 p-2"></div>
                </c:forEach>

                <!-- Jours du mois -->
                <c:forEach var="day" begin="1" end="${daysInMonth}">
                    <c:set var="currentDate" value="${yearMonth.atDay(day)}" />
                    <c:set var="isToday" value="${currentDate.equals(today)}" />

                    <!-- Cell du jour -->
                    <div class="bg-white h-32 p-2 relative overflow-hidden hover:bg-gray-50 transition duration-150
                                    ${isToday ? 'ring-2 ring-blue-500' : ''}">

                        <!-- Numéro du jour -->
                        <div class="flex justify-between items-start mb-1">
                                <span class="text-sm font-semibold ${isToday ? 'bg-blue-600 text-white rounded-full w-7 h-7 flex items-center justify-center' : 'text-gray-700'}">
                                        ${day}
                                </span>
                                ${isToday ? '<span class="text-xs text-blue-600 font-semibold">Today</span>' : ''}
                        </div>

                        <!-- Appointments pour ce jour -->
                        <div class="space-y-1 overflow-y-auto max-h-20">
                            <c:set var="dayHasAppointments" value="false"/>
                            <c:forEach var="appointment" items="${appointments}">
                                <c:if test="${appointment.appointmentDate.dayOfMonth == day}">
                                    <c:set var="dayHasAppointments" value="true"/>

                                    <!-- Appointment Badge -->
                                    <div class="text-xs p-1 rounded cursor-pointer transform hover:scale-105 transition duration-150
                                                    ${appointment.status == 'PLANNED' ? 'bg-blue-100 text-blue-800 border border-blue-300' : ''}
                                                    ${appointment.status == 'DONE' ? 'bg-green-100 text-green-800 border border-green-300' : ''}
                                                    ${appointment.status == 'CANCELED' ? 'bg-red-100 text-red-800 border border-red-300' : ''}"
                                         onclick="showAppointmentDetails('${appointment.id}', '${appointment.appointmentNumber}', '${appointment.doctorName}', '${appointment.patientName}', '${appointment.startTime}', '${appointment.endTime}', '${appointment.status}')">
                                        <div class="font-semibold truncate">
                                            <i class="fas fa-user-md mr-1"></i>Dr. ${appointment.doctorName}
                                        </div>
                                        <div class="truncate">
                                            <i class="fas fa-clock mr-1"></i>${appointment.startTime}
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>

                            <!-- Si pas d'appointments ce jour -->
                            <c:if test="${!dayHasAppointments}">
                                <div class="text-xs text-gray-400 italic text-center mt-6">
                                    No appointments
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>

                <!-- Empty cells pour compléter la dernière semaine -->
                <c:set var="totalCells" value="${firstDayOfWeek + daysInMonth - 1}" />
                <c:set var="remainingCells" value="${7 - (totalCells % 7)}" />
                <c:if test="${remainingCells < 7}">
                    <c:forEach begin="1" end="${remainingCells}">
                        <div class="bg-gray-50 h-32 p-2"></div>
                    </c:forEach>
                </c:if>
            </div>
        </div>

        <!-- Légende des statuts -->
        <div class="mt-6 bg-white rounded-lg shadow-md p-4">
            <h3 class="text-sm font-semibold text-gray-700 mb-3">Status Legend</h3>
            <div class="flex flex-wrap gap-4">
                <div class="flex items-center">
                    <div class="w-4 h-4 bg-blue-100 border border-blue-300 rounded mr-2"></div>
                    <span class="text-sm text-gray-600">Planned</span>
                </div>
                <div class="flex items-center">
                    <div class="w-4 h-4 bg-green-100 border border-green-300 rounded mr-2"></div>
                    <span class="text-sm text-gray-600">Done</span>
                </div>
                <div class="flex items-center">
                    <div class="w-4 h-4 bg-red-100 border border-red-300 rounded mr-2"></div>
                    <span class="text-sm text-gray-600">Canceled</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal pour les détails de l'appointment -->
<div id="appointmentModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-lg bg-white">
        <div class="mt-3">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-lg font-semibold text-gray-900">Appointment Details</h3>
                <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>

            <div class="space-y-3" id="appointmentDetails">
                <!-- Details will be inserted here by JavaScript -->
            </div>

            <!-- GHIR Close Button bla View Details -->
            <div class="mt-6">
                <button onclick="closeModal()" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                    <i class="fas fa-check mr-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    function showAppointmentDetails(id, appointmentNumber, doctorName, patientName, startTime, endTime, status) {
        const modal = document.getElementById('appointmentModal');
        const detailsDiv = document.getElementById('appointmentDetails');

        // Déterminer la couleur du status
        let statusColor = '';
        switch(status) {
            case 'PLANNED': statusColor = 'text-blue-600'; break;
            case 'DONE': statusColor = 'text-green-600'; break;
            case 'CANCELED': statusColor = 'text-red-600'; break;
            default: statusColor = 'text-gray-600';
        }

        // Utiliser string concatenation au lieu de template literals
        detailsDiv.innerHTML =
            '<div class="border-b pb-2">' +
            '<p class="text-sm text-gray-600">Appointment Number</p>' +
            '<p class="font-semibold">#' + appointmentNumber + '</p>' +
            '</div>' +
            '<div class="border-b pb-2">' +
            '<p class="text-sm text-gray-600">Doctor</p>' +
            '<p class="font-semibold"><i class="fas fa-user-md mr-2 text-blue-600"></i>Dr. ' + doctorName + '</p>' +
            '</div>' +
            '<div class="border-b pb-2">' +
            '<p class="text-sm text-gray-600">Patient</p>' +
            '<p class="font-semibold"><i class="fas fa-user mr-2 text-gray-600"></i>' + patientName + '</p>' +
            '</div>' +
            '<div class="border-b pb-2">' +
            '<p class="text-sm text-gray-600">Time</p>' +
            '<p class="font-semibold"><i class="fas fa-clock mr-2 text-gray-600"></i>' + startTime + ' - ' + endTime + '</p>' +
            '</div>' +
            '<div>' +
            '<p class="text-sm text-gray-600">Status</p>' +
            '<p class="font-semibold ' + statusColor + '"><i class="fas fa-circle mr-2 text-xs"></i>' + status + '</p>' +
            '</div>';

        modal.classList.remove('hidden');
    }

    function closeModal() {
        const modal = document.getElementById('appointmentModal');
        modal.classList.add('hidden');
    }

    // Close modal when clicking outside
    document.getElementById('appointmentModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });
</script>
</body>
</html>