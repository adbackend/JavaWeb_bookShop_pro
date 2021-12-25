<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="myCartList" value="${cartMap.myCartList}"/>
<c:set var="myGoodsList" value="${cartMap.myGoodsList}"/>

<c:set var="totalGoodsNum" value="0"/> 			<!-- 주문개수 -->
<c:set var="totalDeliveryPrice" value="0"/> 	<!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0"/> 	<!-- 총 할인 금액 -->
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
			
			<c:choose>
				<c:when test="${empty myCartList}">
					<tr>
						<td colspan="8" class="fixed">
							<strong>장바구니에 상품이 없습니다.</strong>
						</td>
					</tr>
				</c:when>
			<c:otherwise>
				<tr>
				<form name="frm_order_all_cart">
					<c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
						<c:set var="cart_goods_qty" value="${myCartList[cnt.count-1].cart_goods_qty}"/>
						
						
						<c:set var="cart_id" value="${myCartList[cnt.count-1].cart_id}"/>
						
						<td><input type="checkbox" name="checked_goods" checked value="${item.goods_id}" onclick="calcGoodsPrice(${item.goods_sales_price},this)"/></td>
						<td class="goods_image">
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
								<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"/>	
							</a>
						</td>
						
						<td>
							<h2>
								<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title}</a>
							</h2>
						</td>
						
						<td class="price"><span>${item.goods_price}원</span></td>
						<td>
							<strong>
								<fmt:formatNumber type="number" value="${item.goods_sales_price*0.9}" var="discounted_price"/>
									${discounted_price}원(10%할인)
							</strong>
						</td>
						
						<td>
							<input type="text" id="cart_goods_qty" name="cart_goods_qty" value="${cart_goods_qty}" size="3"/><br>
								<a href="javascript:modify_cart_qty(${item.goods_id},${item.goods_sales_price*0.9},${cnt.count-1});">
									<img width="25" alt="" src="${contextPath}/resources/image/btn_modify_qty.jpg"/>
								</a>
						</td>
						
						
						<td>
							<strong>
								<fmt:formatNumber type="number" value="${item.goods_sales_price*0.9*cart_goods_qty}" var="total_sales_price"/>
									${total_sales_price}원
							</strong>
						</td>
						
						<td>
							<a href="javascript:fn_order_each_goods('${item.goods_id}','${item.goods_title}','${item.goods_sales_price}','${item.goods_fileName}');">
								<img width="75" alt="" src="${contextPath}/resources/image/btn_order.jpg">
							</a><br>
							
							<a href="#">
								<img width="75" alt="" src="${contextPath}/resources/image/btn_order_later.jpg"/>
							</a><br>
							
							<a href="javascript:delete_cart_goods('${cart_id}');">
								<img width="75" alt="" src="${contextPath}/resources/image/btn_delete.jpg"/>
							</a>
						</td>
				</tr>
						
						<c:set var="totalGoodsPrice" value="${totalGoodsPrice+item.goods_sales_price*0.9*cart_goods_qty}"/>
						<c:set var="totalGoodsNum" value="${totalGoodsNum+1}"/>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="clear"></div>
			</c:otherwise>
			</c:choose>
		
			<br><br>
			
			<table width="80%" class="list_view" style="background:#cacaff">
				<tbody>
					<tr align="center" class="fixed">
						<td class="fixed">총 상품수</td>
						<td>총 상품금액</td>
						<td></td>
						<td>총 배송비</td>
						<td></td>
						<td>총 할인 금액</td>
						<td></td>
						<td>최종 결제 금액</td>
					</tr>
					
					<tr cellpadding="40" align="center">
						<td id="">
							<p id="p_totalGoodsNum">${totalGoodsNum}개</p>
							<input id="h_totalGoodsNum" type="hidden" value="${totalGoodsNum}"/>
						</td>
						
						<td>
							<p id="p_totalGoodsPrice">
								<fmt:formatNumber type="number" value="${totalGoodsPrice}" var="total_goods_price"/>
									${total_goods_price}원
							</p>
							<input type="hidden" id="h_totalGoodsPrice" value="${totalGoodsPrice}"/>
						</td>
						
						<td>
							<img width="25" alt="" src="${contextPath}/resources/image/plus.jpg"/>
						</td>
						
						<td>
							<p id="p_totalDeliveryPrice">${totalDeliveryPrice}원</p>
							<input type="hidden" id="h_totalDeliveryPrice" value="${totalDeliveryPrice}"/>
						</td>
						
						<td>
							<img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"/>
						</td>
						
						<td>
							<p id="p_totalSalesPrice">${totalDiscountedPrice}원</p>
							<input type="hidden" id="h_totalSalesPrice" value="${totalSalesPrice}"/>
						</td>
						
						<td>
							<img width="25" alt="" src="${contextPath}/resources/image/equal.jpg"/>
						</td>
						
						<td>
							<p id="p_final_totalPrice">
								<fmt:formatNumber type="number" value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}" var="total_price"/>
									${total_price}원
							</p>
							<input type="hidden" id="h_final_totalPrice" value="${totalGoodsPrice+totalDeliveryPrice-totalDiscountedPrice}"/>
						</td>
					</tr>
				</tbody>
			</table>
			
			<center>
				<br><br>
					<a href="javascript:fn_order_all_cart_goods()">
						<img width="75" alt="" src="${contextPath}/resources/image/btn_order_final.jpg"/>
					</a>
					<a href="#">
		 				<img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg">
					</a>
			<center>
		</form>

























