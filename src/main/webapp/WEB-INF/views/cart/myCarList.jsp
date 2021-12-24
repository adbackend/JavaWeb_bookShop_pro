<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="myCartList" value="${cartMap.}"/>
<head>
<script>
</script>
</head>
<body>
	<table class="list_view">
		<tbody align="center">
			<tr style="background:#33ff00">
				<td class="fixed">구분</td>
				<td colspan="2" class="fixed">상품명</td>
				<td>정가</td>
				<td>판매가</td>
				<td>수량</td>
				<td>합계</td>
				<td>주문</td>
			</tr>
		</tbody>
	</table>

</body>




