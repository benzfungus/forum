<%@ page contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<link href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/js.cookie.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发表新话题</title>
	<script>
	   function mySubmit(){
	      with(document){
	         var topicTitle = getElementById("topicTitle");
	         if(topicTitle.value == null || topicTitle.value.length ==0){
	            alert("话题标题不能为空，请填上.");
	            topicTitle.focus();
	            return false;
	         }else if(topicTitle.value.length > 100){
	            alert("话题标题最大长度不能超过100个字符，请调整.");
                 topicTitle.focus();
	            return false;
	         }
	          
	         var postText = getElementById("mainPost.postText");
	         if(postText.value == null || postText.value.length < 10 ){
	            alert("话题的内容必须大于10个字符");
	            postText.focus();
	            return false;
	         }
	           
	         return true;
	      }
	      
	   }
	</script>
</head>
<body>
<%@ include file="includeTop.jsp" %>
<form action="<c:url value="/board/addTopic.html" />" method="post" onsubmit="return mySubmit()">
<table border="1px" width="100%">
	<tr>
		<td width="20%">标题</td>
		<td width="80%">
		<input style="width:80%;"  name="title" value="${topic.title}">
	</tr>
	<tr>
		<td width="20%">内容</td>
		<td width="80%">
		<textarea style="width:100%;height:400px"  name="mainPost.text">${topic.mainPost.text}</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="submit" class="btn btn-success" value="保存">
			<input type="reset" class="btn btn-warning" value="重置">
		   <input type="hidden" name="board.id" value="${boardId}">
		</td>
	</tr>
</table>
</form>
</body>
</html>
