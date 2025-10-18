<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full">
        <div class="bg-white rounded-lg shadow-xl overflow-hidden">

            <!-- Error Icon -->
            <div class="bg-red-600 py-8 text-center">
                <i class="fas fa-exclamation-triangle text-white text-6xl"></i>
            </div>

            <!-- Error Content -->
            <div class="p-8">
                <h2 class="text-2xl font-bold text-gray-900 text-center mb-4">
                    Oops! Something went wrong
                </h2>

                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6">
                        <div class="flex items-center">
                            <i class="fas fa-exclamation-circle text-red-500 mr-3"></i>
                            <p class="text-red-700">${errorMessage}</p>
                        </div>
                    </div>
                </c:if>

                <!-- Default Message -->
                <c:if test="${empty errorMessage}">
                    <div class="bg-gray-50 border-l-4 border-gray-400 p-4 mb-6">
                        <p class="text-gray-700 text-center">
                            An unexpected error occurred. Please try again later.
                        </p>
                    </div>
                </c:if>

                <!-- Action Buttons -->
                <div class="space-y-3">
                    <a href="javascript:history.back()"
                       class="w-full block bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg text-center transition duration-200">
                        <i class="fas fa-arrow-left mr-2"></i>Go Back
                    </a>

                    <a href="${pageContext.request.contextPath}/"
                       class="w-full block bg-gray-200 hover:bg-gray-300 text-gray-800 font-semibold py-3 px-4 rounded-lg text-center transition duration-200">
                        <i class="fas fa-home mr-2"></i>Go to Homepage
                    </a>
                </div>

                <!-- Support Info -->
                <div class="mt-6 pt-6 border-t border-gray-200 text-center">
                    <p class="text-sm text-gray-600">
                        Need help?
                        <a href="${pageContext.request.contextPath}/contact" class="text-blue-600 hover:text-blue-800 font-semibold">
                            Contact Support
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>