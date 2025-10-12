<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - MediCare+</title>
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
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            opacity: 0.1;
        }
        .stat-card.patients::before { background: #6366f1; }
        .stat-card.doctors::before { background: #10b981; }
        .stat-card.appointments::before { background: #f59e0b; }
        .stat-card.revenue::before { background: #ec4899; }
    </style>
</head>
<body class="gradient-bg min-h-screen">

<!-- Set current page for sidebar -->
<c:set var="currentPage" value="dashboard" scope="request"/>

<!-- Include Sidebar Component -->
<jsp:include page="/dashboard/components/sidebar.jsp"/>

<!-- Main Content -->
<main id="mainContent" class="p-8 ml-64">
    <!-- Header -->
    <header class="bg-white rounded-3xl p-6 mb-8 shadow-lg">
        <div class="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4">
            <div>
                <h1 class="text-4xl font-bold bg-gradient-to-r from-indigo-500 to-pink-500 bg-clip-text text-transparent mb-2">
                    Bienvenue, ${sessionScope.currentUser.fullName}
                </h1>
                <p class="text-slate-500">Voici votre aperçu d'aujourd'hui</p>
            </div>
            <div class="flex items-center gap-4 w-full lg:w-auto">
                <div class="relative flex-1 lg:flex-initial">
                    <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                    <input type="text" placeholder="Rechercher..."
                           class="w-full lg:w-80 pl-12 pr-4 py-3 border-2 border-slate-200 rounded-xl focus:border-indigo-500 focus:outline-none focus:ring-4 focus:ring-indigo-500/10 transition-all">
                </div>
                <button class="relative w-12 h-12 bg-slate-50 hover:bg-indigo-500 hover:text-white rounded-xl transition-all flex items-center justify-center">
                    <i class="fas fa-bell"></i>
                    <span class="absolute top-2 right-2 w-5 h-5 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">5</span>
                </button>
                <div class="flex items-center gap-3 px-4 py-2 bg-slate-50 hover:bg-indigo-500 hover:text-white rounded-xl cursor-pointer transition-all">
                    <div class="w-10 h-10 bg-gradient-to-br from-indigo-500 to-pink-500 rounded-full flex items-center justify-center text-white font-bold">
                       
                    </div>
                    <span class="font-medium hidden lg:block">${sessionScope.currentUser.fullName}</span>
                    <i class="fas fa-chevron-down text-sm"></i>
                </div>
            </div>
        </div>
    </header>

    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
        <!-- Patients Card -->
        <div class="stat-card patients bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl hover:-translate-y-2 transition-all relative overflow-hidden">
            <div class="w-16 h-16 bg-indigo-500/10 rounded-2xl flex items-center justify-center text-indigo-500 text-3xl mb-4">
                <i class="fas fa-users"></i>
            </div>
            <div class="text-4xl font-bold mb-2">1,284</div>
            <div class="text-slate-500 mb-4">Total Patients</div>
            <span class="inline-flex items-center gap-2 px-3 py-1 bg-green-500/10 text-green-600 rounded-lg text-sm font-semibold">
                <i class="fas fa-arrow-up"></i>
                12% ce mois
            </span>
        </div>

        <!-- Doctors Card -->
        <div class="stat-card doctors bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl hover:-translate-y-2 transition-all relative overflow-hidden">
            <div class="w-16 h-16 bg-green-500/10 rounded-2xl flex items-center justify-center text-green-500 text-3xl mb-4">
                <i class="fas fa-user-md"></i>
            </div>
            <div class="text-4xl font-bold mb-2">45</div>
            <div class="text-slate-500 mb-4">Docteurs Actifs</div>
            <span class="inline-flex items-center gap-2 px-3 py-1 bg-green-500/10 text-green-600 rounded-lg text-sm font-semibold">
                <i class="fas fa-arrow-up"></i>
                3 nouveaux
            </span>
        </div>

        <!-- Appointments Card -->
        <div class="stat-card appointments bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl hover:-translate-y-2 transition-all relative overflow-hidden">
            <div class="w-16 h-16 bg-amber-500/10 rounded-2xl flex items-center justify-center text-amber-500 text-3xl mb-4">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="text-4xl font-bold mb-2">128</div>
            <div class="text-slate-500 mb-4">Rendez-vous Aujourd'hui</div>
            <span class="inline-flex items-center gap-2 px-3 py-1 bg-red-500/10 text-red-600 rounded-lg text-sm font-semibold">
                <i class="fas fa-arrow-down"></i>
                8% vs hier
            </span>
        </div>

        <!-- Revenue Card -->
        <div class="stat-card revenue bg-white rounded-3xl p-8 shadow-lg hover:shadow-xl hover:-translate-y-2 transition-all relative overflow-hidden">
            <div class="w-16 h-16 bg-pink-500/10 rounded-2xl flex items-center justify-center text-pink-500 text-3xl mb-4">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <div class="text-4xl font-bold mb-2">45.8K MAD</div>
            <div class="text-slate-500 mb-4">Revenus ce Mois</div>
            <span class="inline-flex items-center gap-2 px-3 py-1 bg-green-500/10 text-green-600 rounded-lg text-sm font-semibold">
                <i class="fas fa-arrow-up"></i>
                18% vs dernier
            </span>
        </div>
    </div>

    <!-- Content Grid -->
    <div class="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-8">
        <!-- Appointments -->
        <div class="xl:col-span-2 bg-white rounded-3xl p-8 shadow-lg">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-slate-800">Prochains Rendez-vous</h2>
                <a href="${pageContext.request.contextPath}/appointments" class="flex items-center gap-2 text-indigo-500 font-semibold hover:gap-3 transition-all">
                    Voir tous <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <div class="space-y-4">
                <div class="flex items-center gap-4 p-5 bg-slate-50 hover:bg-slate-100 rounded-2xl transition-all">
                    <div class="bg-white p-4 rounded-xl text-center min-w-20 shadow-sm">
                        <div class="text-xl font-bold text-indigo-500">09:00</div>
                        <div class="text-xs text-slate-500">Aujourd'hui</div>
                    </div>
                    <div class="flex-1">
                        <h4 class="font-semibold mb-1">Consultation - Mme. Fatima Zahra</h4>
                        <p class="text-sm text-slate-500">Dr. Karim Bennani • Cardiologie</p>
                    </div>
                    <span class="px-4 py-2 bg-green-500/10 text-green-600 rounded-lg text-sm font-semibold">Confirmé</span>
                </div>

                <div class="flex items-center gap-4 p-5 bg-slate-50 hover:bg-slate-100 rounded-2xl transition-all">
                    <div class="bg-white p-4 rounded-xl text-center min-w-20 shadow-sm">
                        <div class="text-xl font-bold text-indigo-500">10:30</div>
                        <div class="text-xs text-slate-500">Aujourd'hui</div>
                    </div>
                    <div class="flex-1">
                        <h4 class="font-semibold mb-1">Suivi - M. Hassan Alami</h4>
                        <p class="text-sm text-slate-500">Dr. Amina Tazi • Médecine Générale</p>
                    </div>
                    <span class="px-4 py-2 bg-green-500/10 text-green-600 rounded-lg text-sm font-semibold">Confirmé</span>
                </div>

                <div class="flex items-center gap-4 p-5 bg-slate-50 hover:bg-slate-100 rounded-2xl transition-all">
                    <div class="bg-white p-4 rounded-xl text-center min-w-20 shadow-sm">
                        <div class="text-xl font-bold text-indigo-500">14:00</div>
                        <div class="text-xs text-slate-500">Aujourd'hui</div>
                    </div>
                    <div class="flex-1">
                        <h4 class="font-semibold mb-1">Urgence - Mme. Salma Idrissi</h4>
                        <p class="text-sm text-slate-500">Dr. Youssef Maroc • Urgences</p>
                    </div>
                    <span class="px-4 py-2 bg-amber-500/10 text-amber-600 rounded-lg text-sm font-semibold">En attente</span>
                </div>

                <div class="flex items-center gap-4 p-5 bg-slate-50 hover:bg-slate-100 rounded-2xl transition-all">
                    <div class="bg-white p-4 rounded-xl text-center min-w-20 shadow-sm">
                        <div class="text-xl font-bold text-indigo-500">16:30</div>
                        <div class="text-xs text-slate-500">Aujourd'hui</div>
                    </div>
                    <div class="flex-1">
                        <h4 class="font-semibold mb-1">Contrôle - M. Omar Benjelloun</h4>
                        <p class="text-sm text-slate-500">Dr. Leila Fassi • Pédiatrie</p>
                    </div>
                    <span class="px-4 py-2 bg-green-500/10 text-green-600 rounded-lg text-sm font-semibold">Confirmé</span>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="bg-white rounded-3xl p-8 shadow-lg">
            <h2 class="text-2xl font-bold text-slate-800 mb-6">Actions Rapides</h2>

            <div class="space-y-4">
                <button class="w-full flex items-center gap-4 p-5 bg-gradient-to-r from-indigo-500 to-indigo-600 hover:from-indigo-600 hover:to-indigo-700 text-white rounded-2xl font-semibold hover:-translate-y-1 hover:shadow-xl transition-all">
                    <i class="fas fa-user-plus text-2xl"></i>
                    <span>Nouveau Patient</span>
                </button>

                <button class="w-full flex items-center gap-4 p-5 bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white rounded-2xl font-semibold hover:-translate-y-1 hover:shadow-xl transition-all">
                    <i class="fas fa-calendar-plus text-2xl"></i>
                    <span>Planifier Rendez-vous</span>
                </button>

                <button class="w-full flex items-center gap-4 p-5 bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white rounded-2xl font-semibold hover:-translate-y-1 hover:shadow-xl transition-all">
                    <i class="fas fa-file-medical text-2xl"></i>
                    <span>Créer Dossier</span>
                </button>

                <button class="w-full flex items-center gap-4 p-5 bg-gradient-to-r from-indigo-500 to-purple-600 hover:from-indigo-600 hover:to-purple-700 text-white rounded-2xl font-semibold hover:-translate-y-1 hover:shadow-xl transition-all">
                    <i class="fas fa-prescription text-2xl"></i>
                    <span>Nouvelle Prescription</span>
                </button>

                <button class="w-full flex items-center gap-4 p-5 bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-600 hover:to-teal-700 text-white rounded-2xl font-semibold hover:-translate-y-1 hover:shadow-xl transition-all">
                    <i class="fas fa-chart-bar text-2xl"></i>
                    <span>Voir Rapports</span>
                </button>
            </div>
        </div>
    </div>
</main>

</body>
</html>