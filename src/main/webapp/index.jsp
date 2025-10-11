<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale - Votre Santé, Notre Priorité</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
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
            animation: float 6s ease-in-out infinite;
        }

        .glow-pulse {
            animation: pulse-glow 3s ease-in-out infinite;
        }

        .slide-up {
            animation: slide-up 0.8s ease-out forwards;
        }

        .card-hover {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-10px) scale(1.02);
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
                <span class="text-2xl font-bold bg-gradient-to-r from-teal-400 to-teal-500 bg-clip-text text-transparent">MediCare+</span>
            </div>

            <div class="hidden md:flex items-center space-x-8">
                <a href="#" class="hover:text-teal-400 transition-colors">Accueil</a>
                <a href="#services" class="hover:text-teal-400 transition-colors">Services</a>
                <a href="#doctors" class="hover:text-teal-400 transition-colors">Nos Docteurs</a>
                <a href="#contact" class="hover:text-teal-400 transition-colors">Contact</a>
            </div>

            <div class="flex items-center space-x-4">
                <button class="px-6 py-2 rounded-full border border-teal-500/50 hover:bg-teal-600 hover:text-white transition-all duration-300">
                    Connexion
                </button>
                <button class="px-6 py-2 rounded-full bg-gradient-to-r from-teal-600 to-teal-700 hover:shadow-lg hover:shadow-teal-600/30 transition-all duration-300">
                    S'inscrire
                </button>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="relative container mx-auto px-6 pt-20 pb-32">
    <div class="grid md:grid-cols-2 gap-12 items-center">
        <div class="space-y-8 slide-up">
            <div class="inline-block px-4 py-2 bg-teal-600/20 rounded-full border border-teal-500/30">
                <span class="text-teal-400 text-sm font-semibold">🏥 Plateforme de Santé Nouvelle Génération</span>
            </div>

            <h1 class="text-4xl md:text-5xl font-bold leading-tight">
                Votre Santé,
                <span class="bg-gradient-to-r from-teal-400 via-teal-500 to-emerald-400 bg-clip-text text-transparent">
                        Réinventée
                    </span>
            </h1>

            <p class="text-lg text-gray-300 leading-relaxed">
                Découvrez une expérience médicale digitale unique. Consultation instantanée, suivi personnalisé et intelligence artificielle pour votre bien-être.
            </p>

            <div class="flex flex-col sm:flex-row gap-4">
                <button class="group px-8 py-4 bg-gradient-to-r from-teal-600 to-teal-700 rounded-2xl font-semibold hover:shadow-2xl hover:shadow-teal-600/40 transition-all duration-300 flex items-center justify-center space-x-2">
                    <span>Prendre RDV Maintenant</span>
                    <svg class="w-5 h-5 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
                    </svg>
                </button>

                <button class="px-8 py-4 border-2 border-gray-600 rounded-2xl font-semibold hover:bg-gray-800 transition-all duration-300 flex items-center justify-center space-x-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span>Voir la Démo</span>
                </button>
            </div>

            <div class="flex items-center space-x-6 pt-4">
                <div>
                    <div class="text-3xl font-bold text-teal-400">15K+</div>
                    <div class="text-gray-400 text-xs">Patients Satisfaits</div>
                </div>
                <div class="w-px h-10 bg-gray-700"></div>
                <div>
                    <div class="text-3xl font-bold text-teal-500">500+</div>
                    <div class="text-gray-400 text-xs">Docteurs Experts</div>
                </div>
                <div class="w-px h-10 bg-gray-700"></div>
                <div>
                    <div class="text-3xl font-bold text-emerald-400">24/7</div>
                    <div class="text-gray-400 text-xs">Support Disponible</div>
                </div>
            </div>
        </div>

        <!-- Doctor Image -->
        <div class="relative float-animation hidden md:flex justify-center">
            <div class="relative">
                <div class="absolute top-0 right-0 w-60 h-60 bg-teal-600/20 rounded-full blur-3xl"></div>
                <div class="absolute bottom-0 left-0 w-60 h-60 bg-emerald-600/20 rounded-full blur-3xl"></div>

                <div class="relative z-10">
                    <img src="https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=500&fit=crop"
                         alt="Doctor"
                         class="w-80 h-96 object-cover rounded-3xl shadow-2xl border-2 border-teal-500/30">

                    <!-- Info Cards -->
                    <div class="absolute -bottom-6 -left-6 glass-effect rounded-2xl p-4 card-hover">
                        <div class="flex items-center space-x-3">
                            <div class="w-12 h-12 bg-gradient-to-br from-teal-500 to-teal-700 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="text-2xl font-bold text-teal-400">98%</div>
                                <div class="text-xs text-gray-400">Satisfaction</div>
                            </div>
                        </div>
                    </div>

                    <div class="absolute -top-6 -right-6 glass-effect rounded-2xl p-4 card-hover">
                        <div class="flex items-center space-x-3">
                            <div class="w-12 h-12 bg-gradient-to-br from-emerald-500 to-emerald-700 rounded-xl flex items-center justify-center">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <div class="text-sm font-bold text-emerald-400">Disponible</div>
                                <div class="text-xs text-gray-400">24/7</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="services" class="relative container mx-auto px-6 py-20">
    <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold mb-4">
            Services <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">Innovants</span>
        </h2>
        <p class="text-lg text-gray-400">Des fonctionnalités pensées pour votre confort</p>
    </div>

    <div class="grid md:grid-cols-3 gap-8">
        <!-- Card 1 -->
        <div class="glass-effect rounded-3xl p-8 card-hover">
            <div class="w-16 h-16 bg-gradient-to-br from-teal-600 to-teal-700 rounded-2xl flex items-center justify-center mb-6 glow-pulse">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
            </div>
            <h3 class="text-2xl font-bold mb-3">Réservation Intelligente</h3>
            <p class="text-gray-400 leading-relaxed">Algorithme IA pour trouver le créneau parfait selon vos préférences et urgence.</p>
        </div>

        <!-- Card 2 -->
        <div class="glass-effect rounded-3xl p-8 card-hover">
            <div class="w-16 h-16 bg-gradient-to-br from-emerald-600 to-emerald-700 rounded-2xl flex items-center justify-center mb-6 glow-pulse">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
            </div>
            <h3 class="text-2xl font-bold mb-3">Dossier Médical Digital</h3>
            <p class="text-gray-400 leading-relaxed">Historique complet, ordonnances et résultats accessibles en un clic, sécurisé.</p>
        </div>

        <!-- Card 3 -->
        <div class="glass-effect rounded-3xl p-8 card-hover">
            <div class="w-16 h-16 bg-gradient-to-br from-teal-500 to-emerald-600 rounded-2xl flex items-center justify-center mb-6 glow-pulse">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                </svg>
            </div>
            <h3 class="text-2xl font-bold mb-3">Téléconsultation HD</h3>
            <p class="text-gray-400 leading-relaxed">Consultez vos médecins en vidéo haute qualité, où que vous soyez dans le monde.</p>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="relative container mx-auto px-6 py-20">
    <div class="glass-effect rounded-3xl p-12 text-center card-hover">
        <h2 class="text-3xl md:text-4xl font-bold mb-6">
            Prêt à transformer votre <span class="bg-gradient-to-r from-teal-400 to-emerald-400 bg-clip-text text-transparent">expérience santé</span> ?
        </h2>
        <p class="text-lg text-gray-300 mb-8 max-w-2xl mx-auto">
            Rejoignez des milliers de patients qui ont déjà choisi l'excellence médicale digitale.
        </p>
        <button class="px-10 py-4 bg-gradient-to-r from-teal-600 to-teal-700 rounded-2xl font-semibold hover:shadow-2xl hover:shadow-teal-600/40 transition-all duration-300">
            Commencer Gratuitement
        </button>
    </div>
</section>

<!-- Footer -->
<footer class="relative container mx-auto px-6 py-12 border-t border-gray-800">
    <div class="text-center text-gray-400">
        <p>© 2025 MediCare+ - Votre santé, notre innovation</p>
    </div>
</footer>

</body>
</html>