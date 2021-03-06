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
		}else if(attribute=='goods_total_page'){
			value=frm_mod_goods.goods_total_page.value;
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
			asyn:false, //false??? ?????? ??????????????? ???????????? 
						//????????? ???????????? ??????????????? ???????????? ??????????????? ????????? ????????? ????????? ??? ?????? ???????????? ????????? ?????????????????? ??????
			url:"${contextPath}/admin/goods/modifyGoodsInfo.do",
			data:{
				goods_id:goods_id,
				attribute:attribute,
				value:value
			},
			success:function(data,textStatus){
				if(data.trim()=='mod_success'){
					alert('?????? ????????? ??????????????????.');
				}else if(data.trim()=='failed'){
					alert('?????? ????????? ?????????');
				}
			},
			error:function(data,textStatus){
				alert('????????? ??????????????????.'+data);
			},
			complete:function(data,textStatus){
				//alert('?????? ??????');
			}
		}); //end Ajax
		
	}
	
	//????????? ?????? ????????????
	function readURL(input,preview){
		
		if(input.files && input.files[0]){
			var reader = new FileReader();
			
			reader.onload = function (e){  //onload ?????? ????????? ??????????????? ??????????????? ??? ??????
				$('#'+preview).attr('src',e.target.result);
				
			}
			reader.readAsDataURL(input.files[0]); //???????????? ????????? Base64 Encode ???????????? ??????
		}
	}
	
	var cnt = 1;
	function fn_addFile(){
		$("#d_file").append("<br>"+"<input type='file' name='detail_image"+cnt+"' id='detail_image"+cnt+"' onchange=readURL(this,'previewImage"+cnt+"')/>");
		$("#d_file").append("<img id='previewImage"+cnt+"' width=200 height=200 />");
		$("#d_file").append("<input  type='button' value='??????'  onClick=addNewImageFile('detail_image"+cnt+"','${imageFileList[0].goods_id}','detail_image')  />");
		cnt++;
	}

	
			
	function modifyImageFile(fileId, goods_id, image_id, filetype){
		
		
		var form = $('#FILE_FORM')[0];
		var formData = new FormData(form); //ajax??? ??? ????????? ???????????? ????????? FormData ??????
		
		formData.append('fileName',$('#'+fileId)[0].files[0]);
		formData.append('goods_id',goods_id);
		formData.append('image_id',image_id);
		formData.append('filetype',filetype);
		
		$.ajax({
			
			url:"${contextPath}/admin/goods/addNewGoodsImage.do",
			processData:false,
			contentType:false,
			data:formData,
			type:'post',
			success:function(result){
				alert('???????????? ??????????????????!');
			}
		});
	}
	
	//onClick=addNewImageFile('detail_image"+cnt+"','${imageFileList[0].goods_id}','detail_image')  />");
	//????????????
	function addNewImageFile(fileId, goods_id, fileType){
		
		var form = $('#FILE_FORM')[0];
		var formData = new FormData(form);
		
		formData.append("uploadFile",$('#'+fileId)[0].files[0]);
		formData.append("goods_id",goods_id);
		formData.append("fileType",fileType);
		
		$.ajax({
			
			url:'${contextPath}/admin/goods/addNewGoodsImage.do',
			processData:false,
			contentType:false,
			data:formData,
			type:'post',
			success:function(result){
				alert('???????????? ??????????????????');
			}
			
		});
	}
	
	//????????? ??????
	function deleteImageFile(goods_id, image_id, imageFileName,trId){
		
		var tr = document.getElementById(trId);
		
		$.ajax({
			type:'post',
			asyn:true, //false ????????? ????????? ??????
			url:"${contextPath}/admin/goods/removeGoodsImage.do",
			data:{goods_id:goods_id,
				  image_id:image_id,
				  imageFileName:imageFileName},
			success:function(data,textStatus){
				alert('???????????? ??????????????????.');
				tr.style.display = 'none';
			},
			error:function(data,textStatus){
				alert('????????? ??????????????????.'+textStatus);
			},
			complete:function(data,textStatus){
				//alert('????????? ?????? ????????????.');
			}
		});//end ajax
	}
	
