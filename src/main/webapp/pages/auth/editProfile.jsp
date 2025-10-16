<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier Mon Profil - Clinique Digitale</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <jsp:include page="/pages/components/styles.jsp" />
    <style>
        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 15px rgba(20, 184, 166, 0.2); }
            50% { box-shadow: 0 0 25px rgba(20, 184, 166, 0.4); }
        }

        @keyframes slide-up {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .glow-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
        }

        .slide-up {
            animation: slide-up 0.6s ease-out forwards;
        }

        .glass-effect {
            background: rgba(17, 24, 39, 0.5);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(75, 85, 99, 0.3);
        }

        .mesh-gradient {
            background:
                    radial-gradient(at 27% 37%, hsla(200, 70%, 50%, 0.15) 0px, transparent 50%),
                    radial-gradient(at 97% 21%, hsla(180, 60%, 45%, 0.12) 0px, transparent 50%),
                    radial-gradient(at 52% 99%, hsla(220, 50%, 40%, 0.1) 0px, transparent 50%);
        }

        .input-field {
            background: rgba(31, 41, 55, 0.6);
            border: 1px solid rgba(75, 85, 99, 0.5);
            transition: all 0.3s ease;
        }

        .input-field:focus {
            background: rgba(31, 41, 55, 0.8);
            border-color: #14b8a6;
            box-shadow: 0 0 0 3px rgba(20, 184, 166, 0.15);
            outline: none;
        }

        .input-field:hover {
            border-color: rgba(75, 85, 99, 0.8);
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-black text-gray-100 overflow-x-hidden">

<!-- Animated Background -->
<div class="fixed inset-0 mesh-gradient opacity-30 pointer-events-none"></div>

<jsp:include page="/pages/components/navbar.jsp" />

<!-- Main Content -->
<section class="relative container mx-auto px-6 py-16">
    <div class="max-w-5xl mx-auto">

        <!-- Compact Header -->
        <div class="text-center mb-8 slide-up">
            <h1 class="text-3xl md:text-4xl font-bold mb-2">
                Modifier Mon
                <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Profil</span>
            </h1>
            <p class="text-gray-400">Mettez à jour vos informations</p>
        </div>

        <!-- Error Messages Compact -->
        <c:if test="${not empty errors}">
            <div class="glass-effect rounded-xl p-4 mb-6 border-l-4 border-red-500 slide-up">
                <div class="flex items-start space-x-2">
                    <svg class="w-5 h-5 text-red-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <div class="flex-1">
                        <h3 class="text-red-400 font-semibold text-sm mb-1">Erreurs de validation</h3>
                        <ul class="space-y-0.5">
                            <c:forEach var="error" items="${errors}">
                                <li class="text-gray-300 text-xs">• ${error}</li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Compact Form Container -->
        <div class="glass-effect rounded-2xl p-6 md:p-8 slide-up">
            <form action="${pageContext.request.contextPath}/patient/update-profile" method="post">
                <input type="hidden" name="id" value="${patient.id}" />

                <!-- Single Grid Layout - 3 Columns -->
                <div class="grid md:grid-cols-3 gap-4 mb-6">

                    <!-- Row 1 -->
                    <div class="md:col-span-2">
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            Nom complet <span class="text-red-400">*</span>
                        </label>
                        <input type="text" name="fullName" value="${patient.fullName}" required
                               class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm"
                               placeholder="Votre nom complet" />
                    </div>

                    <div>
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            CIN <span class="text-red-400">*</span>
                        </label>
                        <input type="text" name="cin" value="${patient.cin}" required
                               class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm"
                               placeholder="AB123456" />
                    </div>

                    <!-- Row 2 -->
                    <div class="md:col-span-2">
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            Email <span class="text-red-400">*</span>
                        </label>
                        <input type="email" name="email" value="${patient.email}" required
                               class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm"
                               placeholder="votre@email.com" />
                    </div>

                    <div>
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            Date de naissance
                        </label>
                        <input type="date" name="dateOfBirth" value="${patient.dateOfBirth}"
                               class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm" />
                    </div>

                    <!-- Row 3 -->
                    <div>
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            Genre <span class="text-red-400">*</span>
                        </label>
                        <select name="gender" required
                                class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm">
                            <option value="">Choisir</option>
                            <option value="MALE" <c:if test="${patient.gender == 'MALE'}">selected</c:if>>👨 Homme</option>
                            <option value="FEMALE" <c:if test="${patient.gender == 'FEMALE'}">selected</c:if>>👩 Femme</option>
                            <option value="OTHER" <c:if test="${patient.gender == 'OTHER'}">selected</c:if>>⚧ Autre</option>
                        </select>
                    </div>

                    <div>
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            Type de sang <span class="text-red-400">*</span>
                        </label>
                        <select name="bloodType" required
                                class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm">
                            <option value="">Choisir</option>
                            <c:forEach var="type" items="${['A_POSITIVE','A_NEGATIVE','B_POSITIVE','B_NEGATIVE','AB_POSITIVE','AB_NEGATIVE','O_POSITIVE','O_NEGATIVE']}">
                                <option value="${type}" <c:if test="${patient.bloodType == type}">selected</c:if>>
                                    🩸 ${type.replace('_POSITIVE', '+').replace('_NEGATIVE', '-').replace('_', ' ')}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            Numéro d'assurance
                        </label>
                        <input type="text" name="insuranceNumber" value="${patient.insuranceNumber}"
                               class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm"
                               placeholder="123456789" />
                    </div>

                    <!-- Row 4 - Password full width -->
                    <div class="md:col-span-3">
                        <label class="block text-gray-300 text-sm font-medium mb-1.5">
                            🔒 Mot de passe <span class="text-gray-500 text-xs">(Laissez vide si inchangé)</span>
                        </label>
                        <input type="password" name="password"
                               class="w-full px-3 py-2.5 rounded-lg input-field text-white text-sm"
                               placeholder="••••••••" />
                    </div>
                </div>

                <!-- Compact Action Buttons -->
                <div class="flex gap-3 pt-4 border-t border-gray-700">
                    <button type="submit"
                            class="flex-1 px-6 py-3 bg-gradient-to-r from-teal-600 to-teal-700 rounded-xl font-semibold text-sm hover:shadow-xl hover:shadow-teal-600/30 transition-all duration-300 flex items-center justify-center space-x-2 glow-pulse">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                        <span>Enregistrer</span>
                    </button>

                    <a href="${pageContext.request.contextPath}"
                       class="flex-1 px-6 py-3 border-2 border-gray-600 rounded-xl font-semibold text-sm hover:bg-gray-800 transition-all duration-300 flex items-center justify-center space-x-2">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                        <span>Annuler</span>
                    </a>
                </div>

                <!-- Compact Info -->
                <div class="flex items-center space-x-2 mt-4 p-3 bg-teal-900/20 rounded-lg border border-teal-800/30">
                    <svg class="w-4 h-4 text-teal-400 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                    </svg>
                    <p class="text-gray-400 text-xs">Vos données sont sécurisées et cryptées</p>
                </div>
            </form>
        </div>

    </div>
</section>

<!-- Footer -->
<jsp:include page="/pages/components/footer.jsp" />

</body>
</html>