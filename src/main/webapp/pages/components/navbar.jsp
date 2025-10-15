<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navigation -->
<nav class="relative z-50 glass-effect">
    <div class="container mx-auto px-6 py-4">
        <div class="flex items-center justify-between">
            <div class="flex items-center space-x-3">
                <div class="w-12 h-12 bg-gradient-to-br from-teal-600 to-teal-800 rounded-xl flex items-center justify-center glow-pulse">
                    <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                    </svg>
                </div>
                <a href="${pageContext.request.contextPath}/" class="text-2xl font-bold bg-gradient-to-r from-teal-400 to-teal-500 bg-clip-text text-transparent">
                    MediCare+
                </a>
            </div>

            <div class="hidden md:flex items-center space-x-8">
                <a href="${pageContext.request.contextPath}/" class="hover:text-teal-400 transition-colors">Accueil</a>
                <a href="${pageContext.request.contextPath}/#services" class="hover:text-teal-400 transition-colors">Services</a>
                <a href="${pageContext.request.contextPath}/#doctors" class="hover:text-teal-400 transition-colors">Nos Docteurs</a>
                <a href="${pageContext.request.contextPath}/#contact" class="hover:text-teal-400 transition-colors">Contact</a>
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div class="relative group">
                        <button class="flex items-center space-x-3 px-4 py-2 rounded-full bg-white/10 backdrop-blur-sm border border-teal-500/30 hover:border-teal-500/50 transition-all duration-300">
                            <div class="w-9 h-9 rounded-full bg-gradient-to-br from-teal-500 to-teal-600 flex items-center justify-center text-white font-semibold text-sm">
                                    ${fn:substring(sessionScope.currentUser.fullName, 0, 1)}
                            </div>
                            <span class="text-sm font-medium">${sessionScope.currentUser.fullName}</span>
                            <svg class="w-4 h-4 transition-transform group-hover:rotate-180 duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </button>

                        <!-- Dropdown Menu -->
                        <div class="absolute right-0 mt-2 w-56 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform origin-top-right">
                            <div class="bg-white/95 backdrop-blur-lg rounded-2xl shadow-xl border border-teal-500/20 overflow-hidden">
                                <div class="px-4 py-3 border-b border-gray-200/50">
                                    <p class="text-sm font-semibold text-gray-800">${sessionScope.currentUser.fullName}</p>
                                    <p class="text-xs text-gray-500 mt-0.5">${sessionScope.currentUser.email}</p>
                                </div>
                                <div class="border-t border-gray-200/50 py-2">
                                    <a href="${pageContext.request.contextPath}/patient/update-profile"
                                       class="flex items-center px-4 py-2.5 text-sm text-red-600 hover:bg-red-50 transition-colors">
                                        <svg class="w-4 h-4 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                                        </svg>
                                        Profile
                                    </a>
                                </div>
                                <div class="border-t border-gray-200/50 py-2">
                                    <a href="${pageContext.request.contextPath}/logout"
                                       class="flex items-center px-4 py-2.5 text-sm text-red-600 hover:bg-red-50 transition-colors">
                                        <svg class="w-4 h-4 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                                        </svg>
                                        Déconnexion
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="flex items-center space-x-4">
                        <a href="${pageContext.request.contextPath}/login"
                           class="px-6 py-2 rounded-full border border-teal-500/50 hover:bg-teal-600 hover:text-white transition-all duration-300">
                            Connexion
                        </a>
                        <a href="${pageContext.request.contextPath}/pages/auth/registerPatient.jsp"
                           class="px-6 py-2 rounded-full bg-gradient-to-r from-teal-600 to-teal-700 hover:shadow-lg hover:shadow-teal-600/30 transition-all duration-300">
                            S'inscrire
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
</nav>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>