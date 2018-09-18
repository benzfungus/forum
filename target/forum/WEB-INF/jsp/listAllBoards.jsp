<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<link href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.servletContext.contextPath}/js/js.cookie.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>论坛首页</title>
	<style>
		li {list-style-type:none;}
		html, body {
			height: 100%;
			font-size: 14px;
			color: #525252;
			font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
			background: #f0f2f5;
		}
	</style>
</head>
<body>
<%@ include file="includeTop.jsp" %>

	<ul class="list-group" style="width: 100%">
	<c:forEach var="board" items="${boards}">
		<li class="list-group-item">
			<div style="height: 50px">
				<div style="float: left;width: 5%">
					<img width="40px" height="40px" src="${pageContext.servletContext.contextPath}/img/icon/heart.svg" >
				</div>
				<div style="float: left;width: 3%">
	       	<c:if test="${USER_CONTEXT.type == 2}">
			          <input type="checkbox" name="boardIds" value="${board.id}"/>
			 </c:if>
				</div>
			<div style="width: 83%;float: left" >
			<a style="font-size: 25px" href="<c:url value="/board/listBoardTopics-${board.id}.html"/>">${board.name}</a>
				<div>
					<a><span class="label label-default" >${board.desc}</span></a>
				</div>
			</div>
			<div style="width: 9%;float: right;text-align: left">
				<span class="badge">共${board.topicNum}个帖子</span>
			</div>

			</div>
		</li>
	</c:forEach>
	</ul>
	    <c:if test="${USER_CONTEXT.type == 2 || isboardManager}">
	         <script>
	            function getSelectedBoardIds(){
	                var selectBoxs = document.all("boardIds");
	                if(!selectBoxs) return null;
	                if(typeof(selectBoxs.length) == "undefined" && selectBoxs.checked){   
	                    return selectBoxs.value;
	                }else{//many checkbox ,so is a array 
	                  var ids = "";
	                  var split = ""
	                  for(var i = 0 ; i < selectBoxs.length ; i++){
	                     if(selectBoxs[i].checked){
	                        ids += split+selectBoxs[i].value;
	                        split = ",";
	                     }
	                  }
	                  return ids;
	                }
	            }
	            function deleteBoards(){
	               var ids = getSelectedBoardIds();
	               if(ids){
	                  var url = "<c:url value="/board/removeBoard.html"/>?boardIds="+ids+"";
	                  //alert(url);
	                  location.href = url;
	               }
	            }
	           
	         </script>
			<input type="button" class="btn btn-warning" value="删除" onclick="deleteBoards()">
		</c:if>
</body>
</html>
