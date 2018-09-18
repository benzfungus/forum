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
<title>用户锁定及解锁</title>
</head>
<body>
<%@ include file="includeTop.jsp" %>
<form action="${context}/forum/userLockManage.html" method="post" >
<table border="1px" width="100%">
	<tr>
		<td width="20%">用户</td>
		<td width="80%"><select name="username">
		     <option>请选择</option>
		     <c:forEach var="user" items="${users}">
		       <option value="${user.username}">${user.username}</option>
		     </c:forEach>
		</select></td>
	</tr>
	<tr>
		<td width="20%">锁定/解锁</td>
		<td width="80%">
		   <input type="radio" name="locked" value="1" />锁定 
		   <input type="radio" name="locked" value="0" />解锁
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" class="btn btn-success" value="保存">
			<input type="reset" class="btn btn-warning" value="重置">
		</td>
	</tr>
</table>
</form>
</body>
</html>
