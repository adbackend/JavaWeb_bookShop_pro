<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<c:if test="${not empty message}">
	<script>
		window.onload=function(){
			result();
		}
		
		function result(){
			alert("아이디나 비밀번호가 틀립니다.");
		}
	</script>
	
</c:if>

<meta charset="UTF-8">
</head>
<body>
	<h3>회원 로그인창</h3>
	<div id="detail_table">
		<form action="${contextPath}/member/login.do" method="post">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">아이디</td>
						<td><input type="text" name="member_id" size="20"/></td>
					</tr>
					
					<tr class="solid_line">
						<td class="fixed_join">비밀번호</td>
						<td><input type="password" name="member_pw" size="20"/></td>
					</tr>
				</tbody>
			</table>
			<br><br>
			<input type="submit" value="로그인"/>
			<input type="reset" value="초기화"/>
			
			<br><br>
			<a href="#">아이디 찾기</a>
			<a href="#">비밀번호 찾기</a>
			<a href="${contextPath}/member/addMember.do">회원가입</a>
			<a href="#">고객센터</a>
		</form>
	</div>
</body>
</html>