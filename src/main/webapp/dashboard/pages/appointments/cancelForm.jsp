<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Appointment - MediCare+</title>
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
        <a href="${pageContext.request.contextPath}/dashboard/appointments/list"
           class="inline-flex items-center gap-2 text-white/80 hover:text-white font-medium mb-4 transition">
            <i class="fas fa-arrow-left"></i>
            Back to Appointments
        </a>
        <h1 class="text-3xl font-bold text-white mb-2">Cancel Appointment</h1>
        <p class="text-white/70">Please provide a reason for cancelling this appointment</p>
    </div>

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

    <div class="max-w-4xl">
        <!-- Warning Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-red-500/30 rounded-2xl shadow-xl overflow-hidden mb-6">
            <div class="bg-gradient-to-r from-red-600 to-red-700 px-6 py-4">
                <div class="flex items-center gap-4">
                    <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                        <i class="fas fa-exclamation-triangle text-white text-xl"></i>
                    </div>
                    <div>
                        <h2 class="text-xl font-bold text-white">Warning: Appointment Cancellation</h2>
                        <p class="text-red-100 text-sm">This action cannot be undone</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Appointment Details Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6">
            <h3 class="text-lg font-bold text-white mb-4 flex items-center gap-2">
                <i class="fas fa-info-circle text-blue-400"></i>
                Appointment Details
            </h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <!-- Appointment Number -->
                <div class="bg-white/5 rounded-lg p-4 border border-white/10">
                    <p class="text-white/60 text-xs mb-1">Appointment Number</p>
                    <p class="font-bold text-white text-lg">#${appointment.appointmentNumber}</p>
                </div>

                <!-- Patient -->
                <div class="bg-white/5 rounded-lg p-4 border border-white/10">
                    <p class="text-white/60 text-xs mb-1">Patient</p>
                    <p class="font-semibold text-white flex items-center gap-2">
                        <i class="fas fa-user text-purple-400"></i>
                        ${appointment.patient.user.fullName}
                    </p>
                </div>

                <!-- Date -->
                <div class="bg-white/5 rounded-lg p-4 border border-white/10">
                    <p class="text-white/60 text-xs mb-1">Date</p>
                    <p class="font-semibold text-white flex items-center gap-2">
                        <i class="fas fa-calendar text-blue-400"></i>
                        ${appointment.appointmentDate}
                    </p>
                </div>

                <!-- Time -->
                <div class="bg-white/5 rounded-lg p-4 border border-white/10">
                    <p class="text-white/60 text-xs mb-1">Time</p>
                    <p class="font-semibold text-white flex items-center gap-2">
                        <i class="fas fa-clock text-emerald-400"></i>
                        ${appointment.startTime} - ${appointment.endTime}
                    </p>
                </div>

                <!-- Status -->
                <div class="bg-white/5 rounded-lg p-4 border border-white/10">
                    <p class="text-white/60 text-xs mb-1">Current Status</p>
                    <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-blue-500/20 text-blue-300 border border-blue-500/30 text-sm font-medium">
                        <i class="fas fa-clock"></i>
                        ${appointment.status}
                    </span>
                </div>
            </div>
        </div>

        <!-- Cancellation Form -->
        <form method="post" action="${pageContext.request.contextPath}/dashboard/appointments/cancelProcess"
              onsubmit="return confirmCancellation()">

            <input type="hidden" name="appointmentId" value="${appointment.id}">

            <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6">
                <h3 class="text-lg font-bold text-white mb-4 flex items-center gap-2">
                    <i class="fas fa-comment-dots text-red-400"></i>
                    Cancellation Reason
                </h3>

                <!-- Reason Textarea -->
                <div class="mb-6">
                    <label for="reason" class="block text-sm font-medium text-white/80 mb-2">
                        Please explain why you are cancelling this appointment <span class="text-red-400">*</span>
                    </label>
                    <textarea
                            id="reason"
                            name="reason"
                            rows="6"
                            required
                            maxlength="500"
                            placeholder="Enter the reason for cancellation (e.g., Emergency, Patient request, Schedule conflict, etc.)"
                            class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/50 focus:ring-2 focus:ring-red-500 focus:border-transparent resize-none outline-none transition"
                            oninput="updateCharCount()"></textarea>
                    <div class="flex justify-between items-center mt-2">
                        <p class="text-xs text-white/60">
                            <i class="fas fa-info-circle mr-1"></i>This reason will be visible to the patient
                        </p>
                        <p class="text-xs text-white/60">
                            <span id="charCount">0</span> / 500 characters
                        </p>
                    </div>
                </div>

                <!-- Quick Select Common Reasons -->
                <div class="mb-6">
                    <label class="block text-sm font-medium text-white/80 mb-3">Quick Select Common Reasons:</label>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                        <button type="button" onclick="selectReason('Emergency - Unable to attend')"
                                class="text-left px-4 py-3 bg-white/5 border border-white/10 rounded-lg hover:bg-white/10 transition flex items-center gap-3">
                            <i class="fas fa-ambulance text-red-400"></i>
                            <span class="text-white text-sm">Emergency</span>
                        </button>
                        <button type="button" onclick="selectReason('Patient requested cancellation')"
                                class="text-left px-4 py-3 bg-white/5 border border-white/10 rounded-lg hover:bg-white/10 transition flex items-center gap-3">
                            <i class="fas fa-user-times text-blue-400"></i>
                            <span class="text-white text-sm">Patient Request</span>
                        </button>
                        <button type="button" onclick="selectReason('Schedule conflict with another appointment')"
                                class="text-left px-4 py-3 bg-white/5 border border-white/10 rounded-lg hover:bg-white/10 transition flex items-center gap-3">
                            <i class="fas fa-calendar-times text-orange-400"></i>
                            <span class="text-white text-sm">Schedule Conflict</span>
                        </button>
                        <button type="button" onclick="selectReason('Doctor unavailable due to unforeseen circumstances')"
                                class="text-left px-4 py-3 bg-white/5 border border-white/10 rounded-lg hover:bg-white/10 transition flex items-center gap-3">
                            <i class="fas fa-user-md text-purple-400"></i>
                            <span class="text-white text-sm">Doctor Unavailable</span>
                        </button>
                    </div>
                </div>

                <!-- Warning Box -->
                <div class="bg-yellow-500/10 border border-yellow-500/30 rounded-lg p-4 mb-6">
                    <div class="flex gap-3">
                        <i class="fas fa-exclamation-triangle text-yellow-400 text-lg mt-1"></i>
                        <div>
                            <p class="text-sm font-semibold text-yellow-300 mb-2">Important Notice:</p>
                            <ul class="text-sm text-yellow-200/90 space-y-1">
                                <li class="flex items-start gap-2">
                                    <i class="fas fa-check text-xs mt-1"></i>
                                    <span>The patient will be notified immediately about this cancellation</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <i class="fas fa-check text-xs mt-1"></i>
                                    <span>The time slot will become available for other patients</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <i class="fas fa-check text-xs mt-1"></i>
                                    <span>This action cannot be reversed</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-3">
                    <button type="submit"
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-red-600 to-red-700 hover:from-red-700 hover:to-red-800 text-white rounded-lg font-semibold transition shadow-lg shadow-red-600/30 flex items-center justify-center gap-2">
                        <i class="fas fa-times-circle"></i>
                        Confirm Cancellation
                    </button>
                    <a href="${pageContext.request.contextPath}/dashboard/appointments/list"
                       class="flex-1 px-6 py-3 bg-white/10 hover:bg-white/20 border border-white/20 text-white rounded-lg font-semibold transition flex items-center justify-center gap-2">
                        <i class="fas fa-arrow-left"></i>
                        Go Back
                    </a>
                </div>
            </div>
        </form>

        <!-- Tip Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-blue-500/30 rounded-2xl shadow-xl p-6">
            <div class="flex gap-4">
                <div class="w-10 h-10 bg-blue-500/20 rounded-lg flex items-center justify-center flex-shrink-0">
                    <i class="fas fa-lightbulb text-blue-400"></i>
                </div>
                <div>
                    <p class="text-sm font-semibold text-blue-300 mb-1">Tip:</p>
                    <p class="text-sm text-white/70">
                        If you need to reschedule instead of cancelling, consider contacting the patient directly
                        to arrange a new appointment time before cancelling this one.
                    </p>
                </div>
            </div>
        </div>
    </div>

</main>

<script>
    // Update character count
    function updateCharCount() {
        const textarea = document.getElementById('reason');
        const charCount = document.getElementById('charCount');
        charCount.textContent = textarea.value.length;
    }

    // Quick select reason
    function selectReason(reasonText) {
        const textarea = document.getElementById('reason');
        textarea.value = reasonText;
        updateCharCount();
        textarea.focus();
    }

    // Confirm cancellation
    function confirmCancellation() {
        const reason = document.getElementById('reason').value.trim();

        if (reason.length < 10) {
            alert('Please provide a more detailed reason (at least 10 characters)');
            return false;
        }

        return confirm('Are you sure you want to cancel this appointment? This action cannot be undone.');
    }

    // Initialize character count on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateCharCount();
    });
</script>

</body>
</html>