<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.clinique.dto.UserListDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users List - MediCare+</title>
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

<%
    Object usersObj = request.getAttribute("users");
    List<UserListDTO> users = null;
    if (usersObj instanceof List<?>) {
        users = (List<UserListDTO>) usersObj;
    }

    int usersCount = 0;
    Object countObj = request.getAttribute("usersCount");
    if (countObj instanceof Integer) {
        usersCount = (Integer) countObj;
    }
%>

<!-- Définir la page active pour la sidebar -->
<c:set var="currentPage" value="settings" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Users Management</h1>
        <p class="text-white/70">View and manage all registered users</p>
    </div>

    <!-- Stats Card -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-6 mb-6 max-w-xs">
        <div class="flex items-center gap-4">
            <div class="w-14 h-14 bg-indigo-500/20 rounded-xl flex items-center justify-center">
                <i class="fas fa-users text-indigo-400 text-2xl"></i>
            </div>
            <div>
                <p class="text-white/60 text-sm">Total Users</p>
                <p class="text-3xl font-bold text-white"><%= usersCount %></p>
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden">
        <!-- Table Content -->
        <% if (users == null || users.isEmpty()) { %>
        <div class="p-12 text-center">
            <div class="w-20 h-20 bg-slate-700/50 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-users text-slate-500 text-3xl"></i>
            </div>
            <p class="text-white/60 text-lg">No users found.</p>
        </div>
        <% } else { %>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="bg-slate-700/30 border-b border-white/10">
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
                            <i class="fas fa-shield-alt text-indigo-400"></i>
                            Role
                        </div>
                    </th>
                    <th class="px-6 py-4 text-left text-sm font-semibold text-white/90">
                        Actions
                    </th>
                </tr>
                </thead>
                <tbody id="userTableBody">
                <% for (UserListDTO user : users) { %>
                <tr class="border-b border-white/5 hover:bg-white/5 transition-colors">
                    <td class="px-6 py-4">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-full flex items-center justify-center text-white font-semibold">
                                <%= user.getFullName().substring(0, 1).toUpperCase() %>
                            </div>
                            <span class="text-white font-medium"><%= user.getFullName() %></span>
                        </div>
                    </td>
                    <td class="px-6 py-4 text-white/70">
                        <%= user.getEmail() %>
                    </td>
                    <td class="px-6 py-4">
                        <%
                            String role = user.getRole();
                            String badgeClass = "";
                            String icon = "";

                            if ("ADMIN".equalsIgnoreCase(role)) {
                                badgeClass = "bg-red-500/20 text-red-300 border-red-500/30";
                                icon = "fa-crown";
                            } else if ("DOCTOR".equalsIgnoreCase(role)) {
                                badgeClass = "bg-blue-500/20 text-blue-300 border-blue-500/30";
                                icon = "fa-user-md";
                            } else if ("PATIENT".equalsIgnoreCase(role)) {
                                badgeClass = "bg-green-500/20 text-green-300 border-green-500/30";
                                icon = "fa-user";
                            } else {
                                badgeClass = "bg-slate-500/20 text-slate-300 border-slate-500/30";
                                icon = "fa-user";
                            }
                        %>
                        <span class="inline-flex items-center gap-2 px-3 py-1 rounded-lg border <%= badgeClass %> text-sm font-medium">
                                <i class="fas <%= icon %>"></i>
                                <%= role %>
                            </span>
                    </td>
                    <td class="px-6 py-4">
                        <div class="flex items-center gap-2">
                            <button class="w-8 h-8 bg-indigo-500/20 hover:bg-indigo-500/30 text-indigo-300 rounded-lg transition flex items-center justify-center" title="View Details">
                                <i class="fas fa-eye text-sm"></i>
                            </button>
                            <button class="w-8 h-8 bg-amber-500/20 hover:bg-amber-500/30 text-amber-300 rounded-lg transition flex items-center justify-center" title="Edit User">
                                <i class="fas fa-edit text-sm"></i>
                            </button>
                            <button class="w-8 h-8 bg-red-500/20 hover:bg-red-500/30 text-red-300 rounded-lg transition flex items-center justify-center" title="Delete User">
                                <i class="fas fa-trash text-sm"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
</main>

<script>
    // Simple search functionality
    document.getElementById('searchInput').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const tableRows = document.querySelectorAll('#userTableBody tr');

        tableRows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>

</body>
</html>