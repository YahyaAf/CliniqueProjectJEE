<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Doctor - MediCare+</title>
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
<c:set var="currentPage" value="doctors" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">Edit Doctor</h1>
        <p class="text-white/70">Update doctor information</p>
    </div>

    <!-- Edit Doctor Form -->
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

        <form action="${pageContext.request.contextPath}/admin/update-doctor" method="post">
            <input type="hidden" name="id" value="${doctor.id}" />

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <!-- Full Name -->
                <div>
                    <label for="fullName" class="block text-sm font-medium text-white/90 mb-2">
                        Full Name
                    </label>
                    <input type="text"
                           id="fullName"
                           name="fullName"
                           value="${doctor.fullName}"
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
                           value="${doctor.email}"
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
                           placeholder="Leave blank if unchanged"
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                    <p class="text-xs text-white/50 mt-1">
                        <i class="fas fa-info-circle"></i> Leave blank to keep current password
                    </p>
                </div>

                <!-- Matricule -->
                <div>
                    <label for="matricule" class="block text-sm font-medium text-white/90 mb-2">
                        Matricule
                    </label>
                    <input type="text"
                           id="matricule"
                           name="matricule"
                           value="${doctor.matricule}"
                           placeholder="Enter matricule"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Specialty -->
                <div class="md:col-span-2">
                    <label for="specialiteId" class="block text-sm font-medium text-white/90 mb-2">
                        Spécialité
                    </label>
                    <select id="specialiteId"
                            name="specialiteId"
                            required
                            class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white">
                        <option value="" class="bg-slate-800">-- Choisir une spécialité --</option>
                        <c:forEach var="spec" items="${specialites}">
                            <option value="${spec.id}"
                                    class="bg-slate-800"
                                    <c:if test="${doctor.specialiteName == spec.name}">selected</c:if>>
                                    ${spec.name} (${spec.departmentName})
                            </option>
                        </c:forEach>
                    </select>
                </div>

            </div>

            <!-- Form Actions -->
            <div class="flex items-center justify-end gap-4 mt-8 pt-6 border-t border-white/10">
                <a href="${pageContext.request.contextPath}/admin/doctors"
                   class="px-6 py-2.5 border border-white/20 text-white/90 rounded-lg hover:bg-white/5 font-medium transition">
                    Cancel
                </a>

                <button type="submit"
                        class="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-medium transition shadow-lg shadow-indigo-600/30">
                    Update Doctor
                </button>
            </div>

        </form>
    </div>
</main>

</body>
</html>