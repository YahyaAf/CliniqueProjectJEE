<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Notes - Doctor Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Header -->
        <div class="mb-8 flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-bold text-gray-900">Medical Notes</h1>
                <p class="mt-2 text-gray-600">Manage patient medical records and prescriptions</p>
            </div>
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=add"
               class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-lg shadow-lg transition duration-200 transform hover:scale-105">
                <i class="fas fa-plus mr-2"></i>Add Medical Note
            </a>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg shadow-md" role="alert">
                <div class="flex items-center">
                    <i class="fas fa-check-circle mr-3 text-xl"></i>
                    <p>${sessionScope.successMessage}</p>
                </div>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

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

        <!-- Doctor Info Card -->
        <div class="mb-6 bg-white rounded-lg shadow-md p-4 border-l-4 border-blue-500">
            <div class="flex items-center">
                <i class="fas fa-user-md text-4xl text-blue-600 mr-4"></i>
                <div>
                    <p class="text-sm text-gray-600">Doctor</p>
                    <p class="text-lg font-semibold text-gray-900">Dr. ${doctor.fullName}</p>
                    <p class="text-sm text-gray-500">${doctor.email}</p>
                </div>
            </div>
        </div>

        <!-- Medical Notes Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="px-6 py-4 bg-gradient-to-r from-blue-600 to-blue-800">
                <h3 class="text-lg font-semibold text-white">
                    <i class="fas fa-notes-medical mr-2"></i>Medical Notes List
                </h3>
            </div>

            <c:choose>
                <c:when test="${empty medicalNotes}">
                    <!-- No Medical Notes -->
                    <div class="p-12 text-center">
                        <i class="fas fa-file-medical text-6xl text-gray-300 mb-4"></i>
                        <h3 class="text-xl font-semibold text-gray-700 mb-2">No Medical Notes Found</h3>
                        <p class="text-gray-500 mb-4">You haven't created any medical notes yet.</p>
                        <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=add"
                           class="inline-block bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-lg transition duration-200">
                            <i class="fas fa-plus mr-2"></i>Create Your First Medical Note
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Medical Notes Table -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Appointment
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Patient
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Date
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Symptoms
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Created At
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="note" items="${medicalNotes}">
                                <tr class="hover:bg-gray-50 transition duration-150">
                                    <!-- Appointment Number -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-mono font-semibold text-gray-900">
                                            #${note.appointmentNumber}
                                        </div>
                                    </td>

                                    <!-- Patient -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <i class="fas fa-user text-gray-400 mr-2"></i>
                                            <div class="text-sm font-medium text-gray-900">
                                                    ${note.patientName}
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Appointment Date -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <i class="fas fa-calendar text-gray-400 mr-2"></i>
                                            <div class="text-sm text-gray-900">
                                                    ${note.appointmentDate}
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Symptoms Preview -->
                                    <td class="px-6 py-4">
                                        <div class="text-sm text-gray-900 max-w-xs truncate">
                                            <i class="fas fa-heartbeat text-red-500 mr-2"></i>
                                                ${note.symptoms}
                                        </div>
                                    </td>

                                    <!-- Created At -->
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-500">
                                            <i class="fas fa-clock mr-2"></i>
                                                ${note.formattedCreatedAt}
                                        </div>
                                    </td>

                                    <!-- Actions -->
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div class="flex gap-2">
                                            <!-- View -->
                                            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=view&id=${note.id}"
                                               class="text-blue-600 hover:text-blue-900 font-semibold transition duration-150"
                                               title="View Details">
                                                <i class="fas fa-eye mr-1"></i>View
                                            </a>

                                            <!-- Edit -->
                                            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=edit&id=${note.id}"
                                               class="text-green-600 hover:text-green-900 font-semibold transition duration-150"
                                               title="Edit">
                                                <i class="fas fa-edit mr-1"></i>Edit
                                            </a>

                                            <!-- Delete -->
                                            <button onclick="confirmDelete('${note.id}', '${note.appointmentNumber}')"
                                                    class="text-red-600 hover:text-red-900 font-semibold transition duration-150"
                                                    title="Delete">
                                                <i class="fas fa-trash mr-1"></i>Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Total Count -->
                    <div class="px-6 py-4 bg-gray-50 border-t border-gray-200">
                        <p class="text-sm text-gray-600">
                            <i class="fas fa-info-circle mr-2"></i>
                            Total: <span class="font-semibold">${count}</span> medical note(s)
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
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
                Are you sure you want to delete the medical note for appointment <span id="deleteAppointmentNumber" class="font-semibold"></span>?
                <br><span class="text-red-600">This action cannot be undone!</span>
            </p>

            <form id="deleteForm" method="get" action="${pageContext.request.contextPath}/dashboard/medicalNotes">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="deleteNoteId" name="id">
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
    function confirmDelete(noteId, appointmentNumber) {
        document.getElementById('deleteNoteId').value = noteId;
        document.getElementById('deleteAppointmentNumber').textContent = '#' + appointmentNumber;
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
</script>
</body>
</html>