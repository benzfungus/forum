<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <link href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
        <script src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.servletContext.contextPath}/js/js.cookie.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>用户注册</title>
        <script>
            function mycheck() {
                if(document.all("user.password").value != document.all("again").value){
                    alert("两次输入的密码不正确, 请更正!");
                    return false;
                }else {
                    return true;
                }
            }
        </script>
    </head>
    <body>
        <form action="<c:url value='register.html' />" method="post" onsubmit="return mycheck()">
            <div class="panel panel-default" id="register" style="width: 20%;margin-left: 40%;margin-top: 5%;margin-bottom: 5%">
                <div class="panel-heading" style="background-color: #fff">
                    <h3 class="panel-title">用户注册:</h3>
                </div>
                <div class="panel-body">
            <c:if test="${!empty errorMsg}">
                <div style="color:red">${errorMsg}</div>
            </c:if>
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" required="required">
                </div>
                <div class="form-group">
                    <label for="password">密码</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required="required">
                </div>

            <div class="form-group">
                <label for="again">重复输入密码</label>
                <input type="password" class="form-control" id="again" name="again" placeholder="请重复输入密码" required="required">
            </div>
            <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
            <input id="loginButton" type="submit" value="注册" class="btn btn-success btn-block"/>
                </div>
            </div>
        </form>
    </body>
</html>