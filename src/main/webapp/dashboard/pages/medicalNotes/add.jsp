<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Medical Note</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen py-8">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="mb-8">
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
               class="text-blue-600 hover:text-blue-800 font-semibold mb-4 inline-block">
                <i class="fas fa-arrow-left mr-2"></i>Back to Medical Notes
            </a>
            <h1 class="text-3xl font-bold text-gray-900">Add Medical Note</h1>
            <p class="mt-2 text-gray-600">Create a new medical record for a completed appointment</p>
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

        <!-- Form Card -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden">
            <div class="px-6 py-4 bg-gradient-to-r from-blue-600 to-blue-800">
                <h3 class="text-lg font-semibold text-white">
                    <i class="fas fa-file-medical mr-2"></i>Medical Note Information
                </h3>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/dashboard/medicalNotes" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="add">

                <div class="px-6 py-6 space-y-6">

                    <!-- Select Appointment -->
                    <div>
                        <label for="appointmentId" class="block text-sm font-medium text-gray-700 mb-2">
                            Select Appointment <span class="text-red-600">*</span>
                        </label>
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4">
                                    <div class="flex">
                                        <i class="fas fa-exclamation-triangle text-yellow-400 mt-1 mr-3"></i>
                                        <div>
                                            <p class="text-sm font-medium text-yellow-800">No Appointments Available</p>
                                            <p class="text-sm text-yellow-700 mt-1">
                                                All completed appointments already have medical notes.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <select id="appointmentId" name="appointmentId" required onchange="showAppointmentDetails()"
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                                    <option value="">-- Select an Appointment --</option>
                                    <c:forEach var="appointment" items="${appointments}">
                                        <option value="${appointment.id}"
                                                data-patient="${appointment.patient.user.fullName}"
                                                data-date="${appointment.appointmentDate}"
                                                data-time="${appointment.startTime} - ${appointment.endTime}"
                                                data-number="${appointment.appointmentNumber}">
                                            #${appointment.appointmentNumber} - ${appointment.patient.user.fullName} - ${appointment.appointmentDate}
                                        </option>
                                    </c:forEach>
                                </select>

                                <!-- Appointment Details Preview -->
                                <div id="appointmentDetails" class="hidden mt-3 bg-blue-50 border border-blue-200 rounded-lg p-4">
                                    <h4 class="font-semibold text-blue-900 mb-2">
                                        <i class="fas fa-info-circle mr-2"></i>Appointment Details
                                    </h4>
                                    <div class="grid grid-cols-2 gap-3 text-sm">
                                        <div>
                                            <p class="text-gray-600">Patient:</p>
                                            <p class="font-semibold text-gray-900" id="detailPatient">-</p>
                                        </div>
                                        <div>
                                            <p class="text-gray-600">Appointment #:</p>
                                            <p class="font-semibold text-gray-900" id="detailNumber">-</p>
                                        </div>
                                        <div>
                                            <p class="text-gray-600">Date:</p>
                                            <p class="font-semibold text-gray-900" id="detailDate">-</p>
                                        </div>
                                        <div>
                                            <p class="text-gray-600">Time:</p>
                                            <p class="font-semibold text-gray-900" id="detailTime">-</p>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Symptoms -->
                    <div>
                        <label for="symptoms" class="block text-sm font-medium text-gray-700 mb-2">
                            Symptoms <span class="text-red-600">*</span>
                        </label>
                        <textarea id="symptoms" name="symptoms" rows="4" required
                                  placeholder="Describe the patient's symptoms (e.g., fever, cough, headache, etc.)"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  oninput="updateCharCount('symptoms', 'symptomsCount', 1000)"></textarea>
                        <div class="flex justify-between items-center mt-1">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-info-circle mr-1"></i>Be as specific as possible
                            </p>
                            <p class="text-xs text-gray-500">
                                <span id="symptomsCount">0</span> / 1000 characters
                            </p>
                        </div>
                    </div>

                    <!-- Prescription -->
                    <div>
                        <label for="prescription" class="block text-sm font-medium text-gray-700 mb-2">
                            Prescription
                        </label>
                        <textarea id="prescription" name="prescription" rows="5"
                                  placeholder="Enter prescribed medications, dosage, and instructions (Optional)"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  oninput="updateCharCount('prescription', 'prescriptionCount', 2000)"></textarea>
                        <div class="flex justify-between items-center mt-1">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-pills mr-1"></i>Include medication names, dosages, and duration
                            </p>
                            <p class="text-xs text-gray-500">
                                <span id="prescriptionCount">0</span> / 2000 characters
                            </p>
                        </div>
                    </div>

                    <!-- Additional Notes -->
                    <div>
                        <label for="notes" class="block text-sm font-medium text-gray-700 mb-2">
                            Additional Notes
                        </label>
                        <textarea id="notes" name="notes" rows="5"
                                  placeholder="Any additional observations, recommendations, or follow-up instructions (Optional)"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent resize-none"
                                  oninput="updateCharCount('notes', 'notesCount', 2000)"></textarea>
                        <div class="flex justify-between items-center mt-1">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-sticky-note mr-1"></i>Include follow-up recommendations or special instructions
                            </p>
                            <p class="text-xs text-gray-500">
                                <span id="notesCount">0</span> / 2000 characters
                            </p>
                        </div>
                    </div>

                    <!-- Info Box -->
                    <div class="bg-blue-50 border-l-4 border-blue-400 p-4">
                        <div class="flex">
                            <i class="fas fa-lightbulb text-blue-400 mt-1 mr-3"></i>
                            <div>
                                <p class="text-sm font-medium text-blue-900">Important:</p>
                                <ul class="mt-2 text-sm text-blue-700 list-disc list-inside space-y-1">
                                    <li>Only completed appointments can have medical notes</li>
                                    <li>Each appointment can only have one medical note</li>
                                    <li>Symptoms field is required, others are optional</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4 pt-4">
                        <button type="submit" ${empty appointments ? 'disabled' : ''}
                                class="flex-1 bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none">
                            <i class="fas fa-save mr-2"></i>Save Medical Note
                        </button>
                        <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
                           class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-6 rounded-lg shadow-lg text-center transition duration-200 transform hover:scale-105">
                            <i class="fas fa-times mr-2"></i>Cancel
                        </a>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>

