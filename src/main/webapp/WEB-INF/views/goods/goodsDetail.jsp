<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="goods" value="${goodsMap.goodsVO}"/>
<c:set var="imageList" value="${goodsMap.imageList}"/>

<%
	//치환변수 선언
	pageContext.setAttribute("crcn", "\n");
	pageContext.setAttribute("br", "<br/>");

%>
<html>
<head>
<style>

</style>
<script type="text/javascript">
function fn_order_each_goods()
</script>
</head>
<body>
	<hgroup>
		<h1>컴퓨터와 인터넷</h1>
		<h2>국내외 도서 &gt; 컴퓨터와 인터넷 &gt; 웹개발</h2>
		<h3>${goods.goods_title}</h3>
		<h4>${goods.goods_writer} &nbsp; 저|${goods.goods_publisher}</h4>
	</hgroup>
	<div id="goods_image">
		<figure>
			<img alt="HTML5 & amp; CSS3" src="${contextPath}/thumbnails.do?goods_id=${goods.goods_id}&fileName=${goods.goods_fileName}"/>
		</figure>
	</div>
	
	<div id="detail_table">
		<table>
			<tbody>
				<tr>
					<td class="fixed">정가</td>
					<td class="active">
						<span>
							<fmt:formatNumber value="${goods.goods_price}" type="number" var="goods_price"/>
								${goods_price}원
						</span>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed">판매가</td>
					<td class="active">
						<span>
							<fmt:formatNumber value="${goods.goods_price*0.9}" type="number" var="discounted_price"/>
								${discounted_price}원 (10% 할인)
						</span>
					</td>
				</tr>
				
				<tr>
					<td class="fixed">포인트 적립</td>
					<td class="active">${goods.goods_point}P(10%적립)</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed">포인트 추가 적립</td>
					<td class="fixed">만원이상 구매시 1,000P, 5만원이상 구매시 2,000P 추가적립 편의점 배송 이용시 300P 추가적립</td>
				</tr>
				
				<tr>
					<td class="fixed">발행일</td>
					<td class="fixed">
						<c:set var="pub_date" value="${goods.goods_published_date}"/>
						<c:set var="arr" value="${fn:split(pub_date,' ')}"/>
						<c:out value="${arr[0]}"/>
					</td>
				</tr>
				
				<tr>
					<td class="fixed">페이지 수</td>
					<td class="fixed">${goods.goods_total_page}쪽</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed">ISBN</td>
					<td class="fixed">${goods.goods_isbn}</td>
				</tr>
				
				<tr>
					<td class="fixed">배송료</td>
					<td class="fixed"><strong>무료</strong></td>
				</tr>
				
				<tr>
					<td class="fixed">배송안내</td>
					<td class="fixed"><strong>[당일배송]</strong> 당일배송 서비스 시작!<br> <strong>[휴일배송]</strong>
						휴일에도 배송 받는 BookShop
					</td>
				</tr>
				
				<tr>
					<td class="fixed">도착예정일</td>
					<td class="fixed">지금 주문 시 내일 도착 예정</td>
				</tr>
				
				<tr>
					<td class="fixed">수량</td>
					<td class="fixed">
						<select style="width:60px" id="order_goods_qty">
							<option>1</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
		
		<ul>
			<li><a class="buy" href="javascript:fn_order_each_goods('${goods.goods_id}','${goods.goods_title}','${goods.goods_sales_price}','${goods.goods_fileName}');">구매하기</a></li>
			<li><a class="cart" href="javascript:add_cart('${goods.goods_id}');">장바구니</a></li>
			<li><a class="wish" href="#">위시리스트</a></li>
		</ul>
	</div>
	
	<div class="clear"></div>
	
	<!-- 내용 들어가는 곳 -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">책소개</a></li>
			<li><a href="#tab2">저자소개</a></li>
			<li><a href="#tab3">책목차</a></li>
			<li><a href="#tab4">출판사서평</a></li>
			<li><a href="#tab5">추천사</a></li>
			<li><a href="#tab6">리뷰</a></li>
		</ul>
		
		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<h4>책소개</h4>
				<p>${fn:replace(goods.goods_intro,crcn,br)}</p>
				<c:forEach var="image" items="${imageList}">
					<img src="${contextPath}/download.do?goods_id=${goods.goods_id}&fileName=${image.fileName}">
				</c:forEach>
			</div>
			
			<div class="tab_content" id="tab2">
				<h4>저자소개</h4>
				<div class="writer">저자: ${goods.goods_writer}</div>
				<p>${fn:replace(goods.goods_writer_intro,crcn,br)}</p>
			</div>
			
			<div class="tab_content" id="tab3">
				<h4>책목차</h4>
				<p>${fn:replace(goods.goods_contents_order,crcn,br)}</p>
			</div>
			
			<div class="tab_content" id="tab4">
				<h4>출판사서평</h4>
				<p>${fn:replace(goods.goods_publisher_comment,crcn,br)}</p>
			</div>
			
			<div class="tab_content" id="tab5">
				<h4>추천사</h4>
				<p>${fn:replace(goods.goods_recommendation,crcn,br)}</p>
			</div>			
			
			<div class="tab_content" id="tab6">
				<h4>리뷰</h4>
			</div>
		</div>
	</div>
	
	<div class="clear"></div>
	<!-- visibility:hidden 으로 설정하여 해당 div안의 모든 것들을 가려둔다 -->
	<div id="layer" style="visibility:hidden"></div>
	
	<div id="popup">
		<!-- 팝업창 닫기 -->
		<a href="javascript:" onclick="javascript:imagePopup('close','.layer01');">
			<img src="${contextPath}/resources/image/close.png" id="close">
		</a>
		<br>
		<font size="12" id="contents">장바구니에 담았습니다.</font><br>
		
		<form action="${contextPath}/cart/myCartList.do">
			<input type="submit" value="장바구니 보기"/>
		</form>
		
	</div>
</body>
</html>


















