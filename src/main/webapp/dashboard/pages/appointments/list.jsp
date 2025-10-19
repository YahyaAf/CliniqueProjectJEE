<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - Doctor - MediCare+</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#6366f1',
                        secondary: '#ec4899',
                    }
                }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
    </style>
</head>
<body class="gradient-bg min-h-screen">

<!-- Définir la page active pour la sidebar -->
<c:set var="currentPage" value="appointments" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">My Appointments</h1>
        <p class="text-white/70">View and manage your patient appointments</p>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="mb-6 bg-green-500/20 backdrop-blur-lg border border-green-500/30 rounded-xl p-4">
            <div class="flex items-center">
                <i class="fas fa-check-circle text-green-400 text-xl mr-3"></i>
                <p class="text-green-300">${sessionScope.successMessage}</p>
            </div>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="mb-6 bg-red-500/20 backdrop-blur-lg border border-red-500/30 rounded-xl p-4">
            <div class="flex items-center">
                <i class="fas fa-exclamation-circle text-red-400 text-xl mr-3"></i>
                <p class="text-red-300">${sessionScope.errorMessage}</p>
            </div>
        </div>
        <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="mb-6 bg-red-500/20 backdrop-blur-lg border border-red-500/30 rounded-xl p-4">
            <div class="flex items-center">
                <i class="fas fa-exclamation-circle text-red-400 text-xl mr-3"></i>
                <p class="text-red-300">${errorMessage}</p>
            </div>
        </div>
    </c:if>

    <!-- Doctor Info Card -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6">
        <div class="flex items-center gap-4">
            <div class="w-14 h-14 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center">
                <i class="fas fa-user-md text-white text-2xl"></i>
            </div>
            <div>
                <p class="text-white/60 text-sm">Logged in as Doctor</p>
                <p class="text-xl font-bold text-white">Dr. ${doctor.fullName}</p>
                <p class="text-white/70 text-sm">
                    <i class="fas fa-envelope mr-2"></i>${doctor.email}
                    <span class="mx-2">•</span>
                    <i class="fas fa-id-card mr-2"></i>Matricule: ${doctor.matricule}
                </p>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
        <c:set var="totalCount" value="${appointments.size()}" />
        <c:set var="plannedCount" value="0" />
        <c:set var="doneCount" value="0" />
        <c:set var="canceledCount" value="0" />

        <c:forEach var="apt" items="${appointments}">
            <c:if test="${apt.status == 'PLANNED'}"><c:set var="plannedCount" value="${plannedCount + 1}" /></c:if>
            <c:if test="${apt.status == 'DONE'}"><c:set var="doneCount" value="${doneCount + 1}" /></c:if>
            <c:if test="${apt.status == 'CANCELED'}"><c:set var="canceledCount" value="${canceledCount + 1}" /></c:if>
        </c:forEach>

        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-blue-500/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-calendar-check text-blue-400 text-xl"></i>
                </div>
                <div>
                    <p class="text-white/60 text-sm">Planned</p>
                    <p class="text-2xl font-bold text-blue-400">${plannedCount}</p>
                </div>
            </div>
        </div>

        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-green-500/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-check-circle text-green-400 text-xl"></i>
                </div>
                <div>
                    <p class="text-white/60 text-sm">Completed</p>
                    <p class="text-2xl font-bold text-green-400">${doneCount}</p>
                </div>
            </div>
        </div>

        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-red-500/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-times-circle text-red-400 text-xl"></i>
                </div>
                <div>
                    <p class="text-white/60 text-sm">Canceled</p>
                    <p class="text-2xl font-bold text-red-400">${canceledCount}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Appointments Table -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden">

        <!-- Table Header -->
        <div class="p-6 border-b border-white/10">
            <div class="flex items-center justify-between">
                <h2 class="text-xl font-bold text-white">Appointments List</h2>
                <div class="relative">
                    <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-white/40"></i>
                    <input type="text"
                           id="searchInput"
                           placeholder="Search appointments..."
                           class="pl-10 pr-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/50 focus:ring-2 focus:ring-blue-400 focus:border-blue-400 outline-none transition">
                </div>
            </div>
        </div>

        <!-- Table Content -->
        <c:if test="${empty appointments}">
            <div class="p-12 text-center">
                <div class="w-20 h-20 bg-slate-700/50 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-calendar-times text-slate-500 text-3xl"></i>
                </div>
                <p class="text-white/60 text-lg">No appointments found.</p>
            </div>
        </c:if>

        <c:if test="${not empty appointments}">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                    <tr class="bg-slate-700/30 border-b border-white/10">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-hashtag text-blue-400"></i>
                                Number
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-user text-blue-400"></i>
                                Patient
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-calendar text-blue-400"></i>
                                Date
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-clock text-blue-400"></i>
                                Time
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-info-circle text-blue-400"></i>
                                Status
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            Actions
                        </th>
                    </tr>
                    </thead>
                    <tbody id="appointmentsTableBody">
                    <c:forEach var="appointment" items="${appointments}">
                        <tr class="border-b border-white/5 hover:bg-white/5 transition-colors">
                            <td class="px-6 py-4">
                                <span class="font-mono font-semibold text-white">
                                    #${appointment.appointmentNumber}
                                </span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-gradient-to-br from-purple-500 to-pink-600 rounded-full flex items-center justify-center text-white font-semibold">
                                            ${appointment.patientName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <span class="text-white font-medium">${appointment.patientName}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-white/70">
                                    ${appointment.appointmentDate}
                            </td>
                            <td class="px-6 py-4 text-white/70">
                                    ${appointment.startTime} - ${appointment.endTime}
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${appointment.status == 'PLANNED'}">
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-blue-500/20 text-blue-300 border border-blue-500/30 text-sm font-medium">
                                            <i class="fas fa-clock"></i>
                                            Planned
                                        </span>
                                    </c:when>
                                    <c:when test="${appointment.status == 'DONE'}">
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-green-500/20 text-green-300 border border-green-500/30 text-sm font-medium">
                                            <i class="fas fa-check-circle"></i>
                                            Done
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-red-500/20 text-red-300 border border-red-500/30 text-sm font-medium">
                                            <i class="fas fa-times-circle"></i>
                                            Canceled
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2">
                                    <button onclick="showDetails('${appointment.id}', '${appointment.appointmentNumber}', '${appointment.patientName}', '${appointment.appointmentDate}', '${appointment.startTime}', '${appointment.endTime}', '${appointment.status}')"
                                            class="w-8 h-8 bg-blue-500/20 hover:bg-blue-500/30 text-blue-300 rounded-lg transition flex items-center justify-center"
                                            title="View Details">
                                        <i class="fas fa-eye text-sm"></i>
                                    </button>

                                    <c:if test="${appointment.status == 'PLANNED'}">
                                        <button onclick="confirmMarkAsDone('${appointment.id}', '${appointment.appointmentNumber}')"
                                                class="w-8 h-8 bg-green-500/20 hover:bg-green-500/30 text-green-300 rounded-lg transition flex items-center justify-center"
                                                title="Mark as Done">
                                            <i class="fas fa-check text-sm"></i>
                                        </button>

                                        <a href="${pageContext.request.contextPath}/dashboard/appointments/cancelForm?appointmentId=${appointment.id}"
                                           class="w-8 h-8 bg-red-500/20 hover:bg-red-500/30 text-red-300 rounded-lg transition flex items-center justify-center"
                                           title="Cancel">
                                            <i class="fas fa-times text-sm"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

    </div>
</main>

<!-- Details Modal -->
<div id="detailsModal" class="hidden fixed inset-0 bg-black/70 backdrop-blur-sm overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 w-96">
        <div class="bg-slate-800 border border-white/10 rounded-2xl shadow-2xl p-6">
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-xl font-bold text-white">Appointment Details</h3>
                <button onclick="closeDetailsModal()" class="w-8 h-8 bg-white/10 hover:bg-white/20 rounded-lg transition flex items-center justify-center">
                    <i class="fas fa-times text-white/60"></i>
                </button>
            </div>

            <div class="space-y-4" id="appointmentDetails"></div>

            <button onclick="closeDetailsModal()" class="w-full mt-6 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white rounded-lg font-semibold transition">
                <i class="fas fa-check mr-2"></i>Close
            </button>
        </div>
    </div>
</div>

<!-- Mark as Done Modal -->
<div id="markAsDoneModal" class="hidden fixed inset-0 bg-black/70 backdrop-blur-sm overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 w-96">
        <div class="bg-slate-800 border border-green-500/30 rounded-2xl shadow-2xl p-6">
            <div class="flex items-center justify-center mb-6">
                <div class="w-16 h-16 bg-green-500/20 rounded-full flex items-center justify-center">
                    <i class="fas fa-check-circle text-green-400 text-3xl"></i>
                </div>
            </div>
            <h3 class="text-xl font-bold text-white text-center mb-2">Mark as Done</h3>
            <p class="text-white/70 text-center mb-4">
                Confirm appointment <span id="doneAppointmentNumber" class="font-semibold text-green-400"></span> as completed?
            </p>

            <form id="markAsDoneForm" method="post" action="${pageContext.request.contextPath}/dashboard/appointments/markDone">
                <input type="hidden" id="doneAppointmentId" name="appointmentId">
                <div class="flex gap-3">
                    <button type="button" onclick="closeMarkAsDoneModal()"
                            class="flex-1 py-3 bg-white/10 hover:bg-white/20 text-white rounded-lg font-semibold transition">
                        <i class="fas fa-times mr-2"></i>Cancel
                    </button>
                    <button type="submit"
                            class="flex-1 py-3 bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 text-white rounded-lg font-semibold transition">
                        <i class="fas fa-check mr-2"></i>Confirm
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#appointmentsTableBody tr');

            tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                if (text.includes(searchValue)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }

    // Details Modal
    function showDetails(id, appointmentNumber, patientName, appointmentDate, startTime, endTime, status) {
        const modal = document.getElementById('detailsModal');
        const detailsDiv = document.getElementById('appointmentDetails');

        let statusColor = '';
        let statusIcon = '';
        let statusBg = '';
        switch(status) {
            case 'PLANNED':
                statusColor = 'text-blue-400';
                statusIcon = 'fa-clock';
                statusBg = 'bg-blue-500/20 border-blue-500/30';
                break;
            case 'DONE':
                statusColor = 'text-green-400';
                statusIcon = 'fa-check-circle';
                statusBg = 'bg-green-500/20 border-green-500/30';
                break;
            case 'CANCELED':
                statusColor = 'text-red-400';
                statusIcon = 'fa-times-circle';
                statusBg = 'bg-red-500/20 border-red-500/30';
                break;
        }

        detailsDiv.innerHTML =
            '<div class="bg-white/5 rounded-lg p-3 border border-white/10">' +
            '<p class="text-white/60 text-xs mb-1">Appointment Number</p>' +
            '<p class="font-semibold text-white">#' + appointmentNumber + '</p>' +
            '</div>' +
            '<div class="bg-white/5 rounded-lg p-3 border border-white/10">' +
            '<p class="text-white/60 text-xs mb-1">Patient</p>' +
            '<p class="font-semibold text-white"><i class="fas fa-user mr-2 text-purple-400"></i>' + patientName + '</p>' +
            '</div>' +
            '<div class="bg-white/5 rounded-lg p-3 border border-white/10">' +
            '<p class="text-white/60 text-xs mb-1">Date</p>' +
            '<p class="font-semibold text-white"><i class="fas fa-calendar mr-2 text-blue-400"></i>' + appointmentDate + '</p>' +
            '</div>' +
            '<div class="bg-white/5 rounded-lg p-3 border border-white/10">' +
            '<p class="text-white/60 text-xs mb-1">Time</p>' +
            '<p class="font-semibold text-white"><i class="fas fa-clock mr-2 text-emerald-400"></i>' + startTime + ' - ' + endTime + '</p>' +
            '</div>' +
            '<div class="bg-white/5 rounded-lg p-3 border border-white/10 ' + statusBg + '">' +
            '<p class="text-white/60 text-xs mb-1">Status</p>' +
            '<p class="font-semibold ' + statusColor + '"><i class="fas ' + statusIcon + ' mr-2"></i>' + status + '</p>' +
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
    document.getElementById('detailsModal')?.addEventListener('click', function(e) {
        if (e.target === this) closeDetailsModal();
    });

    document.getElementById('markAsDoneModal')?.addEventListener('click', function(e) {
        if (e.target === this) closeMarkAsDoneModal();
    });
</script>

</body>
</html>