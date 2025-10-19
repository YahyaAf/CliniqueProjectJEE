<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Medical Note</title>
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
            <h1 class="text-3xl font-bold text-gray-900">Edit Medical Note</h1>
            <p class="mt-2 text-gray-600">Update medical record information</p>
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
            <div class="px-6 py-4 bg-gradient-to-r from-green-600 to-green-800">
                <h3 class="text-lg font-semibold text-white">
                    <i class="fas fa-edit mr-2"></i>Edit Medical Note Information
                </h3>
            </div>

            <!-- Appointment Info (Read-only) -->
            <div class="px-6 py-4 bg-gray-50 border-b border-gray-200">
                <h4 class="font-semibold text-gray-900 mb-3">
                    <i class="fas fa-info-circle mr-2 text-blue-600"></i>Appointment Information
                </h4>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="bg-white p-3 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600">Appointment Number</p>
                        <p class="font-semibold text-gray-900">#${medicalNote.appointmentNumber}</p>
                    </div>
                    <div class="bg-white p-3 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600">Patient</p>
                        <p class="font-semibold text-gray-900">
                            <i class="fas fa-user mr-2 text-gray-500"></i>${medicalNote.patientName}
                        </p>
                    </div>
                    <div class="bg-white p-3 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600">Appointment Date</p>
                        <p class="font-semibold text-gray-900">
                            <i class="fas fa-calendar mr-2 text-gray-500"></i>${medicalNote.appointmentDate}
                        </p>
                    </div>
                    <div class="bg-white p-3 rounded-lg border border-gray-200">
                        <p class="text-sm text-gray-600">Created At</p>
                        <p class="font-semibold text-gray-900">
                            <i class="fas fa-clock mr-2 text-gray-500"></i>
                            <fmt:formatDate value="${medicalNote.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                        </p>
                    </div>
                </div>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/dashboard/medicalNotes" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${medicalNote.id}">

                <div class="px-6 py-6 space-y-6">

                    <!-- Symptoms -->
                    <div>
                        <label for="symptoms" class="block text-sm font-medium text-gray-700 mb-2">
                            Symptoms <span class="text-red-600">*</span>
                        </label>
                        <textarea id="symptoms" name="symptoms" rows="4" required
                                  placeholder="Describe the patient's symptoms"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent resize-none"
                                  oninput="updateCharCount('symptoms', 'symptomsCount', 1000)">${medicalNote.symptoms}</textarea>
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
                                  placeholder="Enter prescribed medications, dosage, and instructions"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent resize-none"
                                  oninput="updateCharCount('prescription', 'prescriptionCount', 2000)">${medicalNote.prescription}</textarea>
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
                                  placeholder="Any additional observations, recommendations, or follow-up instructions"
                                  class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent resize-none"
                                  oninput="updateCharCount('notes', 'notesCount', 2000)">${medicalNote.notes}</textarea>
                        <div class="flex justify-between items-center mt-1">
                            <p class="text-xs text-gray-500">
                                <i class="fas fa-sticky-note mr-1"></i>Include follow-up recommendations or special instructions
                            </p>
                            <p class="text-xs text-gray-500">
                                <span id="notesCount">0</span> / 2000 characters
                            </p>
                        </div>
                    </div>

                    <!-- Warning Box -->
                    <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4">
                        <div class="flex">
                            <i class="fas fa-exclamation-triangle text-yellow-400 mt-1 mr-3"></i>
                            <div>
                                <p class="text-sm font-medium text-yellow-800">Important:</p>
                                <p class="text-sm text-yellow-700 mt-1">
                                    You are updating an existing medical note. Make sure all information is accurate before saving.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex gap-4 pt-4">
                        <button type="submit"
                                class="flex-1 bg-green-600 hover:bg-green-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                            <i class="fas fa-save mr-2"></i>Update Medical Note
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
        const symptoms = document.getElementById('symptoms').value.trim();

        if (!symptoms) {
            alert('Symptoms are required');
            return false;
        }

        if (symptoms.length < 10) {
            alert('Please provide more detailed symptoms (at least 10 characters)');
            return false;
        }

        return confirm('Are you sure you want to update this medical note?');
    }

    // Initialize character counters on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateCharCount('symptoms', 'symptomsCount', 1000);
        updateCharCount('prescription', 'prescriptionCount', 2000);
        updateCharCount('notes', 'notesCount', 2000);
    });
</script>
</body>
</html>