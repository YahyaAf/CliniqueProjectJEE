<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Navigation - Compact -->
<nav class="relative z-50 glass-effect">
    <div class="container mx-auto px-6 py-3">
        <div class="flex items-center justify-between">
            <!-- Logo Section - Compact -->
            <div class="flex items-center space-x-2">
                <div class="w-10 h-10 bg-gradient-to-br from-teal-600 to-teal-800 rounded-lg flex items-center justify-center glow-pulse">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                    </svg>
                </div>
                <a href="${pageContext.request.contextPath}/" class="text-xl font-bold bg-gradient-to-r from-teal-400 to-teal-500 bg-clip-text text-transparent">
                    MediCare+
                </a>
            </div>

            <!-- Navigation Links - Compact -->
            <div class="hidden md:flex items-center space-x-6">
                <a href="${pageContext.request.contextPath}/" class="text-sm hover:text-teal-400 transition-colors font-medium">Accueil</a>
                <a href="${pageContext.request.contextPath}/#services" class="text-sm hover:text-teal-400 transition-colors font-medium">Services</a>
                <a href="${pageContext.request.contextPath}/#doctors" class="text-sm hover:text-teal-400 transition-colors font-medium">Nos Docteurs</a>
                <a href="${pageContext.request.contextPath}/appointments/calendar" class="text-sm hover:text-teal-400 transition-colors font-medium">Calendar</a>
            </div>

            <!-- User Profile / Auth Buttons - Compact -->
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div class="relative" x-data="{ open: false }" @click.away="open = false">
                        <!-- Profile Button - Compact -->
                        <button @click="open = !open"
                                class="flex items-center space-x-2 px-3 py-1.5 rounded-lg bg-white/10 backdrop-blur-sm border border-teal-500/30 hover:border-teal-500/50 hover:bg-white/15 transition-all duration-300">
                            <div class="w-7 h-7 rounded-full bg-gradient-to-br from-teal-500 to-teal-600 flex items-center justify-center text-white font-semibold text-xs shadow-lg">
                                    ${fn:substring(sessionScope.currentUser.fullName, 0, 1)}
                            </div>
                            <span class="text-xs font-medium hidden sm:block max-w-[100px] truncate">${sessionScope.currentUser.fullName}</span>
                            <svg class="w-3.5 h-3.5 transition-transform duration-300"
                                 :class="{ 'rotate-180': open }"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                            </svg>
                        </button>

                        <!-- Dropdown Menu - Compact -->
                        <div x-show="open"
                             x-transition:enter="transition ease-out duration-200"
                             x-transition:enter-start="opacity-0 scale-95 -translate-y-2"
                             x-transition:enter-end="opacity-100 scale-100 translate-y-0"
                             x-transition:leave="transition ease-in duration-150"
                             x-transition:leave-start="opacity-100 scale-100 translate-y-0"
                             x-transition:leave-end="opacity-0 scale-95 -translate-y-2"
                             class="absolute right-0 mt-2 w-56 origin-top-right z-50"
                             style="display: none;">

                            <div class="bg-white/95 backdrop-blur-xl rounded-xl shadow-2xl border border-teal-500/20 overflow-hidden">
                                <!-- User Info Header - Compact -->
                                <div class="px-3 py-2.5 bg-gradient-to-r from-teal-50 to-teal-100/50">
                                    <p class="text-xs font-semibold text-gray-800 truncate">${sessionScope.currentUser.fullName}</p>
                                    <p class="text-[10px] text-gray-600 mt-0.5 truncate">${sessionScope.currentUser.email}</p>
                                    <c:if test="${not empty sessionScope.currentUser.role}">
                                        <span class="inline-block mt-1.5 px-2 py-0.5 text-[10px] font-medium bg-teal-600 text-white rounded-full">
                                                ${sessionScope.currentUser.role}
                                        </span>
                                    </c:if>
                                </div>

                                <!-- Menu Items - Compact -->
                                <div class="py-1.5">
                                    <a href="${pageContext.request.contextPath}/patient/update-profile"
                                       class="flex items-center px-3 py-2 text-xs text-gray-700 hover:bg-teal-50 hover:text-teal-700 transition-colors group">
                                        <svg class="w-4 h-4 mr-2 text-gray-400 group-hover:text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                        </svg>
                                        Mon Profile
                                    </a>

                                    <a href="${pageContext.request.contextPath}/pages/appointments/list"
                                       class="flex items-center px-3 py-2 text-xs text-gray-700 hover:bg-teal-50 hover:text-teal-700 transition-colors group">
                                        <svg class="w-4 h-4 mr-2 text-gray-400 group-hover:text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                        </svg>
                                        Mes Rendez-vous
                                    </a>

                                    <a href="${pageContext.request.contextPath}/appointments/calendar"
                                       class="flex items-center px-3 py-2 text-xs text-gray-700 hover:bg-teal-50 hover:text-teal-700 transition-colors group">
                                        <svg class="w-4 h-4 mr-2 text-gray-400 group-hover:text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                        </svg>
                                        Calendar
                                    </a>
                                </div>

                                <!-- Logout Section - Compact -->
                                <div class="border-t border-gray-200/50 py-1.5">
                                    <a href="${pageContext.request.contextPath}/logout"
                                       class="flex items-center px-3 py-2 text-xs text-red-600 hover:bg-red-50 transition-colors group">
                                        <svg class="w-4 h-4 mr-2 text-red-500 group-hover:text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
                    <div class="flex items-center space-x-2">
                        <a href="${pageContext.request.contextPath}/login"
                           class="px-4 py-1.5 rounded-lg border border-teal-500/50 hover:bg-teal-600 hover:text-white hover:border-teal-600 transition-all duration-300 text-xs font-medium">
                            Connexion
                        </a>
                        <a href="${pageContext.request.contextPath}/pages/auth/registerPatient.jsp"
                           class="px-4 py-1.5 rounded-lg bg-gradient-to-r from-teal-600 to-teal-700 hover:shadow-lg hover:shadow-teal-600/30 hover:scale-105 transition-all duration-300 text-xs font-medium">
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