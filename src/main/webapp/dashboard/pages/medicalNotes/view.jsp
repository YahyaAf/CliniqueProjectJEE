<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Medical Note - MediCare+</title>
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
        @media print {
            body { background: white; }
            .no-print { display: none !important; }
            .shadow-lg, .shadow-md { box-shadow: none !important; }
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
    <div class="mb-8 no-print">
        <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
           class="inline-flex items-center gap-2 text-white/80 hover:text-white font-medium mb-4 transition">
            <i class="fas fa-arrow-left"></i>
            Back to Medical Notes
        </a>
        <div class="flex justify-between items-start">
            <div>
                <h1 class="text-3xl font-bold text-white mb-2">Medical Note Details</h1>
                <p class="text-white/70">Complete medical record information</p>
            </div>
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=edit&id=${medicalNote.id}"
               class="px-4 py-2 bg-gradient-to-r from-emerald-600 to-green-600 hover:from-emerald-700 hover:to-green-700 text-white rounded-lg font-medium transition shadow-lg shadow-emerald-600/30 flex items-center gap-2">
                <i class="fas fa-edit"></i>
                Edit
            </a>
        </div>
    </div>

    <div class="max-w-5xl">
        <!-- Header Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden mb-6">
            <div class="bg-gradient-to-r from-purple-600 via-pink-600 to-purple-600 px-6 py-4">
                <div class="flex justify-between items-center text-white">
                    <div>
                        <h2 class="text-xl font-bold">Medical Note #${medicalNote.id}</h2>
                        <p class="text-sm text-purple-100 mt-1">
                            <i class="fas fa-calendar mr-2"></i>
                            Created: ${medicalNote.formattedCreatedAt}
                        </p>
                    </div>
                    <div class="text-right">
                        <p class="text-sm text-purple-100">Appointment</p>
                        <p class="text-2xl font-bold">#${medicalNote.appointmentNumber}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Appointment Information Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6">
            <h3 class="text-lg font-bold text-white mb-4 flex items-center gap-2">
                <i class="fas fa-info-circle text-blue-400"></i>
                Appointment Information
            </h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <!-- Patient -->
                <div class="bg-gradient-to-br from-blue-500/10 to-blue-600/10 border border-blue-500/30 rounded-xl p-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-blue-500/20 rounded-xl flex items-center justify-center">
                            <i class="fas fa-user text-blue-400 text-xl"></i>
                        </div>
                        <div>
                            <p class="text-xs text-white/60 uppercase">Patient</p>
                            <p class="text-base font-semibold text-white">${medicalNote.patientName}</p>
                        </div>
                    </div>
                </div>

                <!-- Doctor -->
                <div class="bg-gradient-to-br from-emerald-500/10 to-emerald-600/10 border border-emerald-500/30 rounded-xl p-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-emerald-500/20 rounded-xl flex items-center justify-center">
                            <i class="fas fa-user-md text-emerald-400 text-xl"></i>
                        </div>
                        <div>
                            <p class="text-xs text-white/60 uppercase">Doctor</p>
                            <p class="text-base font-semibold text-white">Dr. ${medicalNote.doctorName}</p>
                        </div>
                    </div>
                </div>

                <!-- Date -->
                <div class="bg-gradient-to-br from-purple-500/10 to-purple-600/10 border border-purple-500/30 rounded-xl p-4">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-purple-500/20 rounded-xl flex items-center justify-center">
                            <i class="fas fa-calendar-alt text-purple-400 text-xl"></i>
                        </div>
                        <div>
                            <p class="text-xs text-white/60 uppercase">Date</p>
                            <p class="text-base font-semibold text-white">${medicalNote.appointmentDate}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Medical Information Card -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6">
            <h3 class="text-lg font-bold text-white mb-6 flex items-center gap-2">
                <i class="fas fa-notes-medical text-red-400"></i>
                Medical Information
            </h3>

            <div class="space-y-4">
                <!-- Symptoms -->
                <div class="bg-red-500/10 border border-red-500/30 rounded-xl p-5">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-red-500/20 rounded-xl flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-heartbeat text-red-400 text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-base font-semibold text-red-300 mb-2 flex items-center gap-2">
                                Symptoms
                                <span class="text-[10px] bg-red-500/30 text-red-200 px-2 py-0.5 rounded-full">Required</span>
                            </h4>
                            <div class="text-white/90 whitespace-pre-wrap leading-relaxed text-sm">
                                ${medicalNote.symptoms}
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Prescription -->
                <div class="bg-emerald-500/10 border border-emerald-500/30 rounded-xl p-5">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-emerald-500/20 rounded-xl flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-pills text-emerald-400 text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-base font-semibold text-emerald-300 mb-2">Prescription</h4>
                            <c:choose>
                                <c:when test="${not empty medicalNote.prescription}">
                                    <div class="text-white/90 whitespace-pre-wrap leading-relaxed text-sm">
                                            ${medicalNote.prescription}
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-white/50 italic text-sm">No prescription provided</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Additional Notes -->
                <div class="bg-blue-500/10 border border-blue-500/30 rounded-xl p-5">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-blue-500/20 rounded-xl flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-sticky-note text-blue-400 text-xl"></i>
                        </div>
                        <div class="flex-1">
                            <h4 class="text-base font-semibold text-blue-300 mb-2">Additional Notes</h4>
                            <c:choose>
                                <c:when test="${not empty medicalNote.notes}">
                                    <div class="text-white/90 whitespace-pre-wrap leading-relaxed text-sm">
                                            ${medicalNote.notes}
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-white/50 italic text-sm">No additional notes</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Metadata Footer -->
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-4 mb-6">
            <div class="flex justify-between items-center text-sm text-white/70">
                <div class="flex items-center gap-2">
                    <i class="fas fa-clock"></i>
                    <span>Created: <span class="font-semibold text-white">${medicalNote.createdAt}</span></span>
                </div>
                <div class="flex items-center gap-2">
                    <i class="fas fa-fingerprint"></i>
                    <span>ID: <span class="font-mono font-semibold text-white">${medicalNote.id}</span></span>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex gap-3 mb-6 no-print">
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes?action=edit&id=${medicalNote.id}"
               class="flex-1 px-6 py-3 bg-gradient-to-r from-emerald-600 to-green-600 hover:from-emerald-700 hover:to-green-700 text-white rounded-lg font-semibold transition shadow-lg shadow-emerald-600/30 flex items-center justify-center gap-2">
                <i class="fas fa-edit"></i>
                Edit Medical Note
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/medicalNotes"
               class="flex-1 px-6 py-3 bg-white/10 hover:bg-white/20 border border-white/20 text-white rounded-lg font-semibold transition flex items-center justify-center gap-2">
                <i class="fas fa-list"></i>
                Back to List
            </a>
            <button onclick="confirmDelete()"
                    class="flex-1 px-6 py-3 bg-gradient-to-r from-red-600 to-red-700 hover:from-red-700 hover:to-red-800 text-white rounded-lg font-semibold transition shadow-lg shadow-red-600/30 flex items-center justify-center gap-2">
                <i class="fas fa-trash"></i>
                Delete
            </button>
        </div>

        <!-- Info Footer -->
        <div class="bg-blue-500/10 border border-blue-500/30 rounded-xl p-4 no-print">
            <div class="flex gap-3">
                <i class="fas fa-info-circle text-blue-400 text-lg mt-1"></i>
                <div>
                    <p class="text-sm font-semibold text-blue-300 mb-1">Medical Record Information</p>
                    <p class="text-sm text-blue-200/90">
                        This medical note is a confidential record of the patient's consultation.
                        All information should be kept secure and only shared with authorized medical personnel.
                    </p>
                </div>
            </div>
        </div>
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
            <p class="text-white/70 text-center mb-4 text-sm">
                Are you sure you want to delete this medical note?
                <br><span class="text-red-400 font-semibold">This action cannot be undone!</span>
            </p>

            <form method="get" action="${pageContext.request.contextPath}/dashboard/medicalNotes">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="${medicalNote.id}">
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
    function confirmDelete() {
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