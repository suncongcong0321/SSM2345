<%--
  Created by IntelliJ IDEA.
  User: 大聪
  Date: 2017/12/9
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="basic.jsp"%>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-6">
                <div class="page-header">
                    <h1>学生管理系统</h1>
                    欢迎${loginUser.nickName}
                    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
