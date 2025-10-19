<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty sessionScope.currentUser}">
    <c:redirect url="/"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - MediCare+</title>
    <jsp:include page="/pages/components/styles.jsp" />
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-black text-gray-100 overflow-x-hidden">

<div class="fixed inset-0 mesh-gradient opacity-30 pointer-events-none"></div>

<jsp:include page="/pages/components/navbar.jsp" />

<!-- Login Section -->
<section class="relative container mx-auto px-6 py-20 flex items-center justify-center min-h-[calc(100vh-200px)]">
    <div class="grid md:grid-cols-2 gap-12 items-center w-full max-w-6xl">

        <!-- Left Side - Info -->
        <div class="space-y-6 slide-up hidden md:block">
            <div class="inline-block px-4 py-2 bg-teal-600/20 rounded-full border border-teal-500/30">
                <span class="text-teal-400 text-sm font-semibold">🔐 Espace Sécurisé</span>
            </div>

            <h1 class="text-4xl md:text-5xl font-bold leading-tight">
                Bienvenue sur
                <span class="bg-gradient-to-r from-teal-400 via-teal-500 to-emerald-400 bg-clip-text text-transparent">
                    MediCare+
                </span>
            </h1>

            <p class="text-lg text-gray-300 leading-relaxed">
                Accédez à votre espace personnel pour gérer vos rendez-vous, consulter votre dossier médical et bien plus encore.
            </p>

            <div class="flex items-center space-x-6 pt-4">
                <div>
                    <div class="text-3xl font-bold text-teal-400">100%</div>
                    <div class="text-gray-400 text-xs">Sécurisé</div>
                </div>
                <div class="w-px h-10 bg-gray-700"></div>
                <div>
                    <div class="text-3xl font-bold text-teal-500">24/7</div>
                    <div class="text-gray-400 text-xs">Disponible</div>
                </div>
                <div class="w-px h-10 bg-gray-700"></div>
                <div>
                    <div class="text-3xl font-bold text-emerald-400">15K+</div>
                    <div class="text-gray-400 text-xs">Utilisateurs</div>
                </div>
            </div>

            <!-- Decorative Image -->
            <div class="relative float-animation mt-12">
                <div class="absolute top-0 right-0 w-40 h-40 bg-teal-600/20 rounded-full blur-3xl"></div>
                <div class="absolute bottom-0 left-0 w-40 h-40 bg-emerald-600/20 rounded-full blur-3xl"></div>
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="slide-up">
            <div class="glass-effect rounded-3xl p-8 md:p-10 w-full">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-bold mb-2">
                        <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">
                            Connexion
                        </span>
                    </h2>
                    <p class="text-gray-400">Accédez à votre espace santé</p>
                </div>

                <!-- Error messages -->
                <c:if test="${not empty errors}">
                    <div class="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 rounded-xl mb-6 backdrop-blur-sm">
                        <div class="flex items-start">
                            <svg class="w-5 h-5 mt-0.5 mr-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <ul class="space-y-1 text-sm">
                                <c:forEach var="err" items="${errors}">
                                    <li>${err}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </c:if>

                <!-- Login form -->
                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-6">
                    <div>
                        <label class="block text-gray-300 mb-2 font-medium">Email</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                                </svg>
                            </div>
                            <input type="email" name="email" required
                                   class="w-full pl-12 pr-4 py-3 bg-gray-800/50 border border-gray-600 rounded-xl text-gray-100 placeholder-gray-500 focus:outline-none focus:border-teal-500 input-glow transition-all duration-300"
                                   placeholder="votre@email.com">
                        </div>
                    </div>

                    <div>
                        <label class="block text-gray-300 mb-2 font-medium">Mot de passe</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                                </svg>
                            </div>
                            <input type="password" name="password" required
                                   class="w-full pl-12 pr-4 py-3 bg-gray-800/50 border border-gray-600 rounded-xl text-gray-100 placeholder-gray-500 focus:outline-none focus:border-teal-500 input-glow transition-all duration-300"
                                   placeholder="••••••••">
                        </div>
                    </div>
                    <button type="submit"
                            class="w-full py-4 bg-gradient-to-r from-teal-600 to-teal-700 rounded-xl font-semibold hover:shadow-2xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center justify-center space-x-2 group">
                        <span>Se connecter</span>
                        <svg class="w-5 h-5 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                        </svg>
                    </button>
                </form>

                <div class="mt-6 text-center">
                    <p class="text-gray-400 text-sm">
                        Pas encore de compte ?
                        <a href="${pageContext.request.contextPath}/pages/auth/registerPatient.jsp"
                           class="text-teal-400 hover:text-teal-300 font-semibold transition-colors">
                            Créer un compte
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Include Footer -->
<jsp:include page="/pages/components/footer.jsp" />

</body>
</html>