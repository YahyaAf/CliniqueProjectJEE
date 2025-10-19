<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Medical Note - MediCare+</title>
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
<c:set var="currentPage" value="medical-notes" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
           class="inline-flex items-center gap-2 text-white/80 hover:text-white font-medium mb-4 transition">
            <i class="fas fa-arrow-left"></i>
            Back to Medical Notes
        </a>
        <h1 class="text-3xl font-bold text-white mb-2">Add Medical Note</h1>
        <p class="text-white/70">Create a new medical record for a completed appointment</p>
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

    <!-- Form Card -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-8 max-w-5xl">

        <form method="post" action="${pageContext.request.contextPath}/dashboard/medicalNotes" onsubmit="return validateForm()">
            <input type="hidden" name="action" value="add">

            <div class="space-y-6">

                <!-- Select Appointment -->
                <div>
                    <label for="appointmentId" class="block text-sm font-medium text-white/90 mb-2">
                        Select Appointment <span class="text-red-400">*</span>
                    </label>
                    <c:choose>
                        <c:when test="${empty appointments}">
                            <div class="bg-yellow-500/10 border border-yellow-500/30 rounded-lg p-4">
                                <div class="flex gap-3">
                                    <i class="fas fa-exclamation-triangle text-yellow-400 text-lg mt-1"></i>
                                    <div>
                                        <p class="text-sm font-semibold text-yellow-300 mb-1">No Appointments Available</p>
                                        <p class="text-sm text-yellow-200/90">
                                            All completed appointments already have medical notes.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <select id="appointmentId" name="appointmentId" required onchange="showAppointmentDetails()"
                                    class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-purple-400 focus:border-purple-400 outline-none transition text-white">
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
                            <div id="appointmentDetails" class="hidden mt-3 bg-blue-500/10 border border-blue-500/30 rounded-lg p-4">
                                <h4 class="font-semibold text-blue-300 mb-3 flex items-center gap-2">
                                    <i class="fas fa-info-circle"></i>
                                    Appointment Details
                                </h4>
                                <div class="grid grid-cols-2 gap-4 text-sm">
                                    <div>
                                        <p class="text-white/60 mb-1">Patient:</p>
                                        <p class="font-semibold text-white" id="detailPatient">-</p>
                                    </div>
                                    <div>
                                        <p class="text-white/60 mb-1">Appointment #:</p>
                                        <p class="font-semibold text-white" id="detailNumber">-</p>
                                    </div>
                                    <div>
                                        <p class="text-white/60 mb-1">Date:</p>
                                        <p class="font-semibold text-white" id="detailDate">-</p>
                                    </div>
                                    <div>
                                        <p class="text-white/60 mb-1">Time:</p>
                                        <p class="font-semibold text-white" id="detailTime">-</p>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Symptoms -->
                <div>
                    <label for="symptoms" class="block text-sm font-medium text-white/90 mb-2">
                        Symptoms <span class="text-red-400">*</span>
                    </label>
                    <textarea id="symptoms" name="symptoms" rows="4" required
                              placeholder="Describe the patient's symptoms (e.g., fever, cough, headache, etc.)"
                              class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-purple-400 focus:border-purple-400 outline-none transition text-white placeholder-white/50 resize-none"
                              oninput="updateCharCount('symptoms', 'symptomsCount', 1000)"></textarea>
                    <div class="flex justify-between items-center mt-2">
                        <p class="text-xs text-white/60">
                            <i class="fas fa-info-circle mr-1"></i>Be as specific as possible
                        </p>
                        <p class="text-xs text-white/60">
                            <span id="symptomsCount">0</span> / 1000 characters
                        </p>
                    </div>
                </div>

                <!-- Prescription -->
                <div>
                    <label for="prescription" class="block text-sm font-medium text-white/90 mb-2">
                        Prescription
                    </label>
                    <textarea id="prescription" name="prescription" rows="5"
                              placeholder="Enter prescribed medications, dosage, and instructions (Optional)"
                              class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-purple-400 focus:border-purple-400 outline-none transition text-white placeholder-white/50 resize-none"
                              oninput="updateCharCount('prescription', 'prescriptionCount', 2000)"></textarea>
                    <div class="flex justify-between items-center mt-2">
                        <p class="text-xs text-white/60">
                            <i class="fas fa-pills mr-1"></i>Include medication names, dosages, and duration
                        </p>
                        <p class="text-xs text-white/60">
                            <span id="prescriptionCount">0</span> / 2000 characters
                        </p>
                    </div>
                </div>

                <!-- Additional Notes -->
                <div>
                    <label for="notes" class="block text-sm font-medium text-white/90 mb-2">
                        Additional Notes
                    </label>
                    <textarea id="notes" name="notes" rows="5"
                              placeholder="Any additional observations, recommendations, or follow-up instructions (Optional)"
                              class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-purple-400 focus:border-purple-400 outline-none transition text-white placeholder-white/50 resize-none"
                              oninput="updateCharCount('notes', 'notesCount', 2000)"></textarea>
                    <div class="flex justify-between items-center mt-2">
                        <p class="text-xs text-white/60">
                            <i class="fas fa-sticky-note mr-1"></i>Include follow-up recommendations or special instructions
                        </p>
                        <p class="text-xs text-white/60">
                            <span id="notesCount">0</span> / 2000 characters
                        </p>
                    </div>
                </div>

                <!-- Info Box -->
                <div class="bg-blue-500/10 border border-blue-500/30 rounded-lg p-4">
                    <div class="flex gap-3">
                        <i class="fas fa-lightbulb text-blue-400 text-lg mt-1"></i>
                        <div>
                            <p class="text-sm font-semibold text-blue-300 mb-2">Important:</p>
                            <ul class="text-sm text-blue-200/90 space-y-1">
                                <li class="flex items-start gap-2">
                                    <i class="fas fa-check text-xs mt-1"></i>
                                    <span>Only completed appointments can have medical notes</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <i class="fas fa-check text-xs mt-1"></i>
                                    <span>Each appointment can only have one medical note</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <i class="fas fa-check text-xs mt-1"></i>
                                    <span>Symptoms field is required, others are optional</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-3 pt-4">
                    <button type="submit" ${empty appointments ? 'disabled' : ''}
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white rounded-lg font-semibold transition shadow-lg shadow-purple-600/30 flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed">
                        <i class="fas fa-save"></i>
                        Save Medical Note
                    </button>
                    <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
                       class="flex-1 px-6 py-3 bg-white/10 hover:bg-white/20 border border-white/20 text-white rounded-lg font-semibold transition flex items-center justify-center gap-2">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </div>

        </form>
    </div>

</main>

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