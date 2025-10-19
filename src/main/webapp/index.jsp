<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale - Votre Santé, Notre Priorité</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <jsp:include page="/pages/components/styles.jsp" />
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-15px) rotate(3deg); }
        }

        @keyframes pulse-glow {
            0%, 100% { box-shadow: 0 0 15px rgba(20, 184, 166, 0.3); }
            50% { box-shadow: 0 0 30px rgba(20, 184, 166, 0.5); }
        }

        @keyframes slide-up {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .float-animation {
            animation: float 5s ease-in-out infinite;
        }

        .glow-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
        }

        .slide-up {
            animation: slide-up 0.6s ease-out forwards;
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-6px) scale(1.01);
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
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-black text-gray-100 overflow-x-hidden">

<!-- Animated Background -->
<div class="fixed inset-0 mesh-gradient opacity-30 pointer-events-none"></div>

<jsp:include page="/pages/components/navbar.jsp" />

<!-- Hero Section - Compact -->
<section class="relative container mx-auto px-6 pt-16 pb-24">
    <div class="grid md:grid-cols-2 gap-10 items-center">
        <div class="space-y-6 slide-up">
            <div class="inline-block px-3 py-1.5 bg-teal-600/20 rounded-full border border-teal-500/30">
                <span class="text-teal-400 text-xs font-semibold">🏥 Plateforme de Santé Nouvelle Génération</span>
            </div>

            <h1 class="text-3xl md:text-4xl font-bold leading-tight">
                Votre Santé,
                <span class="bg-gradient-to-r from-teal-400 via-teal-500 to-emerald-400 bg-clip-text text-transparent">
                    Réinventée
                </span>
            </h1>

            <p class="text-base text-gray-300 leading-relaxed">
                Découvrez une expérience médicale digitale unique. Consultation instantanée, suivi personnalisé et intelligence artificielle pour votre bien-être.
            </p>

            <div class="flex flex-col sm:flex-row gap-3">
                <button class="group px-6 py-3 bg-gradient-to-r from-teal-600 to-teal-700 rounded-xl font-semibold text-sm hover:shadow-xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center justify-center space-x-2">
                    <span>Prendre RDV Maintenant</span>
                    <svg class="w-4 h-4 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                    </svg>
                </button>

                <button class="px-6 py-3 border-2 border-gray-600 rounded-xl font-semibold text-sm hover:bg-gray-800 transition-all duration-300 flex items-center justify-center space-x-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Voir la Démo</span>
                </button>
            </div>

            <div class="flex items-center space-x-4 pt-3">
                <div>
                    <div class="text-2xl font-bold text-teal-400">15K+</div>
                    <div class="text-gray-400 text-[10px]">Patients Satisfaits</div>
                </div>
                <div class="w-px h-8 bg-gray-700"></div>
                <div>
                    <div class="text-2xl font-bold text-teal-500">500+</div>
                    <div class="text-gray-400 text-[10px]">Docteurs Experts</div>
                </div>
                <div class="w-px h-8 bg-gray-700"></div>
                <div>
                    <div class="text-2xl font-bold text-emerald-400">24/7</div>
                    <div class="text-gray-400 text-[10px]">Support Disponible</div>
                </div>
            </div>
        </div>

        <!-- Doctor Image - Compact -->
        <div class="relative float-animation hidden md:flex justify-center">
            <div class="relative">
                <div class="absolute top-0 right-0 w-48 h-48 bg-teal-600/20 rounded-full blur-3xl"></div>
                <div class="absolute bottom-0 left-0 w-48 h-48 bg-emerald-600/20 rounded-full blur-3xl"></div>

                <div class="relative z-10">
                    <img src="https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=500&fit=crop"
                         alt="Doctor"
                         class="w-64 h-80 object-cover rounded-2xl shadow-2xl border-2 border-teal-500/30">

                    <!-- Info Cards - Compact -->
                    <div class="absolute -bottom-4 -left-4 glass-effect rounded-xl p-3 card-hover">
                        <div class="flex items-center space-x-2">
                            <div class="w-10 h-10 bg-gradient-to-br from-teal-500 to-teal-700 rounded-lg flex items-center justify-center">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="text-xl font-bold text-teal-400">98%</div>
                                <div class="text-[10px] text-gray-400">Satisfaction</div>
                            </div>
                        </div>
                    </div>

                    <div class="absolute -top-4 -right-4 glass-effect rounded-xl p-3 card-hover">
                        <div class="flex items-center space-x-2">
                            <div class="w-10 h-10 bg-gradient-to-br from-emerald-500 to-emerald-700 rounded-lg flex items-center justify-center">
                                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="text-xs font-bold text-emerald-400">Disponible</div>
                                <div class="text-[10px] text-gray-400">24/7</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section - Compact -->
<section id="services" class="relative container mx-auto px-6 py-16">
    <div class="text-center mb-12">
        <h2 class="text-2xl md:text-3xl font-bold mb-3">
            Services <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Innovants</span>
        </h2>
        <p class="text-base text-gray-400">Des fonctionnalités pensées pour votre confort</p>
    </div>

    <div class="grid md:grid-cols-3 gap-6">
        <!-- Card 1 - Compact -->
        <div class="glass-effect rounded-2xl p-6 card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-teal-600 to-teal-700 rounded-xl flex items-center justify-center mb-4 glow-pulse">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
            </div>
            <h3 class="text-xl font-bold mb-2">Réservation Intelligente</h3>
            <p class="text-sm text-gray-400 leading-relaxed">Algorithme IA pour trouver le créneau parfait selon vos préférences et urgence.</p>
        </div>

        <!-- Card 2 - Compact -->
        <div class="glass-effect rounded-2xl p-6 card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-emerald-600 to-emerald-700 rounded-xl flex items-center justify-center mb-4 glow-pulse">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
            </div>
            <h3 class="text-xl font-bold mb-2">Dossier Médical Digital</h3>
            <p class="text-sm text-gray-400 leading-relaxed">Historique complet, ordonnances et résultats accessibles en un clic, sécurisé.</p>
        </div>

        <!-- Card 3 - Compact -->
        <div class="glass-effect rounded-2xl p-6 card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-teal-500 to-emerald-600 rounded-xl flex items-center justify-center mb-4 glow-pulse">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                </svg>
            </div>
            <h3 class="text-xl font-bold mb-2">Téléconsultation HD</h3>
            <p class="text-sm text-gray-400 leading-relaxed">Consultez vos médecins en vidéo haute qualité, où que vous soyez dans le monde.</p>
        </div>
    </div>
</section>

<!-- CTA Section - Compact -->
<section class="relative container mx-auto px-6 py-16">
    <div class="glass-effect rounded-2xl p-10 text-center card-hover">
        <h2 class="text-2xl md:text-3xl font-bold mb-4">
            Prêt à transformer votre <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">expérience santé</span> ?
        </h2>
        <p class="text-base text-gray-300 mb-6 max-w-2xl mx-auto">
            Rejoignez des milliers de patients qui ont déjà choisi l'excellence médicale digitale.
        </p>
        <button class="px-8 py-3 bg-gradient-to-r from-teal-600 to-teal-700 rounded-xl text-sm font-semibold hover:shadow-xl hover:shadow-teal-600/40 transition-all duration-300">
            Commencer Gratuitement
        </button>
    </div>
</section>

<!-- Footer -->
<jsp:include page="/pages/components/footer.jsp" />

</body>
</html>