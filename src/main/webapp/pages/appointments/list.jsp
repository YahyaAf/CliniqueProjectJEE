<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="mb-8 flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-bold text-gray-900">My Appointments</h1>
                <p class="mt-2 text-gray-600">Manage your scheduled appointments</p>
            </div>
            <div class="flex gap-3">
                <a href="${pageContext.request.contextPath}/appointments/calendar"
                   class="bg-purple-600 hover:bg-purple-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                    <i class="fas fa-calendar-alt mr-2"></i>Calendar View
                </a>
                <a href="${pageContext.request.contextPath}/appointments/create"
                   class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                    <i class="fas fa-plus mr-2"></i>Book New
                </a>
            </div>
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
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg shadow-md" role="alert">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-3 text-xl"></i>
                    <p>${sessionScope.errorMessage}</p>
                </div>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg shadow-md" role="alert">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-3 text-xl"></i>
                    <p>${errorMessage}</p>
                </div>
            </div>
        </c:if>

        <!-- Patient Info Card -->
        <div class="mb-6 bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
            <div class="flex items-center">
                <i class="fas fa-user-circle text-4xl text-blue-600 mr-4"></i>
                <div>
                    <p class="text-sm text-gray-600">Patient</p>
                    <p class="text-lg font-semibold text-gray-900">${patient.fullName}</p>
                    <p class="text-sm text-gray-500">${patient.email}</p>
                </div>
            </div>
        </div>

        <!-- Appointments List -->
        <c:choose>
            <c:when test="${empty appointments}">
                <!-- No Appointments -->
                <div class="bg-white rounded-lg shadow-md p-12 text-center">
                    <i class="fas fa-calendar-times text-6xl text-gray-300 mb-4"></i>
                    <h3 class="text-xl font-semibold text-gray-700 mb-2">No Appointments Found</h3>
                    <p class="text-gray-500 mb-6">You don't have any appointments yet. Book your first appointment now!</p>
                    <a href="${pageContext.request.contextPath}/appointments/create"
                       class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg transition duration-200">
                        <i class="fas fa-plus mr-2"></i>Book Appointment
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Appointments Grid -->
                <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                    <c:forEach var="appointment" items="${appointments}">
                        <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition duration-300">

                            <!-- Status Header -->
                            <div class="px-4 py-3
                                ${appointment.status == 'PLANNED' ? 'bg-blue-500' : ''}
                                ${appointment.status == 'DONE' ? 'bg-green-500' : ''}
                                ${appointment.status == 'CANCELED' ? 'bg-red-500' : ''}">
                                <div class="flex justify-between items-center">
                                    <span class="text-white font-semibold text-sm">
                                        <i class="fas fa-circle mr-2 text-xs"></i>${appointment.status}
                                    </span>
                                    <span class="text-white text-xs font-mono">#${appointment.appointmentNumber}</span>
                                </div>
                            </div>

                            <!-- Appointment Details -->
                            <div class="p-4">
                                <!-- Doctor Info -->
                                <div class="mb-3 pb-3 border-b border-gray-200">
                                    <p class="text-xs text-gray-500 mb-1">Doctor</p>
                                    <div class="flex items-center">
                                        <i class="fas fa-user-md text-blue-600 mr-2"></i>
                                        <p class="font-semibold text-gray-900">Dr. ${appointment.doctorName}</p>
                                    </div>
                                </div>

                                <!-- Date -->
                                <div class="mb-3">
                                    <p class="text-xs text-gray-500 mb-1">Date</p>
                                    <div class="flex items-center">
                                        <i class="fas fa-calendar text-gray-600 mr-2"></i>
                                        <p class="text-gray-900">${appointment.appointmentDate}</p>
                                    </div>
                                </div>

                                <!-- Time -->
                                <div class="mb-4">
                                    <p class="text-xs text-gray-500 mb-1">Time</p>
                                    <div class="flex items-center">
                                        <i class="fas fa-clock text-gray-600 mr-2"></i>
                                        <p class="text-gray-900">${appointment.startTime} - ${appointment.endTime}</p>
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="flex gap-2">
                                    <!-- Cancel Button - Only show if PLANNED -->
                                    <c:if test="${appointment.status == 'PLANNED'}">
                                        <button onclick="confirmCancel('${appointment.id}', '${appointment.appointmentNumber}')"
                                                class="flex-1 bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                                            <i class="fas fa-times-circle mr-1"></i>Cancel
                                        </button>
                                    </c:if>

                                    <!-- View Details Button -->
                                    <button onclick="showDetails('${appointment.id}', '${appointment.appointmentNumber}', '${appointment.doctorName}', '${appointment.patientName}', '${appointment.appointmentDate}', '${appointment.startTime}', '${appointment.endTime}', '${appointment.status}')"
                                            class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-4 rounded-lg transition duration-200">
                                        <i class="fas fa-eye mr-1"></i>Details
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Summary Stats -->
                <div class="mt-8 grid grid-cols-2 md:grid-cols-4 gap-4">
                    <c:set var="totalCount" value="${appointments.size()}" />
                    <c:set var="plannedCount" value="0" />
                    <c:set var="doneCount" value="0" />
                    <c:set var="canceledCount" value="0" />

                    <c:forEach var="apt" items="${appointments}">
                        <c:if test="${apt.status == 'PLANNED'}"><c:set var="plannedCount" value="${plannedCount + 1}" /></c:if>
                        <c:if test="${apt.status == 'DONE'}"><c:set var="doneCount" value="${doneCount + 1}" /></c:if>
                        <c:if test="${apt.status == 'CANCELED'}"><c:set var="canceledCount" value="${canceledCount + 1}" /></c:if>
                    </c:forEach>

                    <div class="bg-white rounded-lg shadow p-4 text-center">
                        <p class="text-2xl font-bold text-gray-900">${totalCount}</p>
                        <p class="text-sm text-gray-600">Total</p>
                    </div>
                    <div class="bg-blue-50 rounded-lg shadow p-4 text-center">
                        <p class="text-2xl font-bold text-blue-600">${plannedCount}</p>
                        <p class="text-sm text-gray-600">Planned</p>
                    </div>
                    <div class="bg-green-50 rounded-lg shadow p-4 text-center">
                        <p class="text-2xl font-bold text-green-600">${doneCount}</p>
                        <p class="text-sm text-gray-600">Done</p>
                    </div>
                    <div class="bg-red-50 rounded-lg shadow p-4 text-center">
                        <p class="text-2xl font-bold text-red-600">${canceledCount}</p>
                        <p class="text-sm text-gray-600">Canceled</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<!-- Modal de confirmation d'annulation -->
