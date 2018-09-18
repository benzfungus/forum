<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="baobaotao" tagdir="/WEB-INF/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>论坛版块页面</title>
		<link href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" rel="stylesheet">
		<script src="${pageContext.servletContext.contextPath}/js/jquery-3.2.1.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/js/js.cookie.js"></script>
		<style>

			li {list-style-type:none;}
			html, body {
				height: 100%;
				font-size: 14px;
				color: #525252;
				font-family: NotoSansHans-Regular,AvenirNext-Regular,arial,Hiragino Sans GB,"Microsoft Yahei","Hiragino Sans GB","WenQuanYi Micro Hei",sans-serif;
				background: #f0f2f5;
			}
			a{
				color: #8A8A8A;
				cursor: pointer;
			}
		</style>
	</head>
	<body>
		<%@ include file="includeTop.jsp"%>
	<div>
		<ul class="list-group" style="width: 100%">
			<li class="list-group-item">
				<div style="height: 50px">
					<div style="font-size:40px;float: left;width:91%;margin-bottom: 5px">
						<c:if test="${USER_CONTEXT.type == 2 || isboardManager}">
						</c:if>
						${board.name}
					</div>
					<div style="width: 9%;float: right;text-align: left">
						<a href="<c:url value="/board/addTopicPage-${board.id}.html"/>">发表新话题</a>
					</div>
				</div>
			<c:set var="isboardManager" value="${false}" />
			<c:forEach items="${USER_CONTEXT.manBoards}" var="manBoard">
				<c:if test="${manBoard.id == board.id}">
					<c:set var="isboardManager" value="${true}" />
				</c:if>
			</c:forEach>
			</li>
		</ul>
		<ul class="list-group" style="width: 100%">
			<li class="list-group-item">

			<c:forEach var="topic" items="${pagedTopic.data}">
				<div style="height: 50px">
				<div style="float: left;width: 3%">
				    <c:if test="${USER_CONTEXT.type == 2 || isboardManager}">
			          <input type="checkbox" name="topicIds" value="${topic.id}"/>
			        </c:if>
				</div>
				<div style="width: 83%;float: left">
					<div style="font-size: 25px">
						<a  href="<c:url value="/board/listTopicPosts-${topic.id}.html"/>">
							<c:if test="${topic.digest > 0}">
							  <font color=red>★</font>
							</c:if>
							${topic.title}
							</a></div>
					<span class="label label-info" >
						<span >创建者:<strong>${topic.user.username}</strong></span>
						<small class="text-muted">创建时间:
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${topic.createTime}" />
						</small>
						<small class="text-muted">修改时间:
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${topic.lastPost}" />
						</small>
						</span>
					</div>

				<div style="width: 14%;float: right;text-align: center">
					<span class="badge">回贴数:${topic.replyNum}</span>
				</div>
				</div>

			</c:forEach>

			</li>
		</ul>
		</div>

		<baobaotao:PageBar
			   pageUrl="/board/listBoardTopics-${board.id}.html"
			   pageAttrKey="pagedTopic"/>

	    <c:if test="${USER_CONTEXT.type == 2 || isboardManager}">
	         <script>
	            function getSelectedTopicIds(){
	                var selectBoxs = document.all("topicIds");
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
	            function deleteTopics(){
	               var ids = getSelectedTopicIds();
	               if(ids){
	                  var url = "<c:url value="/board/removeTopic.html"/>?topicIds="+ids+"&boardId=${board.id}";
	                  //alert(url);
	                  location.href = url;
	               }
	            }
	            function setDefinedTopis(){
	               var ids = getSelectedTopicIds();
	               if(ids){
	                  var url = "<c:url value="/board/makeDigestTopic.html"/>?topicIds="+ids+"&boardId=${board.id}";
	                  location.href = url;
	               }	            
	            }
	         </script>
			<input type="button" class="btn btn-warning" value="删除" onclick="deleteTopics()">
			<input type="button" class="btn btn-success" value="置精华帖" onclick="setDefinedTopis()">
		</c:if>

	</body>
</html>
