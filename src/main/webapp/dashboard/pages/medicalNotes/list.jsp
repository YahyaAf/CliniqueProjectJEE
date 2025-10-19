<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Notes - MediCare+</title>
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
        <h1 class="text-3xl font-bold text-white mb-2">Medical Notes</h1>
        <p class="text-white/70">Manage patient medical records and prescriptions</p>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="mb-6 bg-green-500/20 backdrop-blur-lg border border-green-500/30 rounded-xl p-4">
            <div class="flex items-center">
                <i class="fas fa-check-circle text-green-400 text-xl mr-3"></i>
                <p class="text-green-300">${sessionScope.successMessage}</p>
            </div>
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

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

    <!-- Doctor Info & Stats -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">
        <!-- Doctor Info Card -->
        <div class="md:col-span-2 bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6">
            <div class="flex items-center gap-4">
                <div class="w-14 h-14 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center">
                    <i class="fas fa-user-md text-white text-2xl"></i>
                </div>
                <div>
                    <p class="text-white/60 text-sm">Logged in as Doctor</p>
                    <p class="text-xl font-bold text-white">Dr. ${doctor.fullName}</p>
                    <p class="text-white/70 text-sm">
                        <i class="fas fa-envelope mr-2"></i>${doctor.email}
                    </p>
                </div>
            </div>
        </div>

        <!-- Total Notes Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-purple-500/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-notes-medical text-purple-400 text-xl"></i>
                </div>
                <div>
                    <p class="text-white/60 text-sm">Total Notes</p>
                    <p class="text-2xl font-bold text-white">${count}</p>
                </div>
            </div>
        </div>

        <!-- Add Button Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6">
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=add"
               class="flex items-center justify-center h-full gap-3 text-emerald-400 hover:text-emerald-300 transition group">
                <div class="w-12 h-12 bg-emerald-500/20 group-hover:bg-emerald-500/30 rounded-xl flex items-center justify-center transition">
                    <i class="fas fa-plus text-xl"></i>
                </div>
                <span class="font-semibold">Add Note</span>
            </a>
        </div>
    </div>

    <!-- Medical Notes Table -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden">

        <!-- Table Header -->
        <div class="p-6 border-b border-white/10">
            <div class="flex items-center justify-between">
                <h2 class="text-xl font-bold text-white">Medical Notes List</h2>
                <div class="relative">
                    <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-white/40"></i>
                    <input type="text"
                           id="searchInput"
                           placeholder="Search notes..."
                           class="pl-10 pr-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/50 focus:ring-2 focus:ring-purple-400 focus:border-purple-400 outline-none transition">
                </div>
            </div>
        </div>

        <!-- Table Content -->
        <c:if test="${empty medicalNotes}">
            <div class="p-12 text-center">
                <div class="w-20 h-20 bg-slate-700/50 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-file-medical text-slate-500 text-3xl"></i>
                </div>
                <p class="text-white/60 text-lg mb-4">No medical notes found.</p>
                <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=add"
                   class="inline-block px-6 py-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white rounded-lg font-medium transition">
                    <i class="fas fa-plus mr-2"></i>Create Your First Medical Note
                </a>
            </div>
        </c:if>

        <c:if test="${not empty medicalNotes}">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                    <tr class="bg-slate-700/30 border-b border-white/10">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-hashtag text-purple-400"></i>
                                Appointment
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-user text-purple-400"></i>
                                Patient
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-calendar text-purple-400"></i>
                                Date
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-heartbeat text-purple-400"></i>
                                Symptoms
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-clock text-purple-400"></i>
                                Created
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            Actions
                        </th>
                    </tr>
                    </thead>
                    <tbody id="notesTableBody">
                    <c:forEach var="note" items="${medicalNotes}">
                        <tr class="border-b border-white/5 hover:bg-white/5 transition-colors">
                            <td class="px-6 py-4">
                                <span class="font-mono font-semibold text-white">
                                    #${note.appointmentNumber}
                                </span>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-gradient-to-br from-pink-500 to-purple-600 rounded-full flex items-center justify-center text-white font-semibold">
                                            ${note.patientName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <span class="text-white font-medium">${note.patientName}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-white/70">
                                    ${note.appointmentDate}
                            </td>
                            <td class="px-6 py-4">
                                <div class="text-sm text-white/70 max-w-xs truncate" title="${note.symptoms}">
                                        ${note.symptoms}
                                </div>
                            </td>
                            <td class="px-6 py-4 text-white/70 text-sm">
                                    ${note.formattedCreatedAt}
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=view&id=${note.id}"
                                       class="w-8 h-8 bg-blue-500/20 hover:bg-blue-500/30 text-blue-300 rounded-lg transition flex items-center justify-center"
                                       title="View Details">
                                        <i class="fas fa-eye text-sm"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=edit&id=${note.id}"
                                       class="w-8 h-8 bg-amber-500/20 hover:bg-amber-500/30 text-amber-300 rounded-lg transition flex items-center justify-center"
                                       title="Edit">
                                        <i class="fas fa-edit text-sm"></i>
                                    </a>
                                    <button onclick="confirmDelete('${note.id}', '${note.appointmentNumber}')"
                                            class="w-8 h-8 bg-red-500/20 hover:bg-red-500/30 text-red-300 rounded-lg transition flex items-center justify-center"
                                            title="Delete">
                                        <i class="fas fa-trash text-sm"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

    </div>
</main>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="hidden fixed inset-0 bg-black/70 backdrop-blur-sm overflow-y-auto h-full w-full z-50">
    <div class="relative top-20 mx-auto p-5 w-96">
        <div class="bg-slate-800 border border-red-500/30 rounded-2xl shadow-2xl p-6">
            <div class="flex items-center justify-center mb-6">
                <div class="w-16 h-16 bg-red-500/20 rounded-full flex items-center justify-center">
                    <i class="fas fa-exclamation-triangle text-red-400 text-3xl"></i>
                </div>
            </div>
            <h3 class="text-xl font-bold text-white text-center mb-2">Delete Medical Note</h3>
            <p class="text-white/70 text-center mb-4">
                Delete medical note for appointment <span id="deleteAppointmentNumber" class="font-semibold text-red-400"></span>?
                <br><span class="text-red-400 text-sm">This action cannot be undone!</span>
            </p>

            <form id="deleteForm" method="get" action="${pageContext.request.contextPath}/dashboard/medicalNotes">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" id="deleteNoteId" name="id">
                <div class="flex gap-3">
                    <button type="button" onclick="closeDeleteModal()"
                            class="flex-1 py-3 bg-white/10 hover:bg-white/20 text-white rounded-lg font-semibold transition">
                        <i class="fas fa-times mr-2"></i>Cancel
                    </button>
                    <button type="submit"
                            class="flex-1 py-3 bg-gradient-to-r from-red-600 to-red-700 hover:from-red-700 hover:to-red-800 text-white rounded-lg font-semibold transition">
                        <i class="fas fa-trash mr-2"></i>Delete
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#notesTableBody tr');

            tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                if (text.includes(searchValue)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }

    function confirmDelete(noteId, appointmentNumber) {
        document.getElementById('deleteNoteId').value = noteId;
        document.getElementById('deleteAppointmentNumber').textContent = '#' + appointmentNumber;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    // Close modal when clicking outside
    document.getElementById('deleteModal')?.addEventListener('click', function(e) {
        if (e.target === this) {
            closeDeleteModal();
        }
    });
</script>

</body>
</html>