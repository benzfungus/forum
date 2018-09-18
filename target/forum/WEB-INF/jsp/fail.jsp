<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <link href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
    <script src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.servletContext.contextPath}/js/js.cookie.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>操作失败</title>
</head>
<body>
    操作失败!错误信息：${errorMsg}<br>
    <input type="button" class="btn btn-primary"  value="返回" onClick="window.history.go(-1);">
</body>
</html>
