<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Doctor - MediCare+</title>
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
        <div class="flex items-center gap-3 mb-4">
            <a href="${pageContext.request.contextPath}/admin/doctors"
               class="w-10 h-10 bg-white/10 hover:bg-white/20 rounded-lg flex items-center justify-center text-white transition">
                <i class="fas fa-arrow-left"></i>
            </a>
            <div>
                <h1 class="text-3xl font-bold text-white">Register New Doctor</h1>
                <p class="text-white/70">Add a new doctor to the system</p>
            </div>
        </div>
    </div>

    <!-- Registration Form Card -->
    <div class="max-w-4xl">
        <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl overflow-hidden">

            <!-- Card Header -->
            <div class="p-6 border-b border-white/10 bg-gradient-to-r from-primary/10 to-secondary/10">
                <div class="flex items-center gap-3">
                    <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-cyan-600 rounded-xl flex items-center justify-center">
                        <i class="fas fa-user-md text-white text-xl"></i>
                    </div>
                    <div>
                        <h2 class="text-xl font-bold text-white">Doctor Information</h2>
                        <p class="text-white/60 text-sm">Fill in the details below</p>
                    </div>
                </div>
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty errors}">
                <div class="m-6 bg-red-500/10 border border-red-500/30 rounded-xl p-4">
                    <div class="flex items-start gap-3">
                        <div class="w-8 h-8 bg-red-500/20 rounded-lg flex items-center justify-center flex-shrink-0">
                            <i class="fas fa-exclamation-circle text-red-400"></i>
                        </div>
                        <div class="flex-1">
                            <h3 class="text-red-300 font-semibold mb-2">Please fix the following errors:</h3>
                            <ul class="space-y-1">
                                <c:forEach var="error" items="${errors}">
                                    <li class="text-red-300 text-sm flex items-center gap-2">
                                        <i class="fas fa-circle text-xs"></i>
                                            ${error}
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/admin/register-doctor" method="post" class="p-6">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                    <!-- Full Name -->
                    <div class="md:col-span-2">
                        <label for="fullName" class="block text-white/90 font-medium mb-2">
                            <i class="fas fa-user text-primary mr-2"></i>
                            Full Name <span class="text-red-400">*</span>
                        </label>
                        <input type="text"
                               id="fullName"
                               name="fullName"
                               required
                               value="${param.fullName}"
                               placeholder="Enter doctor's full name"
                               class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:ring-2 focus:ring-primary focus:border-primary outline-none transition">
                    </div>

                    <!-- Email -->
                    <div>
                        <label for="email" class="block text-white/90 font-medium mb-2">
                            <i class="fas fa-envelope text-primary mr-2"></i>
                            Email Address <span class="text-red-400">*</span>
                        </label>
                        <input type="email"
                               id="email"
                               name="email"
                               required
                               value="${param.email}"
                               placeholder="doctor@example.com"
                               class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:ring-2 focus:ring-primary focus:border-primary outline-none transition">
                    </div>

                    <!-- Password -->
                    <div>
                        <label for="password" class="block text-white/90 font-medium mb-2">
                            <i class="fas fa-lock text-primary mr-2"></i>
                            Password <span class="text-red-400">*</span>
                        </label>
                        <div class="relative">
                            <input type="password"
                                   id="password"
                                   name="password"
                                   required
                                   placeholder="Enter secure password"
                                   class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:ring-2 focus:ring-primary focus:border-primary outline-none transition">
                            <button type="button"
                                    onclick="togglePassword()"
                                    class="absolute right-3 top-1/2 -translate-y-1/2 text-white/50 hover:text-white transition">
                                <i class="fas fa-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Matricule -->
                    <div>
                        <label for="matricule" class="block text-white/90 font-medium mb-2">
                            <i class="fas fa-id-card text-primary mr-2"></i>
                            Matricule <span class="text-red-400">*</span>
                        </label>
                        <input type="text"
                               id="matricule"
                               name="matricule"
                               required
                               value="${param.matricule}"
                               placeholder="e.g., DOC-12345"
                               class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:ring-2 focus:ring-primary focus:border-primary outline-none transition">
                    </div>

                    <!-- Specialite -->
                    <div>
                        <label for="specialite" class="block text-white/90 font-medium mb-2">
                            <i class="fas fa-stethoscope text-primary mr-2"></i>
                            Specialité <span class="text-red-400">*</span>
                        </label>
                        <select id="specialite"
                                name="specialiteId"
                                required
                                class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white focus:ring-2 focus:ring-primary focus:border-primary outline-none transition appearance-none cursor-pointer">
                            <option value="" class="bg-slate-800">-- Choose a Specialité --</option>
                            <c:forEach var="s" items="${specialites}">
                                <option value="${s.id}"
                                        class="bg-slate-800"
                                        <c:if test="${param.specialiteId == s.id}">selected</c:if>>
                                        ${s.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                </div>

                <!-- Action Buttons -->
                <div class="flex items-center justify-end gap-4 mt-8 pt-6 border-t border-white/10">
                    <a href="${pageContext.request.contextPath}/admin/doctors"
                       class="px-6 py-3 bg-white/10 hover:bg-white/20 text-white rounded-xl font-medium transition flex items-center gap-2">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                    <button type="submit"
                            class="px-6 py-3 bg-gradient-to-r from-primary to-secondary hover:shadow-lg hover:shadow-primary/50 text-white rounded-xl font-medium transition flex items-center gap-2">
                        <i class="fas fa-user-plus"></i>
                        Register Doctor
                    </button>
                </div>

            </form>

        </div>
    </div>

</main>

<script>
    // Toggle password visibility
    function togglePassword() {
        const passwordInput = document.getElementById('password');
        const toggleIcon = document.getElementById('toggleIcon');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
        }
    }

    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const matricule = document.getElementById('matricule').value;

        if (password.length < 8) {
            e.preventDefault();
            alert('Password must be at least 8 characters long');
            return false;
        }

        if (!matricule.match(/^DOC-\d+$/)) {
            const confirm = window.confirm('Matricule format should be DOC-XXXXX. Continue anyway?');
            if (!confirm) {
                e.preventDefault();
                return false;
            }
        }
    });
</script>

</body>
</html>