</script>
</head>
<body>
	<form name="frm_mod_goods" method="post">
		<div class="clear"></div>
		
		<!-- ?????? ?????? ?????? ??? -->
		<div id="container">
			<ul class="tabs">
				<li><a href="#tab1">????????????</a></li>
				<li><A href="#tab2">????????????</A></li>
				<li><A href="#tab3">??????????????????</A></li>
				<li><A href="#tab4">????????????</A></li>
				<li><A href="#tab5">????????? ?????? ??????</A></li>
				<li><A href="#tab6">?????????</A></li>
				<li><A href="#tab7">???????????????</A></li>
			</ul>
			
			<div class="tab_container">
				<div class="tab_content" id="tab1">
					<table>
						<tr>
							<td width="200">????????????</td>
							<td width="500">
								<select name="goods_sort">
									<c:choose>
										<c:when test="${goods.goods_sort=='???????????? ?????????'}">
											<option value="???????????? ?????????" selected>???????????? ?????????</option>
											<option value="????????? ??????">????????? ??????</option>
										</c:when>
										<c:when test="${goods.goods_sort=='????????? ??????'}">
											<option value="???????????? ?????????">???????????? ?????????</option>
											<option value="????????? ??????">????????? ??????</option>
										</c:when>
									</c:choose>
								</select>
							</td>
							<td>
								<input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_sort')"/>
							</td>
						</tr>
						
						
						<tr>
							<td>????????????</td>
							<td><input type="text" name="goods_title" value="${goods.goods_title}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_title')"/></td>
						</tr>
						
						<tr>
							<td>??????</td>
							<td><input type="text" name="goods_writer" size="40" value="${goods.goods_writer}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_writer')"/></td>
						</tr>
						
						<tr>
							<td>?????????</td>
							<td><input type="text" name="goods_publisher" size="40" value="${goods.goods_publisher}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_publisher')"/></td>
						</tr>
						
						<tr>
							<td>????????????</td>
							<td><input type="text" name="goods_price" size="40" value="${goods.goods_price}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_price')"/></td>
						</tr>
						
						<tr>
							<td>??????????????????</td>
							<td><input type="text" name="goods_sales_price" size="40" value="${goods.goods_sales_price}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_sales_price')"/></td>
						</tr>
						
						<tr>
							<td>?????? ?????? ?????????</td>
							<td><input type="text" name="goods_point" size="40" value="${goods.goods_point}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_point')"/></td>
						</tr>
						
						<tr>
							<td>???????????????</td>
							<td><input type="date" name="goods_publisheed_date" value="${goods.goods_published_date}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_published_date')"/></td>
						</tr>
						
						<tr>
							<td>?????? ??? ????????? ???</td>
							<td><input type="text" name="goods_total_page" size="40" value="${goods.goods_total_page}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_total_page')"/></td>
						</tr>
						
						<tr>
							<td>ISBN</td>
							<td><input type="text" name="goods_isbn" size="40" value="${goods.goods_isbn}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_isbn')"/></td>
						</tr>
						
						<tr>
							<td>???????????????</td>
							<td><input type="text" name="goods_delivery_price" size="40" value="${goods.goods_delivery_price}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_delivery_price')"/></td>
						</tr>
						
						<tr>
							<td>?????? ?????? ?????????</td>
							<td><input type="date" name="goods_delivery_date" value="${goods.goods_delivery_date}"/></td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_delivery_date')"/></td>
						</tr>
						
						<tr>
							<td>????????????</td>
							<td>
								<select name="goods_status" id="goods_status">
									<option value="bestseller">???????????????</option>
									<option value="steadyseller">???????????????</option>
									<option value="newboos">??????</option>
									<option value="on_sale">?????????</option>
									<option value="buy_out">??????</option>
									<option value="out_of_print">??????</option>
								</select>
								<input type="hidden" id="h_goods_status" value="${goods.goods_status}"/>
							</td>
							<td><input type="button" value="????????????" onClick="fn_modify_goods('${goods.goods_id}','goods_status')"/></td>
						</tr>
						
						<tr>
							<td colspan="3">
								<br>
							</td>
						</tr>
					</table>
				</div>
				<div class="tab_content" id="tab2">
					<h4>?????????</h4>
					<table>
						<tr>
							<td>????????????</td>
							<td><textarea rows="100" cols="80" name="goods_contents_order">${goods.goods_contents_order}</textarea></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="????????????" onclick="fn_modify_goods('${goods.goods_id}')"/></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="tab_content" id="tab3">
				<h4>?????? ?????? ??????</h4>
				<p>
				<table>
					<tr>
						<td>?????? ?????? ??????</td>
						<td><textarea rows="100" cols="80" name="goods_writer_intro">${goods.goods_writer_intro}</textarea></td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="????????????" onclick="fn_modify_goods('${goods.goods_id}','goods_intro')"/></td>
					</tr>
				</table>
				</p>
			</div>
			
			<div class="tab_content" id="tab4">
				<h4>????????????</h4>
				<p>
					<table>
						<tr>
							<td>????????????</td>
							<td><textarea rows="100" cols="80" name="goods_intro"></textarea></td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="????????????" onclick="fn_modify_goods('${goods.goods_id}','goods_intro')"/></td>
						</tr>
					</table>
				</p>
			</div>
			<div class="tab_content" id="tab6">
				<h4>?????????</h4>
				<table>
					<tr>
						<td>?????????</td>
						<td><textarea rows="100" cols="80" name="goods_recommendation">${goods.goods_recommendation}</textarea></td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;<input ty/></td>
					</tr>
				</table>
			</div>
			<div class="tab_content" id="tab7">
				<form id="FILE_FORM" method="post" enctype="multipart/form-data" >
					<h4>???????????????</h4>
					<table>
						<tr>
							<c:forEach var="item" items="${imageFileList}" varStatus="itemNum">
								<c:choose>
									<c:when test="${item.filetype=='main_image'}">
										<tr>
											<td>???????????????</td>
											<td>
												<input type="file" id="main_image" name="main_image" onchange="readURL(this,'preview${itemNum.count}');"/>
												<input type="hidden" name="image_id" value="${item.image_id}"/>
												<br>
											</td>
											<td><img id="preview${itemNum.count}" width="200" height="200" src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}"/></td>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
											
											<td><input type="button" value="??????" onclick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.filetype}')"/></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
									</c:when>
								<c:otherwise>
									<tr id="${itemNum.count-1}">
										<td>???????????????</td>
										<td>
											<input type="file" name="detail_image" id="detail_image" onchange="readURL(this,'preview${itemNum.count}');"/>
											<input type="hidden" name="image_id" value="${item.image_id}"/>
										</td>
										<td>
											<img id="preview${itemNum.count}" width="200" height="200" src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}"/>
										</td>
										<td>
											&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
										<td>
											<input type="button" value="??????" onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.filetype}')"/>
											<input type="button" value="??????" onclick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')"/>
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
								<input type="button" value="??????????????? ????????????" onClick="fn_addFile()"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="clear"></div>
		</div>
		
	</form>
</body>
</html>


