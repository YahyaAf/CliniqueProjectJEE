<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - MediCare+</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <jsp:include page="/pages/components/styles.jsp" />
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 20px rgba(20, 184, 166, 0.3); }
            50% { box-shadow: 0 0 40px rgba(20, 184, 166, 0.5); }
        }

        @keyframes slide-up {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .float-animation {
            animation: float 4s ease-in-out infinite;
        }

        .glow-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
        }

        .slide-up {
            animation: slide-up 0.8s ease-out forwards;
        }

        .glass-effect {
            background: rgba(17, 24, 39, 0.4);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(75, 85, 99, 0.3);
        }

        .mesh-gradient {
            background:
                    radial-gradient(at 27% 37%, hsla(200, 70%, 50%, 0.15) 0px, transparent 50%),
                    radial-gradient(at 97% 21%, hsla(180, 60%, 45%, 0.12) 0px, transparent 50%),
                    radial-gradient(at 52% 99%, hsla(220, 50%, 40%, 0.1) 0px, transparent 50%);
        }

        .input-field {
            background: rgba(31, 41, 55, 0.5);
            border: 1px solid rgba(75, 85, 99, 0.5);
            transition: all 0.3s ease;
        }

        .input-field:focus {
            background: rgba(31, 41, 55, 0.8);
            border-color: rgb(20, 184, 166);
            outline: none;
            box-shadow: 0 0 0 3px rgba(20, 184, 166, 0.1);
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-black text-gray-100 overflow-x-hidden">

<!-- Animated Background -->
<div class="fixed inset-0 mesh-gradient opacity-30 pointer-events-none"></div>

<jsp:include page="/pages/components/navbar.jsp" />

<!-- Registration Section -->
<section class="relative container mx-auto px-6 py-20">
    <div class="max-w-6xl mx-auto">
        <div class="grid md:grid-cols-2 gap-12 items-center">
            <!-- Left Side - Form -->
            <div class="slide-up">
                <div class="glass-effect rounded-3xl p-8 md:p-10">
                    <div class="mb-8">
                        <h1 class="text-3xl md:text-4xl font-bold mb-3">
                            Créer un <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Compte</span>
                        </h1>
                        <p class="text-gray-400">Rejoignez notre communauté de santé digitale</p>
                    </div>

                    <!-- Error Messages -->
                    <c:if test="${not empty errors}">
                        <div class="glass-effect border border-red-500/50 rounded-2xl p-4 mb-6">
                            <div class="flex items-start space-x-3">
                                <svg class="w-6 h-6 text-red-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                <div class="flex-1">
                                    <h3 class="text-red-400 font-semibold mb-2">Erreurs de validation</h3>
                                    <ul class="space-y-1 text-sm text-red-300">
                                        <c:forEach var="err" items="${errors}">
                                            <li class="flex items-start space-x-2">
                                                <span class="text-red-400 mt-1">•</span>
                                                <span>${err}</span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register-patient" method="post" class="space-y-5">
                        <!-- Full Name -->
                        <div>
                            <label class="block text-sm font-medium mb-2 text-gray-300">Nom complet</label>
                            <input type="text" name="fullName" required class="input-field w-full px-4 py-3 rounded-xl text-white" placeholder="Ahmed Bennani">
                        </div>

                        <!-- Email -->
                        <div>
                            <label class="block text-sm font-medium mb-2 text-gray-300">Email</label>
                            <input type="email" name="email" required class="input-field w-full px-4 py-3 rounded-xl text-white" placeholder="votre@email.com">
                        </div>

                        <!-- Password -->
                        <div>
                            <label class="block text-sm font-medium mb-2 text-gray-300">Mot de passe</label>
                            <input type="password" name="password" required class="input-field w-full px-4 py-3 rounded-xl text-white" placeholder="••••••••">
                        </div>

                        <!-- CIN -->
                        <div>
                            <label class="block text-sm font-medium mb-2 text-gray-300">CIN</label>
                            <input type="text" name="cin" required class="input-field w-full px-4 py-3 rounded-xl text-white" placeholder="AB123456">
                        </div>

                        <!-- Date of Birth & Gender -->
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium mb-2 text-gray-300">Date de naissance</label>
                                <input type="date" name="dateOfBirth" required class="input-field w-full px-4 py-3 rounded-xl text-white">
                            </div>
                            <div>
                                <label class="block text-sm font-medium mb-2 text-gray-300">Genre</label>
                                <select name="gender" required class="input-field w-full px-4 py-3 rounded-xl text-white">
                                    <option value="MALE">Homme</option>
                                    <option value="FEMALE">Femme</option>
                                </select>
                            </div>
                        </div>

                        <!-- Blood Type & Insurance -->
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium mb-2 text-gray-300">Groupe sanguin</label>
                                <select name="bloodType" required class="input-field w-full px-4 py-3 rounded-xl text-white">
                                    <option value="A_POSITIVE">A+</option>
                                    <option value="A_NEGATIVE">A-</option>
                                    <option value="B_POSITIVE">B+</option>
                                    <option value="B_NEGATIVE">B-</option>
                                    <option value="O_POSITIVE">O+</option>
                                    <option value="O_NEGATIVE">O-</option>
                                    <option value="AB_POSITIVE">AB+</option>
                                    <option value="AB_NEGATIVE">AB-</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-sm font-medium mb-2 text-gray-300">N° d'assurance</label>
                                <input type="text" name="insuranceNumber" class="input-field w-full px-4 py-3 rounded-xl text-white" placeholder="123456789">
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="w-full py-4 bg-gradient-to-r from-teal-600 to-teal-700 rounded-xl font-semibold hover:shadow-2xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center justify-center space-x-2">
                            <span>Créer mon compte</span>
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                            </svg>
                        </button>

                        <!-- Login Link -->
                        <div class="text-center pt-4">
                            <p class="text-gray-400">
                                Vous avez déjà un compte ?
                                <a href="#" class="text-teal-400 hover:underline font-semibold">Se connecter</a>
                            </p>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Right Side - Info -->
            <div class="hidden md:block">
                <div class="space-y-8 float-animation">
                    <!-- Stats Card -->
                    <div class="glass-effect rounded-3xl p-8">
                        <div class="flex items-center space-x-4 mb-6">
                            <div class="w-16 h-16 bg-gradient-to-br from-teal-600 to-teal-700 rounded-2xl flex items-center justify-center glow-pulse">
                                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-teal-400">15,000+</div>
                                <div class="text-gray-400">Patients inscrits</div>
                            </div>
                        </div>
                        <p class="text-gray-300 leading-relaxed">
                            Des milliers de patients font confiance à notre plateforme pour gérer leur santé au quotidien.
                        </p>
                    </div>

                    <!-- Benefits List -->
                    <div class="glass-effect rounded-3xl p-8 space-y-6">
                        <h3 class="text-2xl font-bold mb-4">Pourquoi nous rejoindre ?</h3>

                        <div class="flex items-start space-x-4">
                            <div class="w-10 h-10 bg-teal-600/20 rounded-lg flex items-center justify-center flex-shrink-0">
                                <svg class="w-5 h-5 text-teal-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="font-semibold mb-1">Consultations en ligne</div>
                                <div class="text-sm text-gray-400">Accédez à des médecins qualifiés 24/7</div>
                            </div>
                        </div>

                        <div class="flex items-start space-x-4">
                            <div class="w-10 h-10 bg-emerald-600/20 rounded-lg flex items-center justify-center flex-shrink-0">
                                <svg class="w-5 h-5 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="font-semibold mb-1">Dossier médical sécurisé</div>
                                <div class="text-sm text-gray-400">Toutes vos informations en un seul endroit</div>
                            </div>
                        </div>

                        <div class="flex items-start space-x-4">
                            <div class="w-10 h-10 bg-teal-600/20 rounded-lg flex items-center justify-center flex-shrink-0">
                                <svg class="w-5 h-5 text-teal-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="font-semibold mb-1">Suivi personnalisé</div>
                                <div class="text-sm text-gray-400">Recommandations adaptées à votre profil</div>
                            </div>
                        </div>

                        <div class="flex items-start space-x-4">
                            <div class="w-10 h-10 bg-emerald-600/20 rounded-lg flex items-center justify-center flex-shrink-0">
                                <svg class="w-5 h-5 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="font-semibold mb-1">Notifications intelligentes</div>
                                <div class="text-sm text-gray-400">Ne manquez jamais un rendez-vous</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="/pages/components/footer.jsp" />

</body>
</html>
