<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="goods" value="${goodsMap.goods}"/>
<c:set var="imageFileList" value="${goodsMap.imageFileList}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:choose>
<c:when test="${not empty goods.goods_status}">
<script>
	window.onload = function(){
// 		init();
		selectBoxInit();
	}
	
// 	function init(){
// 		var frm_mod_goods = document.frm_mod_goods;
// 		var h_goods_status = frm_mod_goods.h_goods_status;
		
// 		var goods_status = h_goods_status.value;
// 		var select_goods_status = frm_mod_goods.goods_status;
		
// 		select_goods_status = goods_status;
// 	}
	
	function selectBoxInit(){
		
		var goods_status = '${goods.goods_status}';
		
		var sel_goods_status = document.getElementById('goods_status');
		
		var optionStatus = sel_goods_status.options;
		var val;
		
		for(var i=0; i<optionStatus.length; i++){
			val = optionStatus[i].value;
			
			if(goods_status==val){
				optionStatus[i].selected = true;
				break;
			}
		}
	}
</script>
</c:when>
</c:choose>
<script type="text/javascript">

	function fn_modify_goods(goods_id, attribute){
		
		var frm_mod_goods = document.frm_mod_goods;
		
		var value="";
		
		if(attribute == 'goods_sort'){
			value = frm_mod_goods.goods_sort.value;
		}else if(attribute=='goods_title'){
			value=frm_mod_goods.goods_title.value;
		}else if(attribute=='goods_writer'){
			value=frm_mod_goods.goods_writer.value;   
		}else if(attribute=='goods_publisher'){
			value=frm_mod_goods.goods_publisher.value;
		}else if(attribute=='goods_price'){
			value=frm_mod_goods.goods_price.value;
		}else if(attribute=='goods_sales_price'){
			value=frm_mod_goods.goods_sales_price.value;
		}else if(attribute=='goods_point'){
			value=frm_mod_goods.goods_point.value;
		}else if(attribute=='goods_published_date'){
			value=frm_mod_goods.goods_published_date.value;
		}else if(attribute=='goods_page_total'){
			value=frm_mod_goods.goods_page_total.value;
		}else if(attribute=='goods_isbn'){
			value=frm_mod_goods.goods_isbn.value;
		}else if(attribute=='goods_delivery_price'){
			value=frm_mod_goods.goods_delivery_price.value;
		}else if(attribute=='goods_delivery_date'){
			value=frm_mod_goods.goods_delivery_date.value;
		}else if(attribute=='goods_status'){
			value=frm_mod_goods.goods_status.value;
		}else if(attribute=='goods_contents_order'){
			value=frm_mod_goods.goods_contents_order.value;
		}else if(attribute=='goods_writer_intro'){
			value=frm_mod_goods.goods_writer_intro.value;
		}else if(attribute=='goods_intro'){
			value=frm_mod_goods.goods_intro.value;
		}else if(attribute=='publisher_comment'){
			value=frm_mod_goods.publisher_comment.value;
		}else if(attribute=='recommendation'){
			value=frm_mod_goods.recommendation.value;
		}
		
		$.ajax({
			type:"post",
			asyn:false, //false인 경우 동기식으로 처리한다 
						//동기는 디자인이 비동기보다 간단하고 직관적일수 있지만 결과가 주어질 때 까지 아무것도 못하고 대기해야하는 문제
			url:"${contextPath}/admin/goods/modifyGoodsInfo.do",
			data:{
				goods_id:goods_id,
				attribute:attribute,
				value:value
			},
			success:function(data,textStatus){
				if(data.trim()=='mod_success'){
					alert('상품 정보를 수정했습니다.');
				}else if(data.trim()=='failed'){
					alert('다시 시도해 주세요');
				}
			},
			error:function(data,textStatus){
				alert('에러가 발생했습니다.'+data);
			},
			complete:function(data,textStatus){
				//alert('작업 완료');
			}
		}); //end Ajax
		
		
	}
