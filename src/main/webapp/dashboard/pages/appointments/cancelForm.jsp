<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Appointment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen py-8">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="mb-8">
            <a href="${pageContext.request.contextPath}/dashboard/appointments/list"
               class="text-blue-600 hover:text-blue-800 font-semibold mb-4 inline-block">
                <i class="fas fa-arrow-left mr-2"></i>Back to Appointments
            </a>
            <h1 class="text-3xl font-bold text-gray-900">Cancel Appointment</h1>
            <p class="mt-2 text-gray-600">Please provide a reason for cancelling this appointment</p>
        </div>

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

        <!-- Main Card -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden">

            <!-- Warning Header -->
            <div class="bg-red-600 px-6 py-4">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-triangle text-white text-3xl mr-4"></i>
                    <div>
                        <h2 class="text-xl font-bold text-white">Warning: Appointment Cancellation</h2>
                        <p class="text-red-100 text-sm">This action cannot be undone</p>
                    </div>
                </div>
            </div>

            <!-- Appointment Details -->
            <div class="px-6 py-6 bg-gray-50 border-b border-gray-200">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">
                    <i class="fas fa-info-circle mr-2 text-blue-600"></i>Appointment Details
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Appointment Number -->
                    <div class="bg-white p-4 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600 mb-1">Appointment Number</p>
                        <p class="font-semibold text-gray-900 text-lg">#${appointment.appointmentNumber}</p>
                    </div>

                    <!-- Patient -->
                    <div class="bg-white p-4 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600 mb-1">Patient</p>
                        <p class="font-semibold text-gray-900">
                            <i class="fas fa-user mr-2 text-gray-500"></i>${appointment.patient.user.fullName}
                        </p>
                    </div>

                    <!-- Date -->
                    <div class="bg-white p-4 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600 mb-1">Date</p>
                        <p class="font-semibold text-gray-900">
                            <i class="fas fa-calendar mr-2 text-gray-500"></i>${appointment.appointmentDate}
                        </p>
                    </div>

                    <!-- Time -->
                    <div class="bg-white p-4 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600 mb-1">Time</p>
                        <p class="font-semibold text-gray-900">
                            <i class="fas fa-clock mr-2 text-gray-500"></i>${appointment.startTime} - ${appointment.endTime}
                        </p>
                    </div>

                    <!-- Status -->
                    <div class="bg-white p-4 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600 mb-1">Current Status</p>
                        <span class="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">
                            <i class="fas fa-circle text-xs mr-2"></i>${appointment.status}
                        </span>
                    </div>
                </div>
            </div>

            <!-- Cancellation Form -->
            <form method="post" action="${pageContext.request.contextPath}/dashboard/appointments/cancelProcess"
                  onsubmit="return confirmCancellation()">

                <input type="hidden" name="appointmentId" value="${appointment.id}">

                <div class="px-6 py-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">
                        <i class="fas fa-comment-dots mr-2 text-red-600"></i>Cancellation Reason
                    </h3>

                    <!-- Reason Textarea -->
                    <div class="mb-6">
                        <label for="reason" class="block text-sm font-medium text-gray-700 mb-2">
                            Please explain why you are cancelling this appointment <span class="text-red-600">*</span>
                        </label>
                        <textarea
                                id="reason"
                                name="reason"
                                rows="6"
                                required
                                maxlength="500"
                                placeholder="Enter the reason for cancellation (e.g., Emergency, Patient request, Schedule conflict, etc.)"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-red-500 focus:border-transparent resize-none"
                                oninput="updateCharCount()"></textarea>
                        <div class="flex justify-between items-center mt-2">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-info-circle mr-1"></i>This reason will be visible to the patient
                            </p>
                            <p class="text-xs text-gray-500">
                                <span id="charCount">0</span> / 500 characters
                            </p>
                        </div>
                    </div>

                    <!-- Common Reasons (Quick Select) -->
                    <div class="mb-6">
                        <label class="block text-sm font-medium text-gray-700 mb-3">Quick Select Common Reasons:</label>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
                            <button type="button" onclick="selectReason('Emergency - Unable to attend')"
                                    class="text-left px-4 py-3 border border-gray-300 rounded-lg hover:bg-gray-50 transition duration-150">
                                <i class="fas fa-ambulance text-red-500 mr-2"></i>Emergency
                            </button>
                            <button type="button" onclick="selectReason('Patient requested cancellation')"
                                    class="text-left px-4 py-3 border border-gray-300 rounded-lg hover:bg-gray-50 transition duration-150">
                                <i class="fas fa-user-times text-blue-500 mr-2"></i>Patient Request
                            </button>
                            <button type="button" onclick="selectReason('Schedule conflict with another appointment')"
                                    class="text-left px-4 py-3 border border-gray-300 rounded-lg hover:bg-gray-50 transition duration-150">
                                <i class="fas fa-calendar-times text-orange-500 mr-2"></i>Schedule Conflict
                            </button>
                            <button type="button" onclick="selectReason('Doctor unavailable due to unforeseen circumstances')"
                                    class="text-left px-4 py-3 border border-gray-300 rounded-lg hover:bg-gray-50 transition duration-150">
                                <i class="fas fa-user-md-times text-purple-500 mr-2"></i>Doctor Unavailable
                            </button>
                        </div>
                    </div>

                    <!-- Warning Box -->
                    <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4 mb-6">
                        <div class="flex">
                            <i class="fas fa-exclamation-triangle text-yellow-400 mt-1 mr-3"></i>
                            <div>
                                <p class="text-sm font-medium text-yellow-800">Important Notice:</p>
                                <ul class="mt-2 text-sm text-yellow-700 list-disc list-inside space-y-1">
                                    <li>The patient will be notified immediately about this cancellation</li>
                                    <li>The time slot will become available for other patients</li>
                                    <li>This action cannot be reversed</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4">
                        <button type="submit"
                                class="flex-1 bg-red-600 hover:bg-red-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                            <i class="fas fa-times-circle mr-2"></i>Confirm Cancellation
                        </button>
                        <a href="${pageContext.request.contextPath}/dashboard/appointments/list"
                           class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-6 rounded-lg shadow-lg text-center transition duration-200 transform hover:scale-105">
                            <i class="fas fa-arrow-left mr-2"></i>Go Back
                        </a>
                    </div>
                </div>
            </form>
        </div>

        <!-- Additional Info -->
        <div class="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
            <div class="flex items-start">
                <i class="fas fa-lightbulb text-blue-500 text-xl mt-1 mr-3"></i>
                <div>
                    <p class="text-sm font-medium text-blue-900">Tip:</p>
                    <p class="text-sm text-blue-700 mt-1">
                        If you need to reschedule instead of cancelling, consider contacting the patient directly
                        to arrange a new appointment time before cancelling this one.
                    </p>
                </div>
            </div>
        </div>

    </div>
</div>

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