<div id="cancelModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-lg bg-white">
        <div class="mt-3">
            <div class="flex items-center justify-center mb-4">
                <i class="fas fa-exclamation-triangle text-red-500 text-5xl"></i>
            </div>
            <h3 class="text-lg font-semibold text-gray-900 text-center mb-2">Cancel Appointment</h3>
            <p class="text-sm text-gray-600 text-center mb-4">
                Are you sure you want to cancel appointment <span id="cancelAppointmentNumber" class="font-semibold"></span>?
            </p>
            <p class="text-xs text-red-600 text-center mb-4">This action cannot be undone.</p>

            <form id="cancelForm" method="post" action="${pageContext.request.contextPath}/appointments/cancel">
                <input type="hidden" id="cancelAppointmentId" name="appointmentId">
                <div class="flex gap-3">
                    <button type="button" onclick="closeCancelModal()"
                            class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-4 rounded-lg transition duration-200">
                        <i class="fas fa-times mr-2"></i>No, Keep It
                    </button>
                    <button type="submit"
                            class="flex-1 bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                        <i class="fas fa-check mr-2"></i>Yes, Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal des détails -->
<div id="detailsModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-lg bg-white">
        <div class="mt-3">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-lg font-semibold text-gray-900">Appointment Details</h3>
                <button onclick="closeDetailsModal()" class="text-gray-400 hover:text-gray-600">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>

            <div class="space-y-3" id="appointmentDetails">
                <!-- Details will be inserted here by JavaScript -->
            </div>

            <div class="mt-6">
                <button onclick="closeDetailsModal()" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                    <i class="fas fa-check mr-2"></i>Close
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Confirm Cancel Modal
    function confirmCancel(appointmentId, appointmentNumber) {
        document.getElementById('cancelAppointmentId').value = appointmentId;
        document.getElementById('cancelAppointmentNumber').textContent = '#' + appointmentNumber;
        document.getElementById('cancelModal').classList.remove('hidden');
    }

    function closeCancelModal() {
        document.getElementById('cancelModal').classList.add('hidden');
    }

    // Details Modal
    function showDetails(id, appointmentNumber, doctorName, patientName, appointmentDate, startTime, endTime, status) {
        const modal = document.getElementById('detailsModal');
        const detailsDiv = document.getElementById('appointmentDetails');

        let statusColor = '';
        switch(status) {
            case 'PLANNED': statusColor = 'text-blue-600'; break;
            case 'DONE': statusColor = 'text-green-600'; break;
            case 'CANCELED': statusColor = 'text-red-600'; break;
            default: statusColor = 'text-gray-600';
        }

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
            '<p class="text-sm text-gray-600">Date</p>' +
            '<p class="font-semibold"><i class="fas fa-calendar mr-2 text-gray-600"></i>' + appointmentDate + '</p>' +
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

    function closeDetailsModal() {
        document.getElementById('detailsModal').classList.add('hidden');
    }

    // Close modals when clicking outside
    document.getElementById('cancelModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeCancelModal();
        }
    });

    document.getElementById('detailsModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeDetailsModal();
        }
    });
</script>
</body>
</html>