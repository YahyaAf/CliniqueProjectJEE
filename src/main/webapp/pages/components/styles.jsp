<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Shared Styles -->
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

    .input-glow:focus {
        box-shadow: 0 0 0 3px rgba(20, 184, 166, 0.2);
    }
</style>