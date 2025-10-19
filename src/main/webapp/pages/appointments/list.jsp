<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - Clinique Digitale</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="/pages/components/styles.jsp" />
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 15px rgba(20, 184, 166, 0.3); }
            50% { box-shadow: 0 0 25px rgba(20, 184, 166, 0.5); }
        }

        @keyframes slide-up {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .float-animation {
            animation: float 4s ease-in-out infinite;
        }

        .glow-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
        }

        .slide-up {
            animation: slide-up 0.5s ease-out forwards;
        }

        .fade-in {
            animation: fade-in 0.6s ease-out forwards;
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-4px) scale(1.01);
        }

        .glass-effect {
            background: rgba(17, 24, 39, 0.6);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(75, 85, 99, 0.3);
        }

        .glass-light {
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(75, 85, 99, 0.2);
        }

        .mesh-gradient {
            background:
                    radial-gradient(at 27% 37%, hsla(200, 70%, 50%, 0.15) 0px, transparent 50%),
                    radial-gradient(at 97% 21%, hsla(180, 60%, 45%, 0.12) 0px, transparent 50%),
                    radial-gradient(at 52% 99%, hsla(220, 50%, 40%, 0.1) 0px, transparent 50%);
        }

        .modal-backdrop {
            backdrop-filter: blur(8px);
            background: rgba(0, 0, 0, 0.7);
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-black text-gray-100">

<!-- Animated Background -->
<div class="fixed inset-0 mesh-gradient opacity-30 pointer-events-none"></div>

<!-- Navbar -->
<jsp:include page="/pages/components/navbar.jsp" />

<!-- Main Container -->
<div class="relative min-h-screen pt-20 pb-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header Section - Compact -->
        <div class="mb-8 slide-up">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <div>
                    <div class="inline-block px-3 py-1 bg-teal-600/20 rounded-full border border-teal-500/30 mb-2">
                        <span class="text-teal-400 text-xs font-semibold">
                            <i class="fas fa-calendar-check mr-1.5"></i>Appointments Dashboard
                        </span>
                    </div>
                    <h1 class="text-3xl md:text-4xl font-bold mb-2">
                        My <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Appointments</span>
                    </h1>
                    <p class="text-gray-400 text-sm">Manage and track all your medical appointments</p>
                </div>

                <div class="flex flex-wrap gap-2">
                    <a href="${pageContext.request.contextPath}/appointments/calendar"
                       class="group px-4 py-2 bg-gradient-to-r from-emerald-600 to-emerald-700 rounded-lg font-medium text-sm hover:shadow-xl hover:shadow-emerald-600/40 transition-all duration-300 flex items-center space-x-2">
                        <i class="fas fa-calendar-alt text-sm"></i>
                        <span>Calendar</span>
                        <svg class="w-3 h-3 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                    </a>
                    <a href="${pageContext.request.contextPath}/appointments/create"
                       class="group px-4 py-2 bg-gradient-to-r from-teal-600 to-teal-700 rounded-lg font-medium text-sm hover:shadow-xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center space-x-2 glow-pulse">
                        <i class="fas fa-plus text-sm"></i>
                        <span>Book New</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Success Message - Compact -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="mb-6 glass-effect rounded-xl p-4 border-l-4 border-green-500 fade-in">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <div class="w-8 h-8 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                            <i class="fas fa-check-circle text-white text-sm"></i>
                        </div>
                    </div>
                    <div class="ml-3">
                        <p class="text-green-400 font-semibold text-sm">Success!</p>
                        <p class="text-gray-300 text-xs">${sessionScope.successMessage}</p>
                    </div>
                </div>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <!-- Error Message - Compact -->
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="mb-6 glass-effect rounded-xl p-4 border-l-4 border-red-500 fade-in">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <div class="w-8 h-8 bg-gradient-to-br from-red-500 to-red-600 rounded-lg flex items-center justify-center">
                            <i class="fas fa-exclamation-circle text-white text-sm"></i>
                        </div>
                    </div>
                    <div class="ml-3">
                        <p class="text-red-400 font-semibold text-sm">Error!</p>
                        <p class="text-gray-300 text-xs">${sessionScope.errorMessage}</p>
                    </div>
                </div>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="mb-6 glass-effect rounded-xl p-4 border-l-4 border-red-500 fade-in">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <div class="w-8 h-8 bg-gradient-to-br from-red-500 to-red-600 rounded-lg flex items-center justify-center">
                            <i class="fas fa-exclamation-circle text-white text-sm"></i>
                        </div>
                    </div>
                    <div class="ml-3">
                        <p class="text-red-400 font-semibold text-sm">Error!</p>
                        <p class="text-gray-300 text-xs">${errorMessage}</p>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Patient Info Card - Compact -->
        <div class="mb-6 glass-effect rounded-xl p-4 float-animation">
            <div class="flex items-center space-x-3">
                <div class="w-12 h-12 bg-gradient-to-br from-teal-600 to-teal-700 rounded-xl flex items-center justify-center text-xl glow-pulse">
                    <i class="fas fa-user-circle text-white"></i>
                </div>
                <div class="flex-1">
                    <p class="text-xs text-gray-400 mb-0.5">Patient Profile</p>
                    <p class="text-base font-bold text-white">${patient.fullName}</p>
                    <p class="text-xs text-teal-400">
                        <i class="fas fa-envelope mr-1.5"></i>${patient.email}
                    </p>
                </div>
                <div class="hidden md:flex items-center space-x-2 px-3 py-1.5 bg-teal-600/20 rounded-lg border border-teal-500/30">
                    <div class="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></div>
                    <span class="text-xs text-gray-300">Active</span>
                </div>
            </div>
        </div>

        <!-- Content -->
        <c:choose>
            <c:when test="${empty appointments}">
                <!-- No Appointments - Compact -->
                <div class="glass-effect rounded-2xl p-12 text-center card-hover">
                    <div class="max-w-md mx-auto">
                        <div class="w-24 h-24 bg-gradient-to-br from-teal-600/20 to-emerald-600/20 rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-calendar-times text-5xl text-teal-400"></i>
                        </div>
                        <h3 class="text-xl font-bold mb-2">No Appointments Yet</h3>
                        <p class="text-gray-400 text-sm mb-6 leading-relaxed">
                            Your appointment list is empty. Start your health journey by booking your first consultation with our expert doctors.
                        </p>
                        <a href="${pageContext.request.contextPath}/appointments/create"
                           class="inline-flex items-center space-x-2 px-6 py-3 bg-gradient-to-r from-teal-600 to-teal-700 rounded-xl text-sm font-semibold hover:shadow-xl hover:shadow-teal-600/40 transition-all duration-300">
                            <i class="fas fa-plus"></i>
                            <span>Book Your First Appointment</span>
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Summary Stats - Compact -->
                <div class="grid grid-cols-2 md:grid-cols-4 gap-3 mb-6">
                    <c:set var="totalCount" value="${appointments.size()}" />
                    <c:set var="plannedCount" value="0" />
                    <c:set var="doneCount" value="0" />
                    <c:set var="canceledCount" value="0" />

                    <c:forEach var="apt" items="${appointments}">
                        <c:if test="${apt.status == 'PLANNED'}"><c:set var="plannedCount" value="${plannedCount + 1}" /></c:if>
                        <c:if test="${apt.status == 'DONE'}"><c:set var="doneCount" value="${doneCount + 1}" /></c:if>
                        <c:if test="${apt.status == 'CANCELED'}"><c:set var="canceledCount" value="${canceledCount + 1}" /></c:if>
                    </c:forEach>

                    <div class="glass-effect rounded-xl p-4 text-center card-hover">
                        <div class="text-3xl font-bold bg-gradient-to-r from-gray-200 to-gray-400 bg-clip-text text-transparent mb-1">
                                ${totalCount}
                        </div>
                        <p class="text-xs text-gray-400 font-medium">Total</p>
                    </div>
                    <div class="glass-effect rounded-xl p-4 text-center card-hover border border-teal-500/30">
                        <div class="text-3xl font-bold text-teal-400 mb-1">${plannedCount}</div>
                        <p class="text-xs text-gray-400 font-medium">Planned</p>
                    </div>
                    <div class="glass-effect rounded-xl p-4 text-center card-hover border border-green-500/30">
                        <div class="text-3xl font-bold text-green-400 mb-1">${doneCount}</div>
                        <p class="text-xs text-gray-400 font-medium">Completed</p>
                    </div>
                    <div class="glass-effect rounded-xl p-4 text-center card-hover border border-red-500/30">
                        <div class="text-3xl font-bold text-red-400 mb-1">${canceledCount}</div>
                        <p class="text-xs text-gray-400 font-medium">Canceled</p>
                    </div>
                </div>

                <!-- Appointments Grid - Compact -->
                <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                    <c:forEach var="appointment" items="${appointments}" varStatus="status">
                        <div class="glass-effect rounded-xl overflow-hidden card-hover slide-up" style="animation-delay: ${status.index * 0.1}s;">

                            <!-- Status Badge - Compact -->
                            <div class="px-4 py-3
                                ${appointment.status == 'PLANNED' ? 'bg-gradient-to-r from-teal-600/80 to-teal-700/80' : ''}
                                ${appointment.status == 'DONE' ? 'bg-gradient-to-r from-green-600/80 to-green-700/80' : ''}
                                ${appointment.status == 'CANCELED' ? 'bg-gradient-to-r from-red-600/80 to-red-700/80' : ''}">
                                <div class="flex justify-between items-center">
                                    <span class="text-white font-bold text-xs flex items-center">
                                        <i class="fas fa-circle mr-1.5 text-[8px] animate-pulse"></i>
                                        ${appointment.status}
                                    </span>
                                    <span class="text-white/80 text-[10px] font-mono px-2 py-0.5 bg-white/10 rounded">
                                        #${appointment.appointmentNumber}
                                    </span>
                                </div>
                            </div>

                            <!-- Card Content - Compact -->
                            <div class="p-4 space-y-3">
                                <!-- Doctor Info - Compact -->
                                <div class="pb-3 border-b border-gray-700">
                                    <p class="text-[10px] text-gray-500 mb-1.5">Medical Professional</p>
                                    <div class="flex items-center space-x-2">
                                        <div class="w-8 h-8 bg-gradient-to-br from-teal-600 to-teal-700 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-user-md text-white text-xs"></i>
                                        </div>
                                        <div>
                                            <p class="font-bold text-white text-sm">Dr. ${appointment.doctorName}</p>
                                            <p class="text-[10px] text-gray-400">Specialist</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Date & Time - Compact -->
                                <div class="space-y-2">
                                    <div class="flex items-center space-x-2">
                                        <div class="w-8 h-8 bg-gray-800 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-calendar text-teal-400 text-xs"></i>
                                        </div>
                                        <div>
                                            <p class="text-[10px] text-gray-500">Date</p>
                                            <p class="text-xs font-semibold text-white">${appointment.appointmentDate}</p>
                                        </div>
                                    </div>

                                    <div class="flex items-center space-x-2">
                                        <div class="w-8 h-8 bg-gray-800 rounded-lg flex items-center justify-center">
                                            <i class="fas fa-clock text-emerald-400 text-xs"></i>
                                        </div>
                                        <div>
                                            <p class="text-[10px] text-gray-500">Time Slot</p>
                                            <p class="text-xs font-semibold text-white">${appointment.startTime} - ${appointment.endTime}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Actions - Compact -->
                                <div class="pt-3 flex gap-2">
                                    <c:if test="${appointment.status == 'PLANNED'}">
                                        <button onclick="confirmCancel('${appointment.id}', '${appointment.appointmentNumber}')"
                                                class="flex-1 px-3 py-2 bg-red-600/20 hover:bg-red-600 border border-red-500/50 text-red-400 hover:text-white text-xs font-semibold rounded-lg transition-all duration-300 flex items-center justify-center space-x-1.5">
                                            <i class="fas fa-times-circle text-xs"></i>
                                            <span>Cancel</span>
                                        </button>
                                    </c:if>

                                    <button onclick="showDetails('${appointment.id}', '${appointment.appointmentNumber}', '${appointment.doctorName}', '${appointment.patientName}', '${appointment.appointmentDate}', '${appointment.startTime}', '${appointment.endTime}', '${appointment.status}')"
                                            class="flex-1 px-3 py-2 bg-teal-600/20 hover:bg-teal-600 border border-teal-500/50 text-teal-400 hover:text-white text-xs font-semibold rounded-lg transition-all duration-300 flex items-center justify-center space-x-1.5">
                                        <i class="fas fa-eye text-xs"></i>
                                        <span>Details</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<!-- Cancel Modal - Compact -->
<div id="cancelModal" class="hidden fixed inset-0 z-50 overflow-y-auto modal-backdrop">
    <div class="flex items-center justify-center min-h-screen px-4">
        <div class="relative glass-effect rounded-2xl p-6 max-w-md w-full border-2 border-red-500/30 slide-up">
            <div class="text-center">
                <div class="w-16 h-16 bg-gradient-to-br from-red-600 to-red-700 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-exclamation-triangle text-white text-2xl"></i>
                </div>

                <h3 class="text-xl font-bold text-white mb-2">Cancel Appointment?</h3>
                <p class="text-gray-400 text-sm mb-1">
                    You're about to cancel appointment
                </p>
                <p class="text-lg font-bold text-teal-400 mb-3">
                    <span id="cancelAppointmentNumber"></span>
                </p>
                <p class="text-xs text-red-400 mb-6">
                    <i class="fas fa-info-circle mr-1.5"></i>This action cannot be undone
                </p>

                <form id="cancelForm" method="post" action="${pageContext.request.contextPath}/appointments/cancel">
                    <input type="hidden" id="cancelAppointmentId" name="appointmentId">
                    <div class="flex gap-2">
                        <button type="button" onclick="closeCancelModal()"
                                class="flex-1 px-4 py-2.5 bg-gray-700 hover:bg-gray-600 text-white text-sm font-semibold rounded-lg transition-all duration-300">
                            <i class="fas fa-times mr-1.5"></i>No, Keep It
                        </button>
                        <button type="submit"
                                class="flex-1 px-4 py-2.5 bg-gradient-to-r from-red-600 to-red-700 hover:shadow-xl hover:shadow-red-600/40 text-white text-sm font-semibold rounded-lg transition-all duration-300">
                            <i class="fas fa-check mr-1.5"></i>Yes, Cancel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Details Modal - Compact -->
<div id="detailsModal" class="hidden fixed inset-0 z-50 overflow-y-auto modal-backdrop">
    <div class="flex items-center justify-center min-h-screen px-4">
        <div class="relative glass-effect rounded-2xl p-6 max-w-md w-full border border-teal-500/30 slide-up">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-xl font-bold text-white">Appointment Details</h3>
                <button onclick="closeDetailsModal()" class="w-8 h-8 bg-gray-800 hover:bg-gray-700 rounded-lg flex items-center justify-center transition-colors">
                    <i class="fas fa-times text-gray-400 text-sm"></i>
                </button>
            </div>

            <div class="space-y-3 mb-6" id="appointmentDetails">
                <!-- Details will be inserted here -->
            </div>

            <button onclick="closeDetailsModal()" class="w-full px-5 py-2.5 bg-gradient-to-r from-teal-600 to-teal-700 hover:shadow-xl hover:shadow-teal-600/40 text-white text-sm font-semibold rounded-lg transition-all duration-300">
                <i class="fas fa-check mr-2"></i>Close
            </button>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/pages/components/footer.jsp" />

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
        let statusIcon = '';
        let statusBg = '';
        switch(status) {
            case 'PLANNED':
                statusColor = 'text-teal-400';
                statusIcon = 'fa-clock';
                statusBg = 'bg-teal-600/20 border-teal-500/30';
                break;
            case 'DONE':
                statusColor = 'text-green-400';
                statusIcon = 'fa-check-circle';
                statusBg = 'bg-green-600/20 border-green-500/30';
                break;
            case 'CANCELED':
                statusColor = 'text-red-400';
                statusIcon = 'fa-times-circle';
                statusBg = 'bg-red-600/20 border-red-500/30';
                break;
            default:
                statusColor = 'text-gray-400';
                statusIcon = 'fa-circle';
                statusBg = 'bg-gray-600/20 border-gray-500/30';
        }

        detailsDiv.innerHTML =
            '<div class="glass-light rounded-lg p-3 border border-gray-700">' +
            '<p class="text-[10px] text-gray-500 mb-1">Appointment Number</p>' +
            '<p class="text-base font-bold text-teal-400">#' + appointmentNumber + '</p>' +
            '</div>' +

            '<div class="glass-light rounded-lg p-3 border border-gray-700">' +
            '<p class="text-[10px] text-gray-500 mb-1.5">Doctor</p>' +
            '<div class="flex items-center space-x-2">' +
            '<div class="w-8 h-8 bg-gradient-to-br from-teal-600 to-teal-700 rounded-lg flex items-center justify-center">' +
            '<i class="fas fa-user-md text-white text-xs"></i>' +
            '</div>' +
            '<p class="font-bold text-white text-sm">Dr. ' + doctorName + '</p>' +
            '</div>' +
            '</div>' +

            '<div class="glass-light rounded-lg p-3 border border-gray-700">' +
            '<p class="text-[10px] text-gray-500 mb-1.5">Patient</p>' +
            '<div class="flex items-center space-x-2">' +
            '<div class="w-8 h-8 bg-gray-800 rounded-lg flex items-center justify-center">' +
            '<i class="fas fa-user text-gray-400 text-xs"></i>' +
            '</div>' +
            '<p class="font-semibold text-white text-sm">' + patientName + '</p>' +
            '</div>' +
            '</div>' +

            '<div class="grid grid-cols-2 gap-2">' +
            '<div class="glass-light rounded-lg p-3 border border-gray-700">' +
            '<p class="text-[10px] text-gray-500 mb-1">Date</p>' +
            '<p class="text-xs font-semibold text-white">' +
            '<i class="fas fa-calendar text-teal-400 mr-1.5"></i>' + appointmentDate +
            '</p>' +
            '</div>' +

            '<div class="glass-light rounded-lg p-3 border border-gray-700">' +
            '<p class="text-[10px] text-gray-500 mb-1">Time</p>' +
            '<p class="text-xs font-semibold text-white">' +
            '<i class="fas fa-clock text-emerald-400 mr-1.5"></i>' + startTime +
            '</p>' +
            '</div>' +
            '</div>' +

            '<div class="glass-light rounded-lg p-3 border border-gray-700 ' + statusBg + '">' +
            '<p class="text-[10px] text-gray-500 mb-1.5">Status</p>' +
            '<p class="text-base font-bold ' + statusColor + ' flex items-center">' +
            '<i class="fas ' + statusIcon + ' mr-2 text-sm"></i>' + status +
            '</p>' +
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

    // Close modals with Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeCancelModal();
            closeDetailsModal();
        }
    });
</script>

</body>
</html>