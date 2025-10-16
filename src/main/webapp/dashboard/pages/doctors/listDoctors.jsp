<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctors - MediCare+</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#667eea',
                        secondary: '#764ba2',
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

        /* Custom Scrollbar for Table */
        .table-scroll {
            max-height: calc(100vh - 320px);
            overflow-y: auto;
            overflow-x: auto;
        }

        .table-scroll::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        .table-scroll::-webkit-scrollbar-track {
            background: rgba(15, 23, 42, 0.3);
            border-radius: 10px;
        }

        .table-scroll::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            border: 2px solid rgba(15, 23, 42, 0.3);
        }

        .table-scroll::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }

        /* Firefox Scrollbar */
        .table-scroll {
            scrollbar-width: thin;
            scrollbar-color: #667eea rgba(15, 23, 42, 0.3);
        }

        /* Sticky Header */
        .sticky-header {
            position: sticky;
            top: 0;
            z-index: 10;
            background: rgba(51, 65, 85, 0.95);
            backdrop-filter: blur(12px);
        }

        /* Smooth Scroll */
        .table-scroll {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body class="gradient-bg min-h-screen">

<!-- Active page for sidebar -->
<c:set var="currentPage" value="doctors" scope="request"/>

<!-- Include Sidebar -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Doctors Management</h1>
        <p class="text-white/70">Manage all medical doctors and their information</p>
    </div>

    <!-- Stats Card -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6 max-w-xs">
        <div class="flex items-center gap-4">
            <div class="w-14 h-14 bg-blue-500/20 rounded-xl flex items-center justify-center">
                <i class="fas fa-user-md text-blue-400 text-2xl"></i>
            </div>
            <div>
                <p class="text-white/60 text-sm">Total Doctors</p>
                <p class="text-3xl font-bold text-white">${count}</p>
            </div>
        </div>
    </div>

    <!-- Doctors Table -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden">

        <!-- Table Header -->
        <div class="p-6 border-b border-white/10">
            <div class="flex items-center justify-between">
                <h2 class="text-xl font-bold text-white">Liste des Docteurs</h2>
                <div class="flex items-center gap-3">
                    <div class="relative">
                        <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-white/40"></i>
                        <input type="text"
                               id="searchInput"
                               placeholder="Search doctors..."
                               class="pl-10 pr-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/50 focus:ring-2 focus:ring-primary focus:border-primary outline-none transition">
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/register-doctor"
                       class="px-4 py-2 bg-gradient-to-r from-primary to-secondary hover:shadow-lg hover:shadow-primary/50 text-white rounded-lg font-medium transition flex items-center gap-2">
                        <i class="fas fa-plus"></i>
                        Add Doctor
                    </a>
                </div>
            </div>
        </div>

        <!-- Table Content -->
        <c:if test="${empty doctors}">
            <div class="p-12 text-center">
                <div class="w-20 h-20 bg-slate-700/50 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-user-md text-slate-500 text-3xl"></i>
                </div>
                <p class="text-white/60 text-lg">Aucun docteur trouvé.</p>
                <a href="${pageContext.request.contextPath}/admin/register-doctor"
                   class="inline-block mt-4 px-6 py-2 bg-gradient-to-r from-primary to-secondary text-white rounded-lg font-medium transition hover:shadow-lg">
                    Ajouter le premier docteur
                </a>
            </div>
        </c:if>

        <c:if test="${not empty doctors}">
            <div class="table-scroll">
                <table class="w-full">
                    <thead class="sticky-header">
                    <tr class="border-b border-white/10">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 w-16">#</th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[200px]">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-user text-primary"></i>
                                Full Name
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[220px]">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-envelope text-primary"></i>
                                Email
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[140px]">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-id-card text-primary"></i>
                                Matricule
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[180px]">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-stethoscope text-primary"></i>
                                Specialité
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[180px]">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-building text-primary"></i>
                                Department
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[120px]">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-toggle-on text-primary"></i>
                                Status
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 min-w-[100px]">Actions</th>
                    </tr>
                    </thead>
                    <tbody id="doctorTableBody">
                    <c:forEach var="doc" items="${doctors}" varStatus="status">
                        <tr class="border-b border-white/5 hover:bg-white/5 transition-colors">
                            <td class="px-6 py-4 text-white/70 font-medium">
                                    ${status.index + 1}
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-gradient-to-br from-blue-500 to-cyan-600 rounded-xl flex items-center justify-center text-white font-semibold text-sm flex-shrink-0">
                                            ${doc.fullName.substring(0,1).toUpperCase()}
                                    </div>
                                    <span class="text-white font-medium whitespace-nowrap">${doc.fullName}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2 text-white/70">
                                    <i class="fas fa-envelope text-xs text-white/40"></i>
                                    <span class="whitespace-nowrap">${doc.email}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-slate-700/50 text-white/80 text-sm font-mono whitespace-nowrap">
                                    <i class="fas fa-hashtag text-xs"></i>
                                    ${doc.matricule}
                                </span>
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${not empty doc.specialiteName}">
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-teal-500/20 text-teal-300 border border-teal-500/30 text-sm font-medium whitespace-nowrap">
                                            <i class="fas fa-stethoscope text-xs"></i>
                                            ${doc.specialiteName}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-white/40 italic whitespace-nowrap">Non défini</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${not empty doc.departmentName}">
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-purple-500/20 text-purple-300 border border-purple-500/30 text-sm font-medium whitespace-nowrap">
                                            <i class="fas fa-hospital-alt text-xs"></i>
                                            ${doc.departmentName}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-white/40 italic whitespace-nowrap">Non assigné</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${doc.isActive}">
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-green-500/20 text-green-300 border border-green-500/30 text-sm font-medium whitespace-nowrap">
                                            <i class="fas fa-check-circle"></i>
                                            Active
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-red-500/20 text-red-300 border border-red-500/30 text-sm font-medium whitespace-nowrap">
                                            <i class="fas fa-times-circle"></i>
                                            Inactive
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/update-doctor?id=${doc.id}"
                                       class="w-8 h-8 bg-amber-500/20 hover:bg-amber-500/30 text-amber-300 rounded-lg transition flex items-center justify-center flex-shrink-0"
                                       title="Edit Doctor">
                                        <i class="fas fa-edit text-sm"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/delete-doctor?id=${doc.id}"
                                       onclick="return confirm('Supprimer ce docteur ?');"
                                       class="w-8 h-8 bg-red-500/20 hover:bg-red-500/30 text-red-300 rounded-lg transition flex items-center justify-center flex-shrink-0"
                                       title="Delete Doctor">
                                        <i class="fas fa-trash text-sm"></i>
                                    </a>
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

<script>
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#doctorTableBody tr');

            tableRows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchValue) ? '' : 'none';
            });
        });
    }
</script>

</body>
</html>