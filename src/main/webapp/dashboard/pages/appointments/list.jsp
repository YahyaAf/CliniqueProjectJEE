<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - Doctor</title>
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
                <p class="mt-2 text-gray-600">View and manage your patient appointments</p>
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

        <!-- Doctor Info Card -->
        <div class="mb-6 bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
            <div class="flex items-center">
                <i class="fas fa-user-md text-4xl text-blue-600 mr-4"></i>
                <div>
                    <p class="text-sm text-gray-600">Doctor</p>
                    <p class="text-lg font-semibold text-gray-900">Dr. ${doctor.fullName}</p>
                    <p class="text-sm text-gray-500">${doctor.email} | Matricule: ${doctor.matricule}</p>
                </div>
            </div>
        </div>

        <!-- Appointments Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="px-6 py-4 bg-gradient-to-r from-blue-600 to-blue-800">
                <h3 class="text-lg font-semibold text-white">
                    <i class="fas fa-calendar-check mr-2"></i>Appointments List
                </h3>
            </div>

            <c:choose>
                <c:when test="${empty appointments}">
                    <!-- No Appointments -->
                    <div class="p-12 text-center">
                        <i class="fas fa-calendar-times text-6xl text-gray-300 mb-4"></i>
                        <h3 class="text-xl font-semibold text-gray-700 mb-2">No Appointments Found</h3>
                        <p class="text-gray-500">You don't have any appointments yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Appointments Table -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    #
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Patient
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Date
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Time
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Status
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="appointment" items="${appointments}">
                                <tr class="hover:bg-gray-50 transition duration-150">
                                    <!-- Appointment Number -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-mono font-semibold text-gray-900">
                                            #${appointment.appointmentNumber}
                                        </div>
                                    </td>

                                    <!-- Patient -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <i class="fas fa-user text-gray-400 mr-2"></i>
                                            <div class="text-sm font-medium text-gray-900">
                                                    ${appointment.patientName}
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Date -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <i class="fas fa-calendar text-gray-400 mr-2"></i>
                                            <div class="text-sm text-gray-900">
                                                    ${appointment.appointmentDate}
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Time -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <i class="fas fa-clock text-gray-400 mr-2"></i>
                                            <div class="text-sm text-gray-900">
                                                    ${appointment.startTime} - ${appointment.endTime}
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Status -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                                ${appointment.status == 'PLANNED' ? 'bg-blue-100 text-blue-800' : ''}
                                                ${appointment.status == 'DONE' ? 'bg-green-100 text-green-800' : ''}
                                                ${appointment.status == 'CANCELED' ? 'bg-red-100 text-red-800' : ''}">
                                                <i class="fas fa-circle text-xs mr-2"></i>
                                                ${appointment.status}
                                            </span>
                                    </td>

                                    <!-- Actions -->
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div class="flex gap-2">
                                            <!-- View Button -->
                                            <button onclick="showDetails('${appointment.id}', '${appointment.appointmentNumber}', '${appointment.patientName}', '${appointment.appointmentDate}', '${appointment.startTime}', '${appointment.endTime}', '${appointment.status}')"
                                                    class="text-blue-600 hover:text-blue-900 font-semibold transition duration-150">
                                                <i class="fas fa-eye mr-1"></i>View
                                            </button>

                                            <!-- Mark as Done Button (only for PLANNED) -->
                                            <c:if test="${appointment.status == 'PLANNED'}">
                                                <button onclick="confirmMarkAsDone('${appointment.id}', '${appointment.appointmentNumber}')"
                                                        class="text-green-600 hover:text-green-900 font-semibold transition duration-150">
                                                    <i class="fas fa-check-circle mr-1"></i>Done
                                                </button>
                                            </c:if>

                                            <!-- Cancel Button (only for PLANNED) -->
                                            <c:if test="${appointment.status == 'PLANNED'}">
                                                <a href="${pageContext.request.contextPath}/dashboard/appointments/cancelForm?appointmentId=${appointment.id}"
                                                   class="text-red-600 hover:text-red-900 font-semibold transition duration-150">
                                                    <i class="fas fa-times-circle mr-1"></i>Cancel
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Total Count -->
                    <div class="px-6 py-4 bg-gray-50 border-t border-gray-200">
                        <p class="text-sm text-gray-600">
                            <i class="fas fa-info-circle mr-2"></i>
                            Total: <span class="font-semibold">${appointments.size()}</span> appointments
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
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

<!-- Modal Mark as Done -->
<div id="markAsDoneModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-lg bg-white">
        <div class="mt-3">
            <div class="flex items-center justify-center mb-4">
                <i class="fas fa-check-circle text-green-500 text-5xl"></i>
            </div>
            <h3 class="text-lg font-semibold text-gray-900 text-center mb-2">Mark Appointment as Done</h3>
            <p class="text-sm text-gray-600 text-center mb-4">
                Are you sure you want to mark appointment <span id="doneAppointmentNumber" class="font-semibold"></span> as completed?
            </p>

            <form id="markAsDoneForm" method="post" action="${pageContext.request.contextPath}/dashboard/appointments/markDone">
                <input type="hidden" id="doneAppointmentId" name="appointmentId">
                <div class="flex gap-3">
                    <button type="button" onclick="closeMarkAsDoneModal()"
                            class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-4 rounded-lg transition duration-200">
                        <i class="fas fa-times mr-2"></i>Cancel
                    </button>
                    <button type="submit"
                            class="flex-1 bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                        <i class="fas fa-check mr-2"></i>Confirm
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Details Modal
    function showDetails(id, appointmentNumber, patientName, appointmentDate, startTime, endTime, status) {
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

    // Mark as Done Modal
    function confirmMarkAsDone(appointmentId, appointmentNumber) {
        document.getElementById('doneAppointmentId').value = appointmentId;
        document.getElementById('doneAppointmentNumber').textContent = '#' + appointmentNumber;
        document.getElementById('markAsDoneModal').classList.remove('hidden');
    }

    function closeMarkAsDoneModal() {
        document.getElementById('markAsDoneModal').classList.add('hidden');
    }

    // Close modals when clicking outside
    document.getElementById('detailsModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeDetailsModal();
        }
    });

    document.getElementById('markAsDoneModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeMarkAsDoneModal();
        }
    });
</script>
</body>
</html>