<script>
    function showAppointmentDetails() {
        const select = document.getElementById('appointmentId');
        const selectedOption = select.options[select.selectedIndex];
        const detailsDiv = document.getElementById('appointmentDetails');

        if (select.value) {
            document.getElementById('detailPatient').textContent = selectedOption.dataset.patient;
            document.getElementById('detailNumber').textContent = '#' + selectedOption.dataset.number;
            document.getElementById('detailDate').textContent = selectedOption.dataset.date;
            document.getElementById('detailTime').textContent = selectedOption.dataset.time;
            detailsDiv.classList.remove('hidden');
        } else {
            detailsDiv.classList.add('hidden');
        }
    }

    function updateCharCount(textareaId, counterId, maxLength) {
        const textarea = document.getElementById(textareaId);
        const counter = document.getElementById(counterId);
        const currentLength = textarea.value.length;
        counter.textContent = currentLength;

        if (currentLength > maxLength) {
            textarea.value = textarea.value.substring(0, maxLength);
            counter.textContent = maxLength;
        }
    }

    function validateForm() {
        const appointmentId = document.getElementById('appointmentId').value;
        const symptoms = document.getElementById('symptoms').value.trim();

        if (!appointmentId) {
            alert('Please select an appointment');
            return false;
        }

        if (!symptoms) {
            alert('Symptoms are required');
            return false;
        }

        if (symptoms.length < 10) {
            alert('Please provide more detailed symptoms (at least 10 characters)');
            return false;
        }

        return confirm('Are you sure you want to save this medical note?');
    }

    // Initialize character counters
    document.addEventListener('DOMContentLoaded', function() {
        updateCharCount('symptoms', 'symptomsCount', 1000);
        updateCharCount('prescription', 'prescriptionCount', 2000);
        updateCharCount('notes', 'notesCount', 2000);
    });
</script>
</body>
</html>