</script>
</head>
<body>
	<form name="frm_mod_goods" method="post">
		<div class="clear"></div>
		
		<!-- 내용 들어 가는 곳 -->
		<div id="container">
			<ul class="tabs">
				<li><a href="#tab1">상품정보</a></li>
				<li><A href="#tab2">상품목차</A></li>
				<li><A href="#tab3">상품저자소개</A></li>
				<li><A href="#tab4">상품소개</A></li>
				<li><A href="#tab5">출판사 상품 평가</A></li>
				<li><A href="#tab6">추천사</A></li>
				<li><A href="#tab7">상품이미지</A></li>
			</ul>
			
			<div class="tab_container">
				<div class="tab_content" id="tab1">
					<table>
						<tr>
							<td width="200">상품분류</td>
							<td width="500">
								<select name="goods_sort">
									<c:choose>
										<c:when test="${goods.goods_sort=='컴퓨터와 인터넷'}">
											<option value="컴퓨터와 인터넷" selected>컴퓨터와 인터넷</option>
											<option value="디지털 기기">디지털 기기</option>
										</c:when>
										<c:when test="${goods.goods_sort=='디지털 기기'}">
											<option value="컴퓨터와 인터넷">컴퓨터와 인터넷</option>
											<option value="디지털 기기">디지털 기기</option>
										</c:when>
									</c:choose>
								</select>
							</td>
							<td>
								<input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_sort')"/>
							</td>
						</tr>
						
						
						<tr>
							<td>상품이름</td>
							<td><input type="text" name="goods_title" value="${goods.goods_title}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_title')"/></td>
						</tr>
						
						<tr>
							<td>저자</td>
							<td><input type="text" name="goods_writer" size="40" value="${goods.goods_writer}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_writer')"/></td>
						</tr>
						
						<tr>
							<td>출판사</td>
							<td><input type="text" name="goods_publisher" size="40" value="${goods.goods_publisher}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_publisher')"/></td>
						</tr>
						
						<tr>
							<td>상품정가</td>
							<td><input type="text" name="goods_price" size="40" value="${goods.goods_price}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_price')"/></td>
						</tr>
						
						<tr>
							<td>상품판매가격</td>
							<td><input type="text" name="goods_sales_price" size="40" value="${goods.goods_sales_price}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_sales_price')"/></td>
						</tr>
						
						<tr>
							<td>상품 구매 포인트</td>
							<td><input type="text" name="goods_point" size="40" value="${goods.goods_point}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_point')"/></td>
						</tr>
						
						<tr>
							<td>상품출판일</td>
							<td><input type="date" name="goods_publisheed_date" value="${goods.goods_published_date}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_published_date')"/></td>
						</tr>
						
						<tr>
							<td>상품 총 페이지 수</td>
							<td><input type="text" name="goods_page_total" size="40" value="${goods.goods_page_total}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_page_total')"/></td>
						</tr>
						
						<tr>
							<td>ISBN</td>
							<td><input type="text" name="goods_isbn" size="40" value="${goods.goods_isbn}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_isbn')"/></td>
						</tr>
						
						<tr>
							<td>상품배송비</td>
							<td><input type="text" name="goods_delivery_price" size="40" value="${goods.goods_delivery_price}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_delivery_price')"/></td>
						</tr>
						
						<tr>
							<td>상품 도착 예정일</td>
							<td><input type="date" name="goods_delivery_date" value="${goods.goods_delivery_date}"/></td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_delivery_date')"/></td>
						</tr>
						
						<tr>
							<td>상품종류</td>
							<td>
								<select name="goods_status" id="goods_status">
									<option value="bestseller">베스트셀러</option>
									<option value="steadyseller">스테디셀러</option>
									<option value="newboos">신간</option>
									<option value="on_sale">판매중</option>
									<option value="buy_out">품절</option>
									<option value="out_of_print">절판</option>
								</select>
								<input type="hidden" id="h_goods_status" value="${goods.goods_status}"/>
							</td>
							<td><input type="button" value="수정반영" onClick="fn_modify_goods('${goods.goods_id}','goods_status')"/></td>
						</tr>
						
						<tr>
							<td colspan="3">
								<br>
							</td>
						</tr>
					</table>
				</div>
				<div class="tab_content" id="tab2">
					<h4>책목차</h4>
					<table>
						<tr>
							<td>상품목차</td>
							<td><textarea rows="100" cols="80" name="goods_contents_order">${goods.goods_contents_order}</textarea></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="수정반영" onclick="fn_modify_goods('${goods.goods_id}')"/></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="tab_content" id="tab3">
				<h4>상품 저자 소개</h4>
				<p>
				<table>
					<tr>
						<td>상품 저자 소개</td>
						<td><textarea rows="100" cols="80" name="goods_writer_intro">${goods.goods_writer_intro}</textarea></td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="수정반영" onclick="fn_modify_goods('${goods.goods_id}','goods_intro')"/></td>
					</tr>
				</table>
				</p>
			</div>
			
			<div class="tab_content" id="tab4">
				<h4>상품소개</h4>
				<p>
					<table>
						<tr>
							<td>상품소개</td>
							<td><textarea rows="100" cols="80" name="goods_intro"></textarea></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="수정반영" onclick="fn_modify_goods('${goods.goods_id}','goods_intro')"/></td>
						</tr>
					</table>
				</p>
			</div>
			<div class="tab_content" id="tab6">
				<h4>추천사</h4>
				<table>
					<tr>
						<td>추천사</td>
						<td><textarea rows="100" cols="80" name="goods_recommendation">${goods.goods_recommendation}</textarea></td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;<input ty/></td>
					</tr>
				</table>
			</div>
			<div class="tab_content" id="tab7">
				<form id="FILE_FORM" method="post" enctype="multipart/form-data" >
					<h4>상품이미지</h4>
					<table>
						<tr>
							<c:forEach var="item" items="${imageFileList}" varStatus="itemNum">
								<c:choose>
									<c:when test="${item.fileType=='main_image'}">
										<tr>
											<td>메인이미지</td>
											<td>
												<input type="file" id="main_image" name="main_image" onchange="readURL(this,'preview${itemNum.count}');"/>
												<input type="hidden" name="image_id" value="${item.image_id}"/>
												<br>
											</td>
											<td><img id="preview${itemNum.count}" width="200" height="200" src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}"/></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
											<td><input type="button" value="수정" onclick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
									</c:when>
								<c:otherwise>
									<tr id="${itemNum.count-1}">
										<td>상세이미지</td>
										<td>
											<input type="file" name="detail_image" id="detail_image" onchange="readURL(this,'preview${itemNum.count}');"/>
											<input type="hidden" name="image_id" value="${item.image_id}"/>
										</td>
										<td>
											<img id="preview${itemNum.count}" width="200" height="200" src="${contentPath}/download.?goods_id=${item.goods_id}&fileName=${item.fileName}"/>
										</td>
										<td>
											&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
										<td>
											<input type="button" value="수정" onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>
											<input type="button" value="삭제" onclick="deleteImageFile('${item.goods_id}','${item.image_id}','${imageNum.count-1}')"/>
										</td>
									</tr>
									<tr>
										<td><br></td>
									</tr>
								</c:otherwise>
								</c:choose>
							</c:forEach>
						</tr>
						<tr align="center">
							<td colspan="3">
								<div id="d_file">
									
								</div>
							</td>
						</tr>
						<tr>
							<td align="center" colspan="2">
								<input type="button" value="이미지파일 추가하기"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			
		</div>
		
	</form>
</body>
</html>


