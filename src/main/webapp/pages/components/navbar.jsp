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
                    <div class="flex items-center space-x-4">
            <span class="text-gray-700 font-medium">
                Welcome, ${sessionScope.currentUser.fullName} 
            </span>
                        <a href="${pageContext.request.contextPath}/logout"
                           class="px-6 py-2 rounded-full bg-red-600 hover:bg-red-700 text-white transition-all duration-300">
                            Logout
                        </a>
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