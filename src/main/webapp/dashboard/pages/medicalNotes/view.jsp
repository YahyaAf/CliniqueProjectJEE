<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Medical Note</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen py-8">
    <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="mb-8">
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
               class="text-blue-600 hover:text-blue-800 font-semibold mb-4 inline-block">
                <i class="fas fa-arrow-left mr-2"></i>Back to Medical Notes
            </a>
            <div class="flex justify-between items-start">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Medical Note Details</h1>
                    <p class="mt-2 text-gray-600">Complete medical record information</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=edit&id=${medicalNote.id}"
                       class="bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-4 rounded-lg shadow-lg transition duration-200">
                        <i class="fas fa-edit mr-2"></i>Edit
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Card -->
        <div class="bg-white rounded-lg shadow-lg overflow-hidden">

            <!-- Header Section -->
            <div class="px-6 py-4 bg-gradient-to-r from-blue-600 to-blue-800">
                <div class="flex justify-between items-center text-white">
                    <div>
                        <h2 class="text-xl font-bold">Medical Note #${medicalNote.id}</h2>
                        <p class="text-sm text-blue-100 mt-1">
                            <i class="fas fa-calendar mr-2"></i>
                            Created: ${medicalNote.formattedCreatedAt}
                        </p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-blue-100">Appointment</p>
                        <p class="text-2xl font-bold">#${medicalNote.appointmentNumber}</p>
                    </div>
                </div>
            </div>

            <!-- Appointment Information -->
            <div class="px-6 py-6 bg-gray-50 border-b border-gray-200">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">
                    <i class="fas fa-info-circle mr-2 text-blue-600"></i>Appointment Information
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <!-- Patient -->
                    <div class="bg-white p-4 rounded-lg border-l-4 border-blue-500 shadow-sm">
                        <div class="flex items-center mb-2">
                            <i class="fas fa-user text-blue-600 text-2xl mr-3"></i>
                            <div>
                                <p class="text-xs text-gray-500 uppercase">Patient</p>
                                <p class="text-lg font-semibold text-gray-900">${medicalNote.patientName}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Doctor -->
                    <div class="bg-white p-4 rounded-lg border-l-4 border-green-500 shadow-sm">
                        <div class="flex items-center mb-2">
                            <i class="fas fa-user-md text-green-600 text-2xl mr-3"></i>
                            <div>
                                <p class="text-xs text-gray-500 uppercase">Doctor</p>
                                <p class="text-lg font-semibold text-gray-900">Dr. ${medicalNote.doctorName}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Date -->
                    <div class="bg-white p-4 rounded-lg border-l-4 border-purple-500 shadow-sm">
                        <div class="flex items-center mb-2">
                            <i class="fas fa-calendar-alt text-purple-600 text-2xl mr-3"></i>
                            <div>
                                <p class="text-xs text-gray-500 uppercase">Appointment Date</p>
                                <p class="text-lg font-semibold text-gray-900">${medicalNote.appointmentDate}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Medical Information -->
            <div class="px-6 py-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-6">
                    <i class="fas fa-notes-medical mr-2 text-red-600"></i>Medical Information
                </h3>

                <div class="space-y-6">
                    <!-- Symptoms -->
                    <div class="bg-red-50 rounded-lg p-5 border-l-4 border-red-500">
                        <div class="flex items-start">
                            <div class="flex-shrink-0">
                                <div class="bg-red-100 rounded-full p-3">
                                    <i class="fas fa-heartbeat text-red-600 text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h4 class="text-lg font-semibold text-red-900 mb-2">
                                    Symptoms
                                    <span class="ml-2 text-xs bg-red-200 text-red-800 px-2 py-1 rounded-full">Required</span>
                                </h4>
                                <div class="text-gray-800 whitespace-pre-wrap leading-relaxed">
                                    ${medicalNote.symptoms}
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Prescription -->
                    <div class="bg-green-50 rounded-lg p-5 border-l-4 border-green-500">
                        <div class="flex items-start">
                            <div class="flex-shrink-0">
                                <div class="bg-green-100 rounded-full p-3">
                                    <i class="fas fa-pills text-green-600 text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h4 class="text-lg font-semibold text-green-900 mb-2">Prescription</h4>
                                <c:choose>
                                    <c:when test="${not empty medicalNote.prescription}">
                                        <div class="text-gray-800 whitespace-pre-wrap leading-relaxed">
                                                ${medicalNote.prescription}
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-gray-500 italic">No prescription provided</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Notes -->
                    <div class="bg-blue-50 rounded-lg p-5 border-l-4 border-blue-500">
                        <div class="flex items-start">
                            <div class="flex-shrink-0">
                                <div class="bg-blue-100 rounded-full p-3">
                                    <i class="fas fa-sticky-note text-blue-600 text-xl"></i>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <h4 class="text-lg font-semibold text-blue-900 mb-2">Additional Notes</h4>
                                <c:choose>
                                    <c:when test="${not empty medicalNote.notes}">
                                        <div class="text-gray-800 whitespace-pre-wrap leading-relaxed">
                                                ${medicalNote.notes}
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-gray-500 italic">No additional notes</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer with Metadata -->
            <div class="px-6 py-4 bg-gray-50 border-t border-gray-200">
                <div class="flex justify-between items-center text-sm text-gray-600">
                    <div>
                        <i class="fas fa-clock mr-2"></i>
                        Created: <span class="font-semibold">
                        ${medicalNote.createdAt}
                    </span>
                    </div>
                    <div>
                        <i class="fas fa-fingerprint mr-2"></i>
                        Medical Note ID: <span class="font-mono font-semibold">${medicalNote.id}</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="mt-6 flex gap-4">
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=edit&id=${medicalNote.id}"
               class="flex-1 bg-green-600 hover:bg-green-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg text-center transition duration-200 transform hover:scale-105">
                <i class="fas fa-edit mr-2"></i>Edit Medical Note
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
               class="flex-1 bg-gray-600 hover:bg-gray-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg text-center transition duration-200 transform hover:scale-105">
                <i class="fas fa-list mr-2"></i>Back to List
            </a>
            <button onclick="confirmDelete()"
                    class="flex-1 bg-red-600 hover:bg-red-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                <i class="fas fa-trash mr-2"></i>Delete Medical Note
            </button>
        </div>

        <!-- Info Footer -->
        <div class="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-4">
            <div class="flex items-start">
                <i class="fas fa-info-circle text-blue-500 text-xl mt-1 mr-3"></i>
                <div>
                    <p class="text-sm font-medium text-blue-900">Medical Record Information</p>
                    <p class="text-sm text-blue-700 mt-1">
                        This medical note is a confidential record of the patient's consultation.
                        All information should be kept secure and only shared with authorized medical personnel.
                    </p>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-lg bg-white">
        <div class="mt-3">
            <div class="flex items-center justify-center mb-4">
                <i class="fas fa-exclamation-triangle text-red-500 text-5xl"></i>
            </div>
            <h3 class="text-lg font-semibold text-gray-900 text-center mb-2">Delete Medical Note</h3>
            <p class="text-sm text-gray-600 text-center mb-4">
                Are you sure you want to delete this medical note?
                <br><span class="text-red-600 font-semibold">This action cannot be undone!</span>
            </p>

            <form method="get" action="${pageContext.request.contextPath}/dashboard/medicalNotes">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="${medicalNote.id}">
                <div class="flex gap-3">
                    <button type="button" onclick="closeDeleteModal()"
                            class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-2 px-4 rounded-lg transition duration-200">
                        <i class="fas fa-times mr-2"></i>Cancel
                    </button>
                    <button type="submit"
                            class="flex-1 bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-200">
                        <i class="fas fa-trash mr-2"></i>Delete
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function confirmDelete() {
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    // Close modal when clicking outside
    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeDeleteModal();
        }
    });

    // Print styles
    window.addEventListener('beforeprint', function() {
        document.querySelectorAll('.no-print').forEach(el => el.style.display = 'none');
    });

    window.addEventListener('afterprint', function() {
        document.querySelectorAll('.no-print').forEach(el => el.style.display = '');
    });
</script>

<!-- Print Styles -->
<style>
    @media print {
        body {
            background: white;
        }
        .no-print,
        button,
        a[href*="edit"],
        a[href*="Back"] {
            display: none !important;
        }
        .shadow-lg,
        .shadow-md {
            box-shadow: none !important;
        }
    }
</style>
</body>
</html>