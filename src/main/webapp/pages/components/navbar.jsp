<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Navigation -->
<nav class="relative z-50 glass-effect">
    <div class="container mx-auto px-6 py-4">
        <div class="flex items-center justify-between">
            <!-- Logo Section -->
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

            <!-- Navigation Links -->
            <div class="hidden md:flex items-center space-x-8">
                <a href="${pageContext.request.contextPath}/" class="hover:text-teal-400 transition-colors">Accueil</a>
                <a href="${pageContext.request.contextPath}/#services" class="hover:text-teal-400 transition-colors">Services</a>
                <a href="${pageContext.request.contextPath}/#doctors" class="hover:text-teal-400 transition-colors">Nos Docteurs</a>
                <a href="${pageContext.request.contextPath}/#contact" class="hover:text-teal-400 transition-colors">Contact</a>
            </div>

            <!-- User Profile / Auth Buttons -->
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div class="relative" x-data="{ open: false }" @click.away="open = false">
                        <!-- Profile Button -->
                        <button @click="open = !open"
                                class="flex items-center space-x-2 px-3 py-2 rounded-xl bg-white/10 backdrop-blur-sm border border-teal-500/30 hover:border-teal-500/50 hover:bg-white/15 transition-all duration-300">
                            <div class="w-8 h-8 rounded-full bg-gradient-to-br from-teal-500 to-teal-600 flex items-center justify-center text-white font-semibold text-sm shadow-lg">
                                    ${fn:substring(sessionScope.currentUser.fullName, 0, 1)}
                            </div>
                            <span class="text-sm font-medium hidden sm:block max-w-[120px] truncate">${sessionScope.currentUser.fullName}</span>
                            <svg class="w-4 h-4 transition-transform duration-300"
                                 :class="{ 'rotate-180': open }"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </button>

                        <!-- Dropdown Menu -->
                        <div x-show="open"
                             x-transition:enter="transition ease-out duration-200"
                             x-transition:enter-start="opacity-0 scale-95 -translate-y-2"
                             x-transition:enter-end="opacity-100 scale-100 translate-y-0"
                             x-transition:leave="transition ease-in duration-150"
                             x-transition:leave-start="opacity-100 scale-100 translate-y-0"
                             x-transition:leave-end="opacity-0 scale-95 -translate-y-2"
                             class="absolute right-0 mt-3 w-64 origin-top-right z-50"
                             style="display: none;">

                            <div class="bg-white/95 backdrop-blur-xl rounded-2xl shadow-2xl border border-teal-500/20 overflow-hidden">
                                <!-- User Info Header -->
                                <div class="px-4 py-3 bg-gradient-to-r from-teal-50 to-teal-100/50">
                                    <p class="text-sm font-semibold text-gray-800 truncate">${sessionScope.currentUser.fullName}</p>
                                    <p class="text-xs text-gray-600 mt-1 truncate">${sessionScope.currentUser.email}</p>
                                    <c:if test="${not empty sessionScope.currentUser.role}">
                                        <span class="inline-block mt-2 px-2 py-1 text-xs font-medium bg-teal-600 text-white rounded-full">
                                                ${sessionScope.currentUser.role}
                                        </span>
                                    </c:if>
                                </div>

                                <!-- Menu Items -->
                                <div class="py-2">
                                    <a href="${pageContext.request.contextPath}/patient/dashboard"
                                       class="flex items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-teal-50 hover:text-teal-700 transition-colors group">
                                        <svg class="w-5 h-5 mr-3 text-gray-400 group-hover:text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                                        </svg>
                                        Dashboard
                                    </a>

                                    <a href="${pageContext.request.contextPath}/patient/update-profile"
                                       class="flex items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-teal-50 hover:text-teal-700 transition-colors group">
                                        <svg class="w-5 h-5 mr-3 text-gray-400 group-hover:text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                        </svg>
                                        Mon Profile
                                    </a>

                                    <a href="${pageContext.request.contextPath}/patient/appointments"
                                       class="flex items-center px-4 py-2.5 text-sm text-gray-700 hover:bg-teal-50 hover:text-teal-700 transition-colors group">
                                        <svg class="w-5 h-5 mr-3 text-gray-400 group-hover:text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                        </svg>
                                        Mes Rendez-vous
                                    </a>
                                </div>

                                <!-- Logout Section -->
                                <div class="border-t border-gray-200/50 py-2">
                                    <a href="${pageContext.request.contextPath}/logout"
                                       class="flex items-center px-4 py-2.5 text-sm text-red-600 hover:bg-red-50 transition-colors group">
                                        <svg class="w-5 h-5 mr-3 text-red-500 group-hover:text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
                    <div class="flex items-center space-x-3">
                        <a href="${pageContext.request.contextPath}/login"
                           class="px-5 py-2 rounded-xl border border-teal-500/50 hover:bg-teal-600 hover:text-white hover:border-teal-600 transition-all duration-300 text-sm font-medium">
                            Connexion
                        </a>
                        <a href="${pageContext.request.contextPath}/pages/auth/registerPatient.jsp"
                           class="px-5 py-2 rounded-xl bg-gradient-to-r from-teal-600 to-teal-700 hover:shadow-lg hover:shadow-teal-600/30 hover:scale-105 transition-all duration-300 text-sm font-medium">
                            S'inscrire
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<!-- Add Alpine.js if not already included -->
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>