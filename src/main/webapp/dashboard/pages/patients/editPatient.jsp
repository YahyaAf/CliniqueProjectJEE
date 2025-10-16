<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Patient - MediCare+</title>
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
<c:set var="currentPage" value="patients" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-3xl font-bold text-white mb-2">
            <i class="fas fa-user-edit mr-2"></i>Modifier Patient
        </h1>
        <p class="text-white/70">Mettre à jour les informations du patient</p>
    </div>

    <!-- Edit Patient Form -->
    <div class="bg-slate-800/40 backdrop-blur-lg border border-white/10 rounded-2xl shadow-xl p-8 max-w-5xl">

        <!-- Display validation errors -->
        <c:if test="${not empty errors}">
            <div class="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
                <div class="flex items-start gap-3">
                    <i class="fas fa-exclamation-circle text-red-500 text-lg mt-0.5"></i>
                    <div>
                        <p class="font-semibold text-red-800 mb-2">Erreurs de validation:</p>
                        <ul class="space-y-1 text-sm text-red-700">
                            <c:forEach var="error" items="${errors}">
                                <li>• ${error}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/update-patient" method="post">
            <input type="hidden" name="id" value="${patient.id}" />

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <!-- Full Name -->
                <div>
                    <label for="fullName" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-user mr-2"></i>Nom Complet
                    </label>
                    <input type="text"
                           id="fullName"
                           name="fullName"
                           value="${patient.fullName}"
                           placeholder="Entrer le nom complet"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-envelope mr-2"></i>Email
                    </label>
                    <input type="email"
                           id="email"
                           name="email"
                           value="${patient.email}"
                           placeholder="Entrer l'email"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Password -->
                <div>
                    <label for="password" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-lock mr-2"></i>Mot de passe
                    </label>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Laisser vide si inchangé"
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                    <p class="text-xs text-white/50 mt-1">
                        <i class="fas fa-info-circle"></i> Laisser vide pour conserver le mot de passe actuel
                    </p>
                </div>

                <!-- CIN -->
                <div>
                    <label for="cin" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-id-card mr-2"></i>CIN
                    </label>
                    <input type="text"
                           id="cin"
                           name="cin"
                           value="${patient.cin}"
                           placeholder="Entrer le CIN"
                           required
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Date of Birth -->
                <div>
                    <label for="dateOfBirth" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-calendar mr-2"></i>Date de naissance
                    </label>
                    <input type="date"
                           id="dateOfBirth"
                           name="dateOfBirth"
                           value="${patient.dateOfBirth}"
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

                <!-- Gender -->
                <div>
                    <label for="gender" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-venus-mars mr-2"></i>Genre
                    </label>
                    <select id="gender"
                            name="gender"
                            required
                            class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white">
                        <option value="" class="bg-slate-800">-- Choisir un genre --</option>
                        <option value="MALE" class="bg-slate-800" <c:if test="${patient.gender == 'MALE'}">selected</c:if>>Homme</option>
                        <option value="FEMALE" class="bg-slate-800" <c:if test="${patient.gender == 'FEMALE'}">selected</c:if>>Femme</option>
                        <option value="OTHER" class="bg-slate-800" <c:if test="${patient.gender == 'OTHER'}">selected</c:if>>Autre</option>
                    </select>
                </div>

                <!-- Blood Type -->
                <div>
                    <label for="bloodType" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-tint mr-2"></i>Type de sang
                    </label>
                    <select id="bloodType"
                            name="bloodType"
                            required
                            class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white">
                        <option value="" class="bg-slate-800">-- Choisir un type sanguin --</option>
                        <option value="A_POSITIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'A_POSITIVE'}">selected</c:if>>A+</option>
                        <option value="A_NEGATIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'A_NEGATIVE'}">selected</c:if>>A-</option>
                        <option value="B_POSITIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'B_POSITIVE'}">selected</c:if>>B+</option>
                        <option value="B_NEGATIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'B_NEGATIVE'}">selected</c:if>>B-</option>
                        <option value="AB_POSITIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'AB_POSITIVE'}">selected</c:if>>AB+</option>
                        <option value="AB_NEGATIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'AB_NEGATIVE'}">selected</c:if>>AB-</option>
                        <option value="O_POSITIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'O_POSITIVE'}">selected</c:if>>O+</option>
                        <option value="O_NEGATIVE" class="bg-slate-800" <c:if test="${patient.bloodType == 'O_NEGATIVE'}">selected</c:if>>O-</option>
                    </select>
                </div>

                <!-- Insurance Number -->
                <div>
                    <label for="insuranceNumber" class="block text-sm font-medium text-white/90 mb-2">
                        <i class="fas fa-id-badge mr-2"></i>Numéro d'assurance
                    </label>
                    <input type="text"
                           id="insuranceNumber"
                           name="insuranceNumber"
                           value="${patient.insuranceNumber}"
                           placeholder="Entrer le numéro d'assurance"
                           class="w-full px-4 py-2.5 bg-white/10 border border-white/20 rounded-lg focus:ring-2 focus:ring-indigo-400 focus:border-indigo-400 outline-none transition text-white placeholder-white/50">
                </div>

            </div>

            <!-- Form Actions -->
            <div class="flex items-center justify-end gap-4 mt-8 pt-6 border-t border-white/10">
                <a href="${pageContext.request.contextPath}/admin/patients"
                   class="px-6 py-2.5 border border-white/20 text-white/90 rounded-lg hover:bg-white/5 font-medium transition inline-flex items-center gap-2">
                    <i class="fas fa-times"></i>
                    Annuler
                </a>

                <button type="submit"
                        class="px-6 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg font-medium transition shadow-lg shadow-indigo-600/30 inline-flex items-center gap-2">
                    <i class="fas fa-save"></i>
                    Enregistrer les modifications
                </button>
            </div>

        </form>
    </div>
</main>

<!-- Form Enhancement Script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const inputs = form.querySelectorAll('input[required], select[required]');

        // Add real-time validation feedback
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (!this.value.trim() && this.hasAttribute('required')) {
                    this.classList.add('border-red-400');
                    this.classList.remove('border-white/20');
                } else {
                    this.classList.remove('border-red-400');
                    this.classList.add('border-white/20');
                }
            });
        });

        // Format blood type display
        const bloodTypeSelect = document.getElementById('bloodType');
        if (bloodTypeSelect) {
            bloodTypeSelect.addEventListener('change', function() {
                console.log('Blood type selected:', this.value);
            });
        }

        // Date picker enhancement
        const dateInput = document.getElementById('dateOfBirth');
        if (dateInput) {
            // Set max date to today
            const today = new Date().toISOString().split('T')[0];
            dateInput.setAttribute('max', today);
        }
    });
</script>

</body>
</html>