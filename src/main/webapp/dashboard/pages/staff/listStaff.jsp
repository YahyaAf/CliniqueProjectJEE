<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Management - MediCare+</title>
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
<c:set var="currentPage" value="settings" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Staff Management</h1>
        <p class="text-white/70">View and manage all staff members</p>
    </div>

    <!-- Stats Card -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6 max-w-xs">
        <div class="flex items-center gap-4">
            <div class="w-14 h-14 bg-cyan-500/20 rounded-xl flex items-center justify-center">
                <i class="fas fa-user-tie text-cyan-400 text-2xl"></i>
            </div>
            <div>
                <p class="text-white/60 text-sm">Total Staff</p>
                <p class="text-3xl font-bold text-white">${count}</p>
            </div>
        </div>
    </div>

    <!-- Staff Table -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden">

        <!-- Table Header -->
        <div class="p-6 border-b border-white/10">
            <div class="flex items-center justify-between">
                <h2 class="text-xl font-bold text-white">Staff List</h2>
                <div class="flex items-center gap-3">
                    <div class="relative">
                        <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-white/40"></i>
                        <input type="text"
                               id="searchInput"
                               placeholder="Search staff..."
                               class="pl-10 pr-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/50 focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition">
                    </div>
                    <a href="${pageContext.request.contextPath}/dashboard/pages/staff/registerStaff.jsp"
                       class="px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-medium transition shadow-lg shadow-indigo-600/30 flex items-center gap-2">
                        <i class="fas fa-plus"></i>
                        Add Staff
                    </a>
                </div>
            </div>
        </div>

        <!-- Table Content -->
        <c:if test="${empty staff}">
            <div class="p-12 text-center">
                <div class="w-20 h-20 bg-slate-700/50 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-user-tie text-slate-500 text-3xl"></i>
                </div>
                <p class="text-white/60 text-lg">No staff found.</p>
                <a href="${pageContext.request.contextPath}/admin/register-staff"
                   class="inline-block mt-4 px-6 py-2 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-medium transition">
                    Add First Staff Member
                </a>
            </div>
        </c:if>

        <c:if test="${not empty staff}">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                    <tr class="bg-slate-700/30 border-b border-white/10">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90 w-16">
                            #
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-user text-indigo-400"></i>
                                Full Name
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-envelope text-indigo-400"></i>
                                Email
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-briefcase text-indigo-400"></i>
                                Position
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-toggle-on text-indigo-400"></i>
                                Status
                            </div>
                        </th>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                            Actions
                        </th>
                    </tr>
                    </thead>
                    <tbody id="staffTableBody">
                    <c:forEach var="st" items="${staff}" varStatus="status">
                        <tr class="border-b border-white/5 hover:bg-white/5 transition-colors">
                            <td class="px-6 py-4 text-white/70 font-medium">
                                    ${status.index + 1}
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-10 h-10 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-full flex items-center justify-center text-white font-semibold">
                                            ${st.fullName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <span class="text-white font-medium">${st.fullName}</span>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-white/70">
                                    ${st.email}
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${not empty st.position}">
                                    <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg bg-indigo-500/20 text-indigo-300 border border-indigo-500/30 text-sm font-medium">
                                        <i class="fas fa-id-badge"></i>
                                        ${st.position}
                                    </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-white/40 italic">No position</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <c:choose>
                                    <c:when test="${st.isActive}">
                                    <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg border bg-green-500/20 text-green-300 border-green-500/30 text-sm font-medium">
                                        <i class="fas fa-check-circle"></i>
                                        Active
                                    </span>
                                    </c:when>
                                    <c:otherwise>
                                    <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg border bg-red-500/20 text-red-300 border-red-500/30 text-sm font-medium">
                                        <i class="fas fa-times-circle"></i>
                                        Inactive
                                    </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/update-staff?id=${st.id}"
                                       class="w-8 h-8 bg-amber-500/20 hover:bg-amber-500/30 text-amber-300 rounded-lg transition flex items-center justify-center"
                                       title="Edit Staff">
                                        <i class="fas fa-edit text-sm"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/delete-staff?id=${st.id}"
                                       onclick="return confirm('Are you sure you want to delete this staff?');"
                                       class="w-8 h-8 bg-red-500/20 hover:bg-red-500/30 text-red-300 rounded-lg transition flex items-center justify-center"
                                       title="Delete Staff">
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
    // Simple search functionality
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const searchValue = this.value.toLowerCase();
            const tableRows = document.querySelectorAll('#staffTableBody tr');

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
</script>

</body>
</html>