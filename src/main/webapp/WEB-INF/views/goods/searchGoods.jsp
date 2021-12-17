<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%
	pageContext.setAttribute("crcn", "\r\n"); //Space,Enter
	pageContext.setAttribute("br", "<br/>"); //br 태그
%>
<head>
<title>검색 도서 목록 페이지</title>
</head>
<body>
	<hgroup>
		<h1>컴퓨터와 인터넷</h1>
		<h2>오늘의 책</h2>
	</hgroup>
	<section id="new_book">
		<h3>새로나온 책</h3>
		<div id="left_scroll">
			<a href='javascript:slide("left");'><img src="${contextPath}/resources/image/left.gif"></a>
		</div>
		
		<div id="carousel_inner">
			<ul id="carousel_ul">
				<c:choose>
					<c:when test="${empty goodsList}">
						<li>
							<div>
								<h1>제품이 없습니다.</h1>
							</div>
						</li>
					</c:when>
					<c:otherwise>
						<c:forEach var="item" items="${goodsList}">
							<li>
								<div id="book">
									<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"></a>
									<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
								<div class="sort">[컴퓨터 인터넷]</div>
								<div class="title">
									<a href="${contextPath}/goods/goodsDetail.do?good_id=${item.goods_id}">${item.goods_title}</a>
								</div>
								<div class="writer">${item.goods_writer} |  ${item.goods_publisher}</div>
								<div class="price">
									<span>
										<fmt:formatNumber var="goods_price" type="number" value="${item.goods_price}"/>
												${goods_price}원
									</span><br>
									<fmt:formatNumber var="discounted_price" type="number" value="${item.goods_price*0.9}"/>
												${discounted_price}원(10%할인)
									</div>
								</div>
							</li>
						</c:forEach>
						<li>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		
		<div id="right_scroll">
			<a href='javascript:slide("right");'><img src="${contextPath}/resources/image/right.gif"></a>
		</div>
		<input type="hidden" id="hidden_auto_slide_seconds" value="0"/>
		
		<div class="clear"></div>
		
	</section>
		<div class="clear"></div>
		<div id="sorting">
			<ul>
				<li><a class="active" href="#">베스트 셀러</a></li>
				<li><a href="#">최근 출간</a></li>
				<li><a style="border:currentColor; border-image:none;" href="#">최근 등록</a></li>
			</ul>
		</div>
		
		<table id="list_view">
			<tbody>
				<c:forEach var="item" items="${goodsList}">
					<tr>
						<td class="goods_image">
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
								<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
							</a>
						</td>
						
						<td class="goods_description">
							<h2>
								<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">${item.goods_title}</a>
							</h2>
							<c:set var="goods_pub_date" value="${item.goods_published_date}"/>
							<c:set var="arr" value="${fn:split(goods_pub_date,' ')}"/>
							<div class="wroter_press">
								${item.goods_writer}저 | ${item.goods_publisher} | <c:out value="${arr[0]}"/>
							</div>
						</td>
						<td class="price"><span>${item.goods_price}원</span>
							<strong>
								<fmt:formatNumber type="number" value="${item.goods_price*0.9}" var="discounted_price"/>
									${discounted_price}원
							</strong>(10% 할인)
						</td>
						<td><input type="checkbox" value=""/></td>
						<td class="buy_btns">
							<ul>
								<li><a href="#">장바구니</a></li>
								<li><a href="#">구매하기</a></li>
								<li><a href="#">비교하기</a></li>
							</ul>
						</td>
						
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="clear"></div>
		
		<div id="page_wrap">
			<ul id="page_control">
				<li><a class="no_border" href="#">Prev</a></li>
				<c:set var="page_num" value="0"/>
				<c:forEach var="count" begin="1" end="10" step="1">
					<c:choose>
						<c:when test="${count==1}">
							<li class="page_contrl_active" href="#">${count+page_num*10}</li>
						</c:when>
						<c:otherwise>
							<li><a href="#">${count+page_num*10}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<li><a class="no_border" href="#">Next</a></li>
			</ul>
		</div>
</body>
</html>







