<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
<style>

</style>

<script>

</script>
</head>
<body>
	<h1>주문 확인</h1>
	
	<form name="form_order">
		<table class="list_view">
			<tbody align="center">
				<tr style="background:#33ff00">
					<td colspan="2" class="fixed">주문 상품명</td>
					<td>수량</td>
					<td>주문금액</td>
					<td>배송비</td>
					<td>예상 적립금</td>
					<td>주문금액 합계</td>
				</tr>
				<tr>
					<c:forEach var="item" items="${myOrderList}">
						<td class="goods_image">
							<a href="#{contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
								<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"/>
								<input type="hidden" id="h_goods_id" name="h_goods_id" value="${item.goods_id}"/>
								<input type="hidden" id="h_goods_fileName" name="h_goods_fileName" value="${item.goods_fileName}"/>
							</a>
						</td>
						
						<td>
							<h2>
								<a href="${contextPath}/goods/goods.do?command=goods_detail&goods_id=${item.goods_id}">${item.goods_title}</a>
								<input type="hidden" id="h_goods_title" name="h_goods_title" value="${item.goods_title}"/>
							</h2>
						</td>
						
						<td>
							<h2>${item.order_goods_qty}개</h2>
							<input type="hidden" id="h_order_goods_qty" name="h_order_goods_qty" value="${item.order_goods_qty}"/>
						</td>
						
						<td><h2>${item.goods_sales_price}원(10%할인)</h2></td>
						<td><h2>0원</h2></td>
						<td><h2>${1500*item.order_goods_qty}원</h2></td>
						
						<td>
							<h2>${item.goods_sales_price* item.order_goods_qty}원</h2>
							<input type="hidden" id="h_each_goods_price" name="h_each_goods_price" value="${item.goods_sales_price*item.order_goods_qty}"/>
						</td>
						<c:set var="final_total_order_price" value="${fianl_total_order_price+item.goods_sales_price*item.order_goods_qty}"/>
						<c:set var="total_order_price" value="${total_order_price+item.goods_sales_price*item.order_goods_qty}"/>
						<c:set var="total_order_goods_qty" value="${total_order_goods_qty+item.order_goods_qty}"/>
					</c:forEach>
				</tr>
			</tbody>
		</table>
		
		<div class="clear"></div>
		<br>
		<br>
		
		<h1>배송지 정보</h1>
		<div class="detail_table">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">배송방법</td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		
	</form>
</body>






















