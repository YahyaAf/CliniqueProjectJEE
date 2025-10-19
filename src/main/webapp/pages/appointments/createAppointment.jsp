<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Clinique Digitale</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <jsp:include page="/pages/components/styles.jsp" />
    <style>
        @keyframes slide-up {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fade-in {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 15px rgba(20, 184, 166, 0.3); }
            50% { box-shadow: 0 0 25px rgba(20, 184, 166, 0.5); }
        }

        .slide-up {
            animation: slide-up 0.5s ease-out forwards;
        }

        .fade-in {
            animation: fade-in 0.6s ease-out forwards;
        }

        .glow-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
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

        .time-slot {
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .time-slot:hover:not(.occupied) {
            transform: translateY(-2px) scale(1.02);
        }

        .time-slot.selected {
            transform: translateY(-2px) scale(1.05);
        }

        .step-indicator {
            transition: all 0.3s ease;
        }

        .step-indicator.active {
            transform: scale(1.1);
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
    <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header - Compact -->
        <div class="mb-8 slide-up">
            <div class="text-center">
                <div class="inline-block px-3 py-1 bg-teal-600/20 rounded-full border border-teal-500/30 mb-3">
                    <span class="text-teal-400 text-xs font-semibold">
                        <i class="fas fa-calendar-plus mr-1.5"></i>New Appointment
                    </span>
                </div>
                <h1 class="text-3xl md:text-4xl font-bold mb-2">
                    Book Your <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Appointment</span>
                </h1>
                <p class="text-gray-400 text-sm">Follow the steps below to schedule your consultation</p>
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

        <!-- Patient Info Card - Compact -->
        <div class="mb-6 glass-effect rounded-xl p-4">
            <div class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-gradient-to-br from-teal-600 to-teal-700 rounded-lg flex items-center justify-center">
                    <i class="fas fa-user-circle text-white"></i>
                </div>
                <div>
                    <p class="text-xs text-gray-400">Patient Information</p>
                    <p class="text-sm font-bold text-white">${patient.fullName}</p>
                    <p class="text-xs text-teal-400"><i class="fas fa-envelope mr-1.5"></i>${patient.email}</p>
                </div>
            </div>
        </div>

        <!-- Form -->
        <form method="post" action="${pageContext.request.contextPath}/appointments/create" id="appointmentForm">

            <!-- Step 1: Select Speciality -->
            <div class="glass-effect rounded-xl p-6 mb-4 slide-up">
                <div class="flex items-center mb-4">
                    <div class="w-8 h-8 bg-gradient-to-br from-teal-600 to-teal-700 rounded-lg flex items-center justify-center text-white font-bold text-sm step-indicator active">
                        1
                    </div>
                    <h3 class="ml-3 text-lg font-bold text-white">Select Speciality</h3>
                </div>

                <div>
                    <label for="specialiteId" class="block text-sm font-medium text-gray-300 mb-2">
                        Choose a medical speciality *
                    </label>
                    <select class="w-full px-4 py-2.5 bg-gray-800 border border-gray-700 rounded-lg text-white text-sm focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                            id="specialiteId"
                            name="specialiteId"
                            required
                            onchange="loadDoctors()">
                        <option value="">-- Select a Speciality --</option>
                        <c:forEach var="specialite" items="${specialites}">
                            <option value="${specialite.id}" ${selectedSpecialiteId == specialite.id ? 'selected' : ''}>
                                    ${specialite.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- Step 2: Select Doctor -->
            <c:if test="${not empty doctors}">
                <div class="glass-effect rounded-xl p-6 mb-4 slide-up" style="animation-delay: 0.1s;">
                    <div class="flex items-center mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-emerald-600 to-emerald-700 rounded-lg flex items-center justify-center text-white font-bold text-sm step-indicator active">
                            2
                        </div>
                        <h3 class="ml-3 text-lg font-bold text-white">Select Doctor</h3>
                    </div>

                    <div>
                        <label for="doctorId" class="block text-sm font-medium text-gray-300 mb-2">
                            Choose your preferred doctor *
                        </label>
                        <select class="w-full px-4 py-2.5 bg-gray-800 border border-gray-700 rounded-lg text-white text-sm focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all"
                                id="doctorId"
                                name="doctorId"
                                required
                                onchange="enableDateSelection()">
                            <option value="">-- Select a Doctor --</option>
                            <c:forEach var="doctor" items="${doctors}">
                                <option value="${doctor.id}" ${selectedDoctorId == doctor.id ? 'selected' : ''}>
                                    Dr. ${doctor.fullName} - ${doctor.matricule}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </c:if>

            <!-- Step 3: Select Date -->
            <c:if test="${not empty doctors}">
                <div class="glass-effect rounded-xl p-6 mb-4 slide-up" style="animation-delay: 0.2s;">
                    <div class="flex items-center mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-teal-500 to-emerald-600 rounded-lg flex items-center justify-center text-white font-bold text-sm step-indicator active">
                            3
                        </div>
                        <h3 class="ml-3 text-lg font-bold text-white">Select Date</h3>
                    </div>

                    <div>
                        <label for="date" class="block text-sm font-medium text-gray-300 mb-2">
                            Choose appointment date *
                        </label>
                        <input type="date"
                               class="w-full px-4 py-2.5 bg-gray-800 border border-gray-700 rounded-lg text-white text-sm focus:ring-2 focus:ring-teal-500 focus:border-transparent transition-all"
                               id="date"
                               name="date"
                               value="${selectedDate}"
                               onchange="loadTimeSlots()">
                    </div>
                </div>
            </c:if>

            <!-- Step 4: Select Time Slot -->
            <c:if test="${not empty timeSlots}">
                <div class="glass-effect rounded-xl p-6 mb-4 slide-up" style="animation-delay: 0.3s;">
                    <div class="flex items-center mb-4">
                        <div class="w-8 h-8 bg-gradient-to-br from-purple-600 to-pink-600 rounded-lg flex items-center justify-center text-white font-bold text-sm step-indicator active glow-pulse">
                            4
                        </div>
                        <h3 class="ml-3 text-lg font-bold text-white">Select Time Slot</h3>
                    </div>

                    <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
                        <c:forEach var="slot" items="${timeSlots}">
                            <div class="time-slot ${slot.available ? 'bg-teal-600/20 border-teal-500/50 hover:bg-teal-600/30' : 'bg-red-600/20 border-red-500/50 opacity-50 cursor-not-allowed'} border-2 rounded-lg p-3 text-center ${slot.available ? 'cursor-pointer' : ''}"
                                 data-start="${slot.startTime}"
                                 data-end="${slot.endTime}"
                                ${slot.available ? 'onclick="selectTimeSlot(this)"' : ''}>
                                <div class="font-bold text-sm text-white mb-1">
                                        ${slot.startTime} - ${slot.endTime}
                                </div>
                                <div class="text-xs ${slot.available ? 'text-teal-400' : 'text-red-400'}">
                                    <i class="fas ${slot.available ? 'fa-check-circle' : 'fa-times-circle'} mr-1"></i>
                                        ${slot.available ? 'Available' : 'Occupied'}
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Legend -->
                    <div class="mt-4 flex flex-wrap gap-4 text-xs">
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-teal-600/20 border-2 border-teal-500/50 rounded mr-2"></div>
                            <span class="text-gray-400">Available</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-red-600/20 border-2 border-red-500/50 rounded mr-2"></div>
                            <span class="text-gray-400">Occupied</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-gradient-to-r from-teal-600 to-teal-700 border-2 border-teal-500 rounded mr-2"></div>
                            <span class="text-gray-400">Selected</span>
                        </div>
                    </div>
                </div>

                <!-- Hidden Fields -->
                <input type="hidden" id="appointmentDate" name="appointmentDate" value="${selectedDate}">
                <input type="hidden" id="startTime" name="startTime">
                <input type="hidden" id="endTime" name="endTime">
            </c:if>

            <!-- Submit Buttons - Sticky -->
            <div class="sticky bottom-0 bg-gradient-to-t from-gray-900 via-gray-900 to-transparent pt-6 pb-4 mt-6">
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/pages/appointments/list"
                       class="flex-1 px-6 py-3 bg-gray-800 hover:bg-gray-700 border border-gray-700 rounded-lg font-semibold text-sm transition-all duration-300 flex items-center justify-center space-x-2">
                        <i class="fas fa-arrow-left"></i>
                        <span>Back to Appointments</span>
                    </a>
                    <button type="submit"
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-teal-600 to-teal-700 rounded-lg font-semibold text-sm hover:shadow-xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center justify-center space-x-2 disabled:opacity-50 disabled:cursor-not-allowed"
                            id="submitBtn"
                            disabled>
                        <i class="fas fa-calendar-check"></i>
                        <span>Book Appointment</span>
                    </button>
                </div>
            </div>

        </form>

    </div>
</div>

<!-- Footer -->
<jsp:include page="/pages/components/footer.jsp" />

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
            slot.classList.remove('selected', 'bg-gradient-to-r', 'from-teal-600', 'to-teal-700', 'border-teal-500');
            slot.classList.add('bg-teal-600/20', 'border-teal-500/50');
        });

        // Add selection to clicked slot
        element.classList.remove('bg-teal-600/20', 'border-teal-500/50');
        element.classList.add('selected', 'bg-gradient-to-r', 'from-teal-600', 'to-teal-700', 'border-teal-500');

        // Set hidden fields
        const startTime = element.getAttribute('data-start');
        const endTime = element.getAttribute('data-end');

        document.getElementById('startTime').value = startTime;
        document.getElementById('endTime').value = endTime;

        // Enable submit button
        const submitBtn = document.getElementById('submitBtn');
        if (submitBtn) {
            submitBtn.disabled = false;
            submitBtn.classList.add('glow-pulse');
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