<%--
  Created by IntelliJ IDEA.
  User: 大聪
  Date: 2017/12/9
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="basic.jsp"%>
</head>
<body>
    <div class="col-lg-2">
        <ul class="nav nav-pills nav-stacked">
            <li role="presentation">
                <a href="${pageContext.request.contextPath}/grade/grade?pageNum=1&pageSize=3">班级管理</a>
            </li>
            <li role="presentation">
                <a href="${pageContext.request.contextPath}/student/queryAllStudent?pageNum=1&pageSize=3">学生管理</a>
            </li>
        </ul>
    </div>
</body>
</html>
