<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="baobaotao" tagdir="/WEB-INF/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/js.cookie.js"></script>
<title>${topic.title}</title>
</head>
<body>
<%@ include file="includeTop.jsp" %>
<div style="float:right"><a href="#replyZone">回复</a></div>
<table border="1px" width="100%">
	<c:forEach var="post" items="${pagedPost.data}">
		<tr>
			<td colspan="2">${post.title}</td>
		</tr>
		<tr>
			<td width="20%">
			用户：${post.user.username}<br>
			时间：<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${post.createTime}"/></td>
			<td>${post.text}</td>
		</tr>
	</c:forEach>
</table>
<baobaotao:PageBar 
	  pageUrl="/board/listTopicPosts-${topic.id}.html"
	  pageAttrKey="pagedPost"/>

	<script>
	   function mySubmit(){
	      with(document){
	         var postTitle = getElementById("post.postTitle");
	         if(postTitle.value != null && postTitle.value.length > 50){
	            alert("帖子标题最大长度不能超过50个字符，请调整.");
	            postTitle.focus();
	            return false;
	         }
	          
	         var postText = getElementById("post.postText");
	         if(postText.value == null || postText.value.length < 10){
	            alert("回复帖子内容不能小于10个字符。");
	            postText.focus();
	            return false;
	         }
	           
	         return true;
	      }
	      
	   }
	</script>			   
<form action="<c:url value="/board/addPost.html"/>" method="post" onsubmit="return mySubmit()">
<hr><A NAME="replyZone"/>
<table border="1px" width="100%">
	<tr>
		<td width="20%">标题</td>
		<td width="80%"><input type="text" name="title" style="width:100%" /></td>
	</tr>
	<tr>
		<td width="20%">内容</td>
		<td width="80%"><textarea style="width:100%;height:100px"  name="text"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="right">
		   <input type="submit" class="btn btn-success" value="保存">
		   <input type="reset" class="btn btn-warning" value="重置">

		   <input type="hidden" name="board.id" value="${topic.board.id}"/>
		   <input type="hidden" name="topic.id" value="${topic.id}"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>

