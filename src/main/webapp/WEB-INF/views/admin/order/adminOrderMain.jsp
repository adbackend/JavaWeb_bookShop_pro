<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script>
	window.onload = function(){
		end_date = new Date();
		
		end_date = end_date.toISOString().slice(0,10);
		bir = document.getElementById("end_date");
		bir.value=end_date;
	}
	
	
	
	function search_order_history(search_period){
		
		temp = calcPeriod(search_period);
		
	}
	
	function calcPeriod(search_period){
		var dt = new Date();
		var beginYear, endYear;
		var beginMonth, endMonth;
		var beginDay, endDay;
		var beginDate, endDate;
		
		endYear = dt.getFullYear();
		endMonth = dt.getMonth()+1;
		endDay = dt.getDate();
		
		if(search_period=='today'){
			beginYear = endYear;
			beginMonth = endMonth;
			beginDay = endDay;
		}else(search_period=='one_week'){
			beginYear = dt.getFullYear();
			beginMonth = dt.getMonth()+1;
			dt.setDate(endDay-7);
			beginDay = dt.getDate();
		}
	}
	
</script>
<body>
	<h3>주문조회</h3>
	<form name="frm_delivery_list" action="${contextPath}/amdin/admin.do" method="post">
		<table>
			<tbody>
				<tr>
					<td>
						<input type="radio" name="r_search_option" value="simple_search" checked onclick="fn_enable_detail_search(this)"/>간단조회 &nbsp;&nbsp;
						<input type="radio" name="r_search_option" value="detail_search" onclick="fn_enable_detail_search(this)"/>상세조회 &nbsp;&nbsp;
					</td>
				</tr>
				
				<tr>
					<td>
						<select name="curYear">
							<c:forEach var="i" begin="0" end="5">
								<c:choose>
									<c:when test="${endYear==endYear-i}">
										<option value="${endYear}" selected>${endYear}</option>
									</c:when>
									<c:otherwise>
										<option value="${endYear-i}">${endYear-i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>년
						
						<select name="curMonth">
							<c:forEach var="i" begin="1" end="12">
								<c:choose>
									<c:when test="${endMonth==i}">
										<option value="${i}" selected>${i}</option>
									</c:when>
									<c:otherwise>
										<option value="${i}">${i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>월
						
						<select name="curDay">
							<c:forEach var="i" begin="1" end="31">
								<c:choose>
									<c:when test="${endDay==i}">
										<option value="${i}" selected>${i}</option>
									</c:when>
									<c:otherwise>
										<option value="${i}">${i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>일 &nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:search_order_history('today')">
							<img src="${contextPath}/resources/image/btn_search_one_day.jpg"/>
						</a>
						<a href="javascript:search_order_history('one_week')">
					   		<img   src="${contextPath}/resources/image/btn_search_1_week.jpg">
						</a>
						<a href="javascript:search_order_history('two_week')">
					   		<img   src="${contextPath}/resources/image/btn_search_2_week.jpg">
						</a>
						<a href="javascript:search_order_history('one_month')">
					   		<img   src="${contextPath}/resources/image/btn_search_1_month.jpg">
						</a>
						<a href="javascript:search_order_history('two_month')">
					   		<img   src="${contextPath}/resources/image/btn_search_2_month.jpg">
						</a>
						<a href="javascript:search_order_history('three_month')">
					   		<img   src="${contextPath}/resources/image/btn_search_3_month.jpg">
						</a>
						<a href="javascript:search_order_history('four_month')">
					   		<img   src="${contextPath}/resources/image/btn_search_4_month.jpg">
						</a>
						&nbsp;까지 조회
					</td>
				</tr>
				
				<tr>
					<td>
						조회기간:
						<input type="date" name="start_date" id="start_date"/>
						<input type="date" name="end_date" id="end_date" value="${end_date}"/>
					</td>
				</tr>
				
				<tr>
					<td>
						<select name="s_search_type" disabled>
							<option value="all" checked>전체</option>
							<option value="orderer_name">주문자 이름</option>
							<option value="orderer_id">주문자 아이디</option>
							<option value="orderer_hp">주문자 휴대폰 번호</option>
							<option value="orderer_goods">주문상품 품명</option>
						</select>
					<input type="text" size="30" name="t_search_word" disabled/>
					<input type="button" value="조회" name="btn_search" onclick="fn_detail_search()" disabled/>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="clear"></div>
		<div class="clear"></div>
		
		<table class="list_view">
			<tbody align="center">
				<tr style="background:#33ff00">
					<td class="fixed">주문번호</td>				
					<td class="fixed">주문일자</td>				
					<td>주문내역</td>				
					<td>배송상태</td>				
					<td>배송수정</td>				
				</tr>
				<c:choose>
					<c:when test="${empty newOrderList}">
						<tr>
							<td colspan="5" class="fixed">
								<strong>주문한 상품이 없습니다.</strong>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${newOrderList}" varStatus="i">
							<c:choose>
								<c:when test="${item.order_id} != pre_order_id">
									<c:choose>
										<c:when test="${item.delivery_state=='delivery_prepared'}">
											<tr bgcolor="ligthgreen">
										</c:when>
										<c:when test="${item.delivery_state=='finished_delivering'}">
											<tr bgcolor="lightgray">
										</c:when>
										<c:otherwise>
											<tr bgcolor="orange">
										</c:otherwise>
									</c:choose>
										
										<td>
											<a href="javascript:fn_detail_order('${item.order_id}')">
												<strong>${item.order_id}</strong>
											</a>
										</td>
										<td width="20%">
											<strong>${item.pay_order_time}</strong>
										</td>
										<td width="50%" align="left">
											<strong>주문자:${item.orderer_name}</strong><br>
											<strong>주문자 전화번호:${item.receiver_hp1}-${item.receiver_hp2}-${item.receiver_hp3}</strong><br>
											<strong>수령자:${item.receiver_name}</strong><br>
											<strong>주문상품명(수량):${item.goods_title}(${item.order_goods_qty})</strong><br>
												
												<c:forEach var="item2" items="${newOrderList}" varStatus="j">
													<c:if test="${j.index > i.index}">
														<c:if test="${item.order_id == item2.order_id}">
															<strong>주문상품명(수량):${item2.goods_title}(${item2.order_goods_qty})</strong><br>
														</c:if>
													</c:if>
												</c:forEach>
										</td>
										
										<td width="10%">
											<select name="s_delivery_state${i.index}" id="s_delivery_state${i.index}">
											</select>
										</td>
								</c:when>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
</body>
</html>















