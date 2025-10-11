<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 11/10/2025
  Time: 17:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center min-h-screen">

<div class="bg-white shadow-lg rounded-2xl p-8 w-full max-w-md">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Login</h2>

    <!-- Error messages -->
    <c:if test="${not empty errors}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <ul class="list-disc pl-5">
                <c:forEach var="err" items="${errors}">
                    <li>${err}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <!-- Login form -->
    <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-4">
        <div>
            <label class="block text-gray-700">Email</label>
            <input type="email" name="email"
                   class="w-full p-2 border border-gray-300 rounded-md focus:ring focus:ring-blue-200"
                   placeholder="Enter your email">
        </div>

        <div>
            <label class="block text-gray-700">Password</label>
            <input type="password" name="password"
                   class="w-full p-2 border border-gray-300 rounded-md focus:ring focus:ring-blue-200"
                   placeholder="Enter your password">
        </div>

        <button type="submit"
                class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 transition">
            Login
        </button>
    </form>

    <p class="text-center text-gray-600 text-sm mt-4">
        Don’t have an account?
        <a href="${pageContext.request.contextPath}/pages/auth/registerPatient.jsp" class="text-blue-500 hover:underline">
            Register
        </a>
    </p>
</div>

</body>
</html>
