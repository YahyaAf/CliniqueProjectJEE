<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.currentUser}">
    <c:redirect url="/pages/auth/login.jsp"/>
</c:if>

<style>
    :root {
        --sidebar-width: 280px;
        --sidebar-collapsed: 85px;
        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --dark-bg: #0f172a;
    }

    #sidebar {
        width: var(--sidebar-width);
        background: var(--dark-bg);
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        z-index: 1000;
        box-shadow: 4px 0 24px rgba(0, 0, 0, 0.3);
        overflow: hidden;
    }

    #sidebar.collapsed {
        width: var(--sidebar-collapsed);
    }

    /* Header */
    .sidebar-header {
        padding: 2rem 1.5rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        display: flex;
        align-items: center;
        gap: 1rem;
        position: relative;
    }

    .logo-wrapper {
        width: 48px;
        height: 48px;
        background: var(--primary-gradient);
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
    }

    .logo-wrapper i {
        font-size: 24px;
        color: white;
    }

    .brand-text {
        font-size: 1.5rem;
        font-weight: 700;
        color: white;
        white-space: nowrap;
        opacity: 1;
        transition: opacity 0.3s;
    }

    #sidebar.collapsed .brand-text {
        opacity: 0;
        pointer-events: none;
    }

    .toggle-btn {
        position: absolute;
        right: -16px;
        top: 50%;
        transform: translateY(-50%);
        width: 32px;
        height: 32px;
        background: var(--primary-gradient);
        border: 3px solid var(--dark-bg);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: all 0.3s;
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
    }

    .toggle-btn:hover {
        transform: translateY(-50%) scale(1.1);
    }

    .toggle-btn i {
        font-size: 12px;
        color: white;
        transition: transform 0.3s;
    }

    #sidebar.collapsed .toggle-btn i {
        transform: rotate(180deg);
    }

    /* Navigation */
    .sidebar-nav {
        padding: 1.5rem 1rem;
        overflow-y: auto;
        height: calc(100vh - 120px);
        scrollbar-width: thin;
        scrollbar-color: rgba(102, 126, 234, 0.5) transparent;
    }

    .sidebar-nav::-webkit-scrollbar {
        width: 4px;
    }

    .sidebar-nav::-webkit-scrollbar-thumb {
        background: rgba(102, 126, 234, 0.5);
        border-radius: 4px;
    }

    .nav-item {
        margin-bottom: 0.5rem;
    }

    .nav-link {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 0.875rem 1.25rem;
        color: rgba(255, 255, 255, 0.6);
        text-decoration: none;
        border-radius: 12px;
        transition: all 0.3s;
        position: relative;
        overflow: hidden;
    }

    .nav-link::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        width: 4px;
        height: 100%;
        background: var(--primary-gradient);
        transform: scaleY(0);
        transition: transform 0.3s;
    }

    .nav-link:hover {
        background: rgba(102, 126, 234, 0.1);
        color: white;
        transform: translateX(4px);
    }

    .nav-link.active {
        background: rgba(102, 126, 234, 0.15);
        color: white;
    }

    .nav-link.active::before {
        transform: scaleY(1);
    }

    .nav-icon {
        width: 20px;
        text-align: center;
        flex-shrink: 0;
        font-size: 1.125rem;
    }

    .nav-text {
        white-space: nowrap;
        opacity: 1;
        transition: opacity 0.3s;
    }

    #sidebar.collapsed .nav-text {
        opacity: 0;
    }

    /* Divider */
    .nav-divider {
        height: 1px;
        background: rgba(255, 255, 255, 0.08);
        margin: 1rem 0;
    }

    /* Logout Special */
    .nav-link.logout {
        color: rgba(248, 113, 113, 0.8);
    }

    .nav-link.logout:hover {
        background: rgba(248, 113, 113, 0.1);
        color: #f87171;
    }

    .nav-link.logout::before {
        background: linear-gradient(135deg, #f87171 0%, #dc2626 100%);
    }

    /* Tooltip for collapsed state */
    .nav-link[data-tooltip] {
        position: relative;
    }

    #sidebar.collapsed .nav-link[data-tooltip]:hover::after {
        content: attr(data-tooltip);
        position: absolute;
        left: 100%;
        top: 50%;
        transform: translateY(-50%);
        margin-left: 1rem;
        padding: 0.5rem 1rem;
        background: rgba(15, 23, 42, 0.95);
        color: white;
        border-radius: 8px;
        font-size: 0.875rem;
        white-space: nowrap;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        z-index: 1001;
        border: 1px solid rgba(102, 126, 234, 0.3);
    }

    /* Main Content Adjustment */
    #mainContent {
        margin-left: var(--sidebar-width);
        transition: margin-left 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    #sidebar.collapsed ~ #mainContent {
        margin-left: var(--sidebar-collapsed);
    }

    /* Responsive */
    @media (max-width: 768px) {
        #sidebar {
            transform: translateX(-100%);
        }

        #sidebar.mobile-open {
            transform: translateX(0);
        }

        #mainContent {
            margin-left: 0 !important;
        }
    }
</style>

<!-- Sidebar -->
<aside id="sidebar">
    <!-- Header -->
    <div class="sidebar-header">
        <div class="logo-wrapper">
            <i class="fas fa-heartbeat"></i>
        </div>
        <span class="brand-text">MediCare<span style="color: #667eea;">+</span></span>
        <div class="toggle-btn" onclick="toggleSidebar()">
            <i class="fas fa-chevron-left"></i>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="sidebar-nav">
        <ul style="list-style: none; padding: 0; margin: 0;">

            <%-- ✅ Dashboard - ALL ROLES --%>
            <li class="nav-item">
                <a href="/clinique/dashboard/home.jsp"
                   class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}"
                   data-tooltip="Dashboard">
                    <i class="fas fa-home nav-icon"></i>
                    <span class="nav-text">Dashboard</span>
                </a>
            </li>

            <%-- ✅ ADMIN ONLY - Users --%>
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/clinique/admin/list-users"
                       class="nav-link ${currentPage == 'users' ? 'active' : ''}"
                       data-tooltip="Users">
                        <i class="fas fa-users nav-icon"></i>
                        <span class="nav-text">Users</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ ADMIN ONLY - Patients --%>
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/clinique/admin/patients"
                       class="nav-link ${currentPage == 'patients' ? 'active' : ''}"
                       data-tooltip="Patients">
                        <i class="fas fa-users nav-icon"></i>
                        <span class="nav-text">Patients</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ ADMIN ONLY - Docteurs --%>
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/clinique/admin/doctors"
                       class="nav-link ${currentPage == 'doctors' ? 'active' : ''}"
                       data-tooltip="Docteurs">
                        <i class="fas fa-user-md nav-icon"></i>
                        <span class="nav-text">Docteurs</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ ADMIN ONLY - Personnel --%>
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/clinique/admin/staff"
                       class="nav-link ${currentPage == 'staff' ? 'active' : ''}"
                       data-tooltip="Personnel">
                        <i class="fas fa-user-nurse nav-icon"></i>
                        <span class="nav-text">Personnel</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ DOCTOR ONLY - Rendez-vous --%>
            <c:if test="${sessionScope.currentUser.role == 'DOCTOR'}">
                <li class="nav-item">
                    <a href="/clinique/dashboard/appointments/list"
                       class="nav-link ${currentPage == 'appointments' ? 'active' : ''}"
                       data-tooltip="Rendez-vous">
                        <i class="fas fa-calendar-check nav-icon"></i>
                        <span class="nav-text">Rendez-vous</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ DOCTOR ONLY - Dossiers Médicaux --%>
            <c:if test="${sessionScope.currentUser.role == 'DOCTOR'}">
                <li class="nav-item">
                    <a href="/clinique/dashboard/medicalNotes"
                       class="nav-link ${currentPage == 'records' ? 'active' : ''}"
                       data-tooltip="Dossiers">
                        <i class="fas fa-file-medical-alt nav-icon"></i>
                        <span class="nav-text">Dossiers Médicaux</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ ADMIN ONLY - Départements --%>
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/clinique/admin/departments"
                       class="nav-link ${currentPage == 'departments' ? 'active' : ''}"
                       data-tooltip="Départements">
                        <i class="fas fa-building nav-icon"></i>
                        <span class="nav-text">Départements</span>
                    </a>
                </li>
            </c:if>

            <%-- ✅ ADMIN ONLY - Spécialités --%>
            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                <li class="nav-item">
                    <a href="/clinique/admin/specialites"
                       class="nav-link ${currentPage == 'specialites' ? 'active' : ''}"
                       data-tooltip="Spécialités">
                        <i class="fas fa-stethoscope nav-icon"></i>
                        <span class="nav-text">Spécialités</span>
                    </a>
                </li>
            </c:if>

            <li class="nav-divider"></li>

            <%-- ✅ Déconnexion - ALL ROLES --%>
            <li class="nav-item">
                <a href="/clinique/logout"
                   class="nav-link logout"
                   data-tooltip="Déconnexion">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Déconnexion</span>
                </a>
            </li>
        </ul>
    </nav>
</aside>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('collapsed');
        localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
    }

    document.addEventListener('DOMContentLoaded', () => {
        if (localStorage.getItem('sidebarCollapsed') === 'true') {
            document.getElementById('sidebar').classList.add('collapsed');
        }
    });

    if (window.innerWidth <= 768) {
        function toggleMobileSidebar() {
            document.getElementById('sidebar').classList.toggle('mobile-open');
        }
    }
</script>