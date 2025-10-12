<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Sidebar Styles (à inclure une seule fois dans votre page principale) -->
<style>
    .sidebar-gradient {
        background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%);
    }

    .sidebar-text {
        transition: all 0.3s ease;
        white-space: nowrap;
    }

    #sidebar.collapsed .sidebar-text {
        opacity: 0;
        display: none;
    }

    #sidebar {
        transition: width 0.3s ease;
        overflow-y: auto;
        overflow-x: hidden;
    }

    /* Custom Scrollbar pour la sidebar */
    #sidebar::-webkit-scrollbar {
        width: 6px;
    }

    #sidebar::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
    }

    #sidebar::-webkit-scrollbar-thumb {
        background: rgba(99, 102, 241, 0.5);
        border-radius: 10px;
    }

    #sidebar::-webkit-scrollbar-thumb:hover {
        background: rgba(99, 102, 241, 0.7);
    }

    /* Pour Firefox */
    #sidebar {
        scrollbar-width: thin;
        scrollbar-color: rgba(99, 102, 241, 0.5) rgba(255, 255, 255, 0.05);
    }

    #mainContent {
        transition: margin-left 0.3s ease;
    }

    .nav-link.active {
        background: rgba(99, 102, 241, 0.1);
        color: white;
    }

    .nav-link.active .sidebar-indicator {
        transform: scaleY(1);
    }

    .sidebar-indicator {
        position: absolute;
        left: 0;
        top: 0;
        width: 4px;
        height: 100%;
        background: linear-gradient(to bottom, #6366f1, #ec4899);
        border-radius: 0 4px 4px 0;
        transform: scaleY(0);
        transition: transform 0.3s ease;
    }
</style>

<!-- Sidebar -->
<aside id="sidebar" class="fixed left-0 top-0 h-screen sidebar-gradient shadow-2xl z-50 w-64">
    <!-- Header -->
    <div class="flex items-center justify-between p-6 border-b border-white/10">
        <div class="flex items-center gap-3">
            <i class="fas fa-heartbeat text-4xl bg-gradient-to-r from-indigo-500 to-pink-500 bg-clip-text text-transparent"></i>
            <span class="text-white text-2xl font-bold sidebar-text">MediCare+</span>
        </div>
        <button onclick="toggleSidebar()" class="w-9 h-9 bg-white/10 hover:bg-white/20 rounded-lg flex items-center justify-center text-white transition-all">
            <i class="fas fa-bars"></i>
        </button>
    </div>

    <!-- Navigation Menu -->
    <ul class="p-4 space-y-2">
        <li>
            <a href="${pageContext.request.contextPath}/dashboard"
               class="nav-link ${currentPage == 'dashboard' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-home text-xl"></i>
                <span class="sidebar-text">Dashboard</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/patients"
               class="nav-link ${currentPage == 'patients' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-users text-xl"></i>
                <span class="sidebar-text">Patients</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/doctors"
               class="nav-link ${currentPage == 'doctors' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-user-md text-xl"></i>
                <span class="sidebar-text">Docteurs</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/appointments"
               class="nav-link ${currentPage == 'appointments' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-calendar-alt text-xl"></i>
                <span class="sidebar-text">Rendez-vous</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/medical-records"
               class="nav-link ${currentPage == 'medical-records' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-file-medical text-xl"></i>
                <span class="sidebar-text">Dossiers Médicaux</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/prescriptions"
               class="nav-link ${currentPage == 'prescriptions' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-pills text-xl"></i>
                <span class="sidebar-text">Prescriptions</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/statistics"
               class="nav-link ${currentPage == 'statistics' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-chart-line text-xl"></i>
                <span class="sidebar-text">Statistiques</span>
            </a>
        </li>

        <!-- Divider -->
        <li class="pt-4">
            <div class="border-t border-white/10 mb-4"></div>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/settings"
               class="nav-link ${currentPage == 'settings' ? 'active' : ''} flex items-center gap-3 px-5 py-4 text-white/70 hover:text-white hover:bg-indigo-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator"></span>
                <i class="fas fa-cog text-xl"></i>
                <span class="sidebar-text">Paramètres</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/logout"
               class="nav-link flex items-center gap-3 px-5 py-4 text-red-400/70 hover:text-red-400 hover:bg-red-500/10 rounded-xl transition-all relative group">
                <span class="sidebar-indicator bg-gradient-to-b from-red-500 to-red-600"></span>
                <i class="fas fa-sign-out-alt text-xl"></i>
                <span class="sidebar-text">Déconnexion</span>
            </a>
        </li>
    </ul>
</aside>

<!-- Sidebar Toggle Script -->
<script>
    let sidebarCollapsed = false;

    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');

        sidebarCollapsed = !sidebarCollapsed;

        if (sidebarCollapsed) {
            sidebar.classList.add('collapsed');
            sidebar.style.width = '80px';
            if (mainContent) {
                mainContent.style.marginLeft = '80px';
            }
        } else {
            sidebar.classList.remove('collapsed');
            sidebar.style.width = '256px';
            if (mainContent) {
                mainContent.style.marginLeft = '256px';
            }
        }

        // Sauvegarder l'état dans localStorage
        localStorage.setItem('sidebarCollapsed', sidebarCollapsed);
    }

    // Restaurer l'état de la sidebar au chargement
    document.addEventListener('DOMContentLoaded', function() {
        const savedState = localStorage.getItem('sidebarCollapsed');
        if (savedState === 'true') {
            toggleSidebar();
        }
    });
</script>