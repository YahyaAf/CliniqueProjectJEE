<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments Calendar - Clinique Digitale</title>
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

        @keyframes scale-in {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
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

        .scale-in {
            animation: scale-in 0.3s ease-out forwards;
        }

        .card-hover {
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-2px);
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

        .calendar-day {
            min-height: 100px;
            transition: all 0.2s ease;
        }

        .calendar-day:hover {
            background: rgba(20, 184, 166, 0.05);
            transform: scale(1.01);
        }

        .appointment-badge {
            transition: all 0.2s ease;
        }

        .appointment-badge:hover {
            transform: translateX(3px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .day-today {
            position: relative;
        }

        .day-today::before {
            content: '';
            position: absolute;
            inset: 0;
            border: 2px solid #14b8a6;
            border-radius: 0.375rem;
            pointer-events: none;
        }

        .nav-button {
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            transform: translateX(-3px);
        }

        .nav-button.next:hover {
            transform: translateX(3px);
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
                            <i class="fas fa-calendar-alt mr-1.5"></i>Calendar View
                        </span>
                    </div>
                    <h1 class="text-3xl md:text-4xl font-bold mb-2">
                        Appointments <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Calendar</span>
                    </h1>
                    <p class="text-gray-400 text-sm">Visualize and manage your medical schedule</p>
                </div>

                <div class="flex gap-2">
                    <a href="${pageContext.request.contextPath}/appointments/create"
                       class="group px-4 py-2 bg-gradient-to-r from-teal-600 to-teal-700 rounded-lg font-medium text-sm hover:shadow-xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center space-x-2 glow-pulse">
                        <i class="fas fa-plus text-sm"></i>
                        <span>Book Now</span>
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

        <!-- Calendar Card - Compact -->
        <div class="glass-effect rounded-2xl overflow-hidden shadow-2xl">

            <!-- Calendar Header - Compact -->
            <div class="bg-gradient-to-r from-teal-600 via-teal-700 to-emerald-600 px-6 py-4">
                <div class="flex justify-between items-center">
                    <!-- Previous Month Button -->
                    <a href="${pageContext.request.contextPath}/appointments/calendar?year=${previousYear}&month=${previousMonth}"
                       class="nav-button group flex items-center space-x-2 text-white hover:bg-white/10 rounded-lg px-4 py-2 transition-all duration-300">
                        <i class="fas fa-chevron-left text-sm"></i>
                        <span class="hidden md:inline text-sm">Previous</span>
                    </a>

                    <!-- Current Month/Year Display -->
                    <div class="text-center float-animation">
                        <h2 class="text-2xl md:text-3xl font-bold text-white">
                            ${monthName}
                        </h2>
                        <p class="text-teal-100 text-xs font-medium">${currentYear}</p>
                    </div>

                    <!-- Next Month Button -->
                    <a href="${pageContext.request.contextPath}/appointments/calendar?year=${nextYear}&month=${nextMonth}"
                       class="nav-button next group flex items-center space-x-2 text-white hover:bg-white/10 rounded-lg px-4 py-2 transition-all duration-300">
                        <span class="hidden md:inline text-sm">Next</span>
                        <i class="fas fa-chevron-right text-sm"></i>
                    </a>
                </div>
            </div>

            <!-- Days of Week Header - Compact -->
            <div class="grid grid-cols-7 bg-gradient-to-r from-gray-800 to-gray-900 border-b border-gray-700">
                <div class="py-2.5 text-center text-xs font-bold text-teal-400">MON</div>
                <div class="py-2.5 text-center text-xs font-bold text-teal-400">TUE</div>
                <div class="py-2.5 text-center text-xs font-bold text-teal-400">WED</div>
                <div class="py-2.5 text-center text-xs font-bold text-teal-400">THU</div>
                <div class="py-2.5 text-center text-xs font-bold text-teal-400">FRI</div>
                <div class="py-2.5 text-center text-xs font-bold text-emerald-400">SAT</div>
                <div class="py-2.5 text-center text-xs font-bold text-emerald-400">SUN</div>
            </div>

            <!-- Calendar Grid - Compact -->
            <div class="grid grid-cols-7 gap-px bg-gray-800">

                <!-- Empty cells for days before the 1st of the month -->
                <c:forEach begin="1" end="${firstDayOfWeek - 1}">
                    <div class="glass-light calendar-day p-2"></div>
                </c:forEach>

                <!-- Days of the month -->
                <c:forEach var="day" begin="1" end="${daysInMonth}">
                    <c:set var="currentDate" value="${yearMonth.atDay(day)}" />
                    <c:set var="isToday" value="${currentDate.equals(today)}" />

                    <!-- Day Cell - Compact -->
                    <div class="glass-light calendar-day p-2 relative ${isToday ? 'day-today' : ''}">

                        <!-- Day Number - Compact -->
                        <div class="flex justify-between items-start mb-1.5">
                            <c:choose>
                                <c:when test="${isToday}">
                                    <div class="relative">
                                        <div class="w-7 h-7 bg-gradient-to-br from-teal-600 to-teal-700 rounded-lg flex items-center justify-center text-white text-sm font-bold shadow-lg glow-pulse">
                                                ${day}
                                        </div>
                                        <div class="absolute -top-0.5 -right-0.5 w-2 h-2 bg-green-500 rounded-full border border-gray-900"></div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-sm font-semibold text-gray-300">
                                            ${day}
                                    </span>
                                </c:otherwise>
                            </c:choose>

                                ${isToday ? '<span class="text-[10px] font-bold text-teal-400 px-1.5 py-0.5 bg-teal-600/20 rounded-full">Today</span>' : ''}
                        </div>

                        <!-- Appointments for this day - Compact -->
                        <div class="space-y-1 overflow-y-auto max-h-16">
                            <c:set var="dayHasAppointments" value="false"/>
                            <c:set var="appointmentCount" value="0"/>

                            <c:forEach var="appointment" items="${appointments}">
                                <c:if test="${appointment.appointmentDate.dayOfMonth == day}">
                                    <c:set var="dayHasAppointments" value="true"/>
                                    <c:set var="appointmentCount" value="${appointmentCount + 1}"/>

                                    <!-- Appointment Badge - Compact -->
                                    <c:if test="${appointmentCount <= 2}">
                                        <div class="appointment-badge text-[10px] px-1.5 py-1 rounded cursor-pointer
                                                    ${appointment.status == 'PLANNED' ? 'bg-teal-600/30 text-teal-300 border border-teal-500/50' : ''}
                                                    ${appointment.status == 'DONE' ? 'bg-green-600/30 text-green-300 border border-green-500/50' : ''}
                                                    ${appointment.status == 'CANCELED' ? 'bg-red-600/30 text-red-300 border border-red-500/50' : ''}"
                                             onclick="showAppointmentDetails('${appointment.id}', '${appointment.appointmentNumber}', '${appointment.doctorName}', '${appointment.patientName}', '${appointment.startTime}', '${appointment.endTime}', '${appointment.status}')">
                                            <div class="font-semibold truncate flex items-center">
                                                <i class="fas fa-user-md mr-1 text-[9px]"></i>
                                                <span class="truncate">Dr. ${appointment.doctorName}</span>
                                            </div>
                                            <div class="truncate flex items-center mt-0.5 opacity-90">
                                                <i class="fas fa-clock mr-1 text-[9px]"></i>
                                                    ${appointment.startTime}
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>

                            <!-- Show more indicator - Compact -->
                            <c:if test="${appointmentCount > 2}">
                                <div class="text-[10px] text-center text-teal-400 font-semibold py-0.5 px-1 bg-teal-600/10 rounded">
                                    +${appointmentCount - 2} more
                                </div>
                            </c:if>

                            <!-- If no appointments this day - Compact -->
                            <c:if test="${!dayHasAppointments}">
                                <div class="text-[10px] text-gray-600 italic text-center mt-3 opacity-50">
                                    <i class="fas fa-calendar-times mb-0.5 text-xs block"></i>
                                    Free
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>

                <!-- Empty cells to complete the last week -->
                <c:set var="totalCells" value="${firstDayOfWeek + daysInMonth - 1}" />
                <c:set var="remainingCells" value="${7 - (totalCells % 7)}" />
                <c:if test="${remainingCells < 7}">
                    <c:forEach begin="1" end="${remainingCells}">
                        <div class="glass-light calendar-day p-2"></div>
                    </c:forEach>
                </c:if>
            </div>
        </div>

        <!-- Legend - Compact -->
        <div class="mt-6 grid md:grid-cols-2 gap-4">
            <!-- Status Legend - Compact -->
            <div class="glass-effect rounded-xl p-4">
                <h3 class="text-sm font-bold text-white mb-3 flex items-center">
                    <i class="fas fa-info-circle text-teal-400 mr-2 text-xs"></i>
                    Status Legend
                </h3>
                <div class="grid grid-cols-3 gap-3">
                    <div class="text-center">
                        <div class="w-full h-2 bg-teal-600/30 border border-teal-500/50 rounded mb-1.5"></div>
                        <span class="text-xs text-gray-400">Planned</span>
                    </div>
                    <div class="text-center">
                        <div class="w-full h-2 bg-green-600/30 border border-green-500/50 rounded mb-1.5"></div>
                        <span class="text-xs text-gray-400">Done</span>
                    </div>
                    <div class="text-center">
                        <div class="w-full h-2 bg-red-600/30 border border-red-500/50 rounded mb-1.5"></div>
                        <span class="text-xs text-gray-400">Canceled</span>
                    </div>
                </div>
            </div>

            <!-- Quick Stats - Compact -->
            <div class="glass-effect rounded-xl p-4">
                <h3 class="text-sm font-bold text-white mb-3 flex items-center">
                    <i class="fas fa-chart-bar text-emerald-400 mr-2 text-xs"></i>
                    This Month
                </h3>
                <div class="grid grid-cols-3 gap-3">
                    <c:set var="monthPlanned" value="0" />
                    <c:set var="monthDone" value="0" />
                    <c:set var="monthCanceled" value="0" />
                    <c:forEach var="apt" items="${appointments}">
                        <c:if test="${apt.status == 'PLANNED'}"><c:set var="monthPlanned" value="${monthPlanned + 1}" /></c:if>
                        <c:if test="${apt.status == 'DONE'}"><c:set var="monthDone" value="${monthDone + 1}" /></c:if>
                        <c:if test="${apt.status == 'CANCELED'}"><c:set var="monthCanceled" value="${monthCanceled + 1}" /></c:if>
                    </c:forEach>

                    <div class="text-center">
                        <div class="text-xl font-bold text-teal-400 mb-0.5">${monthPlanned}</div>
                        <div class="text-[10px] text-gray-400">Planned</div>
                    </div>
                    <div class="text-center">
                        <div class="text-xl font-bold text-green-400 mb-0.5">${monthDone}</div>
                        <div class="text-[10px] text-gray-400">Done</div>
                    </div>
                    <div class="text-center">
                        <div class="text-xl font-bold text-red-400 mb-0.5">${monthCanceled}</div>
                        <div class="text-[10px] text-gray-400">Canceled</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Appointment Details - Compact -->
<div id="appointmentModal" class="hidden fixed inset-0 z-50 overflow-y-auto modal-backdrop">
    <div class="flex items-center justify-center min-h-screen px-4">
        <div class="relative glass-effect rounded-2xl p-6 max-w-md w-full border border-teal-500/30 scale-in">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-xl font-bold text-white">Appointment Details</h3>
                <button onclick="closeModal()" class="w-8 h-8 bg-gray-800 hover:bg-gray-700 rounded-lg flex items-center justify-center transition-colors">
                    <i class="fas fa-times text-gray-400 text-sm"></i>
                </button>
            </div>

            <div class="space-y-3 mb-6" id="appointmentDetails">
                <!-- Details will be inserted here -->
            </div>

            <button onclick="closeModal()" class="w-full px-5 py-2.5 bg-gradient-to-r from-teal-600 to-teal-700 hover:shadow-xl hover:shadow-teal-600/40 text-white text-sm font-semibold rounded-lg transition-all duration-300">
                <i class="fas fa-check mr-2"></i>Close
            </button>
        </div>
    </div>
</div>

<!-- Footer -->
<jsp:include page="/pages/components/footer.jsp" />

<script>
    function showAppointmentDetails(id, appointmentNumber, doctorName, patientName, startTime, endTime, status) {
        const modal = document.getElementById('appointmentModal');
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

            '<div class="glass-light rounded-lg p-3 border border-gray-700">' +
            '<p class="text-[10px] text-gray-500 mb-1.5">Time Slot</p>' +
            '<div class="flex items-center space-x-2 text-white text-sm font-semibold">' +
            '<i class="fas fa-clock text-emerald-400 text-xs"></i>' +
            '<span>' + startTime + ' - ' + endTime + '</span>' +
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

    function closeModal() {
        document.getElementById('appointmentModal').classList.add('hidden');
    }

    // Close modal when clicking outside
    document.getElementById('appointmentModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });

    // Close modal with Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeModal();
        }
    });
</script>

</body>
</html>