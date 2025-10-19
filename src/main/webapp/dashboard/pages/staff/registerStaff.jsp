<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.currentUser}">
    <c:redirect url="/pages/auth/login.jsp"/>
</c:if>

<c:if test="${sessionScope.currentUser.role != 'ADMIN'}">
    <c:redirect url="/"/>
</c:if>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Staff - MediCare+</title>
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
        <h1 class="text-3xl font-bold text-white mb-2">Register New Staff</h1>
        <p class="text-white/70">Add a new member to your medical team</p>
    </div>

    <!-- Registration Form -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-8 max-w-5xl">

        <!-- Display validation errors -->
        <c:if test="${not empty errors}">
            <div class="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
                <div class="flex items-start gap-3">
                    <i class="fas fa-exclamation-circle text-red-500 text-lg mt-0.5"></i>
                    <div>
                        <p class="font-semibold text-red-800 mb-2">Validation Errors:</p>
                        <ul class="space-y-1 text-sm text-red-700">
                            <c:forEach var="error" items="${errors}">
                                <li>• ${error}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/register-staff" method="post">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <!-- Full Name -->
                <div>
                    <label for="fullName" class="block text-sm font-medium text-white/90 mb-2">
                        Full Name
                    </label>
                    <input type="text"
                           id="fullName"
                           name="fullName"
                           placeholder="Enter full name"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-medium text-white/90 mb-2">
                        Email
                    </label>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="Enter email"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Password -->
                <div>
                    <label for="password" class="block text-sm font-medium text-white/90 mb-2">
                        Password
                    </label>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter password"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Position -->
                <div>
                    <label for="position" class="block text-sm font-medium text-white/90 mb-2">
                        Position
                    </label>
                    <input type="text"
                           id="position"
                           name="position"
                           placeholder="Enter staff position"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

            </div>

            <!-- Form Actions -->
            <div class="flex items-center justify-end gap-4 mt-8 pt-6 border-t">
                <a href="${pageContext.request.contextPath}/admin/staff"
                   class="px-6 py-2.5 border border-slate-300 text-slate-700 rounded-lg hover:bg-slate-50 font-medium transition">
                    Cancel
                </a>

                <button type="submit"
                        class="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-medium transition">
                    Register Staff
                </button>
            </div>

        </form>
    </div>
</main>

</body>
</html>