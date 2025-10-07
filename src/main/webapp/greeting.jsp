<%--
  Created by IntelliJ IDEA.
  User: Youcode
  Date: 07/10/2025
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
     <h2>Entre votre name here :</h2>
     <form action="${pageContext.request.contextPath}/greet" method="get">
         <input type="text" name="name" placeholder="Votre nom">
         <button type="submit">Envoyer</button>
     </form>
</body>
</html>
