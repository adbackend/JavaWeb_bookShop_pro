<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<body>
	<div id="logo">
		<a href="${contextPath}/main/main.do">
			<img width="176" height="80" alt="booktopia" src="${contextPath}/resources/image/Booktopia_Logo.jpg">
		</a>
	</div>
	
	<div id="head_link">
		<ul>
			<c:choose>
				<c:when test="">
					<li><a href="${contextPath}/member/logout.do">로그아웃</a></li>
					<li><a href="${contextPath}/">마이페이지</a></li>
					<li><a href="${contextPath}/">장바구니</a></li>
					<li><a href="#">주문배송</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${contextPath}/member/loginForm.do">로그인</a></li>
					<li><a href="${contextPath}/member/memberForm.do">회원가입</a></li>
				</c:otherwise>
			</c:choose>
				<li><a href="#">고객센터</a></li>
				
				<c:if test="${isLogOn==true and memberInfo.member_id=='admin'}">
					<li class="no_line"><a href="#">관리자</a></li>
				</c:if>
		</ul>	
	</div>
	
	<br>
	
	<div id="search">
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do">
			<input type="text" name="searchWord" class="main_input" onKeyUp="keywordSearch()"/>
			<input type="submit" name="search" class="btn1" value="검색"/>
		</form>
	</div>
	<div id="suggest">
		<div id="suggestList"></div>
	</div>
</body>




