<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<head>
<style>
#layer{
	z-index:2;
	position:absolute;
	top:0px;
	left:0px;
	width:100%;
}
</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadAddress').value = fullRoadAddr;
            document.getElementById('jibunAddress').value = data.jibunAddress;

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

            } else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}

window.onload=function(){
	init();
}

function init(){
	
	var form_order = document.form_odrer;
	
	var h_tel1=form_order.h_tel1;
	var h_hp1=form_order.h_hp1;
	
	var tel1=h_tel1.value;
	var hp1=h_hp1.value;
	
	var select_tel1=form_order.tel1;
	var select_hp1=form_order.hp1;
	
	select_tel1.value=tel1;
	select_hp1.value=hp1;
}

//배송지선택 - 새로입력
function reset_all(){
	
	var e_receiver_name = document.getElementById("receiver_name");
	var e_hp1 = document.getElementById("hp1");
	var e_hp2 = document.getElementById("hp2");
	var e_hp3 = document.getElementById("hp3");
	
	var e_tel1 = document.getElementById("tel1");
	var e_tel2 = document.getElementById("tel2");
	var e_tel3 = document.getElementById("tel3");
	
	var e_zipcode = document.getElementById("zipcode");
	var e_roadAddress = document.getElementById("roadAddress");
	var e_jibunAddress = document.getElementById("jibunAddress");
	var e_namujiAddress = document.getElementById("namujiAddress");
	
	e_receiver_name.value="";
	e_hp1.value=0;
	e_hp2.value="";
	e_hp3.value="";
	e_tel1.value="";
	e_tel2.value="";
	e_tel3.value="";
	e_zipcode.value="";
	e_roadAddress.value="";
	e_jibunAddress.value="";
	e_namujiAddress.value="";
	
}

//배송지선택 - 기본배송지
function restore_all(){
	
	var e_receiver_name = document.getElementById("receiver_name");
	var e_hp1 = document.getElementById("hp1");
	var e_hp2 = document.getElementById("hp2");
	var e_hp3 = document.getElementById("hp3");
	
	var e_tel1 = document.getElementById("tel1");
	var e_tel2 = document.getElementById("tel2");
	var e_tel3 = document.getElementById("tel3");
	
	var e_zipcode = document.getElementById("zipcode");
	var e_roadAddress = document.getElementById("roadAddress");
	var e_jibunAddress = document.getElementById("jibunAddress");
	var e_namujiAddress = document.getElementById("namujiAddress");
	
	var h_receiver_name = document.getElementById("h_receiver_name");
	var h_hp1 = document.getElementById("h_hp1");
	var h_hp2 = document.getElementById("h_hp2");
	var h_hp3 = document.getElementById("h_hp3");
	
	var h_tel1 = document.getElementById("h_tel1");
	var h_tel2 = document.getElementById("h_tel2");
	var h_tel3 = document.getElementById("h_tel3");

	var h_zipcode = document.getElementById("h_zipcode");
	var h_roadAddress = document.getElementById("h_roadAddress");
	var h_jibunAddress = document.getElementById("h_jibunAddress");
	var h_namujiAddress = document.getElementById("h_namujiAddress");
	
	e_receiver_name.value=h_receiver_name.value;
	e_hp1.value = h_hp1.value;
	e_hp2.value = h_hp2.value;
	e_hp3.value = h_hp3.value;

	e_tel1.value = h_tel1.value;
	e_tel2.value = h_tel2.value;
	e_tel3.value = h_tel3.value;
	e_zipcode.value = h_zipcode.value;
	e_roadAddress.value = h_roadAddress.value;
	e_jibunAddress.value = h_jibunAddress.value;
	e_namujiAddress.value = h_namujiAddress.value;
}




//휴대폰 결제
function fn_pay_phone(){
	
	var e_card = document.getElementById("tr_pay_card");
	var e_phone = document.getElementById("tr_pay_phone");
	e_card.style.visibility="hidden";
	e_phone.style.visibility="visible";
}

//신용카드 결제
function fn_pay_card(){
	
	var e_card = document.getElementById("tr_pay_card");
	var e_phone = document.getElementById("tr_pay_phone");
	e_card.style.visibility="visible";
	e_phone.style.visibility="hidden";
}

function imagePopup(type){
	
	if(type=="open"){
		//팝업창을 연다
		jQuery('#layer').attr('style','visibility:visible');
		
		//페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다
		jQuery('#layer').height(jQuery(document).height());
	}else if(type=='close'){
		jQuery('#layer').attr('style','visibility:hidden');
	}
}


var goods_id="";
var goods_title="";
var goods_fileName="";

var order_goods_qty
var each_goods_price;
var total_order_goods_price;
var total_order_goods_qty;
var orderer_name
var receiver_name
var hp1;
var hp2;
var hp3;

var tel1;
var tel2;
var tel3;

var receiver_hp_num;
var receiver_tel_num;
var delivery_address;
var delivery_message;
var delivery_method;
var gift_wrapping;
var pay_method;
var card_com_name;
var card_pay_month;
var pay_orderer_hp_num;

//결제하기
function fn_show_order_detail(){
	
	 goods_id="";
	 goods_title="";
	 
	 var frm = document.form_order;
	 var h_goods_id = frm.h_goods_id;
	 var h_goods_title = frm.h_goods_title;
   	 var h_goods_fileName = frm.h_goods_fileName;
	 var r_delivery_method = frm.delivery_method;
	 var h_order_goods_qty = document.getElementById("h_order_goods_qty");
	 var h_total_order_goods_qty = document.getElementById("h_total_order_goods_qty");
	 var h_total_sales_price = document.getElementById("h_total_sales_price");
	 var h_final_total_Price = document.getElementById("h_final_total_Price");
	 var h_orderer_name = document.getElementById("h_orderer_name");
	 var i_receiver_name = document.getElementById("receiver_name");
		
	if(h_goods_id.length<2 || h_goods_id.length==null){
		goods_id += h_goods_id.value;
	}else{
		for(var i=0; i<h_goods_id.length; i++){
			goods_id += h_goods_id[i].value+"<br>";
		}
		
	}
}


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
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
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
						<td>
							<input type="radio" id="delivery_method" name="delivery_method" value="일반택배" checked/>일반택배 &nbsp;&nbsp;&nbsp;
							<input type="radio" id="delivery_method" name="delivery_method" value="편의점택배" />일반택배 &nbsp;&nbsp;&nbsp;
							<input type="radio" id="delivery_method" name="delivery_method" value="해외배송" />일반택배 &nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">배송지 선택</td>
						<td>
							<input type="radio" name="delivery_place" onClick="restore_all()" value="기본배송지" checked>기본배송지 &nbsp;&nbsp;&nbsp;
							<input type="radio" name="delivery_place" value="새로입력" onClick="reset_all()">새로입력 &nbsp;&nbsp;&nbsp;
							<input type="radio" name="delivery_place" value="최근 배송지">최근배송지 &nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<td class="fixed_join">받으실 분</td>
						<td>
							<input type="text" id="receiver_name" name="receiver_name" size="40" value="${orderer.member_name}"/>
							<input type="hidden" id="h_orderer_name" name="h_orderer_name" value="${orderer.member_name}"/>
							<input type="hidden" id="h_receiver_name" name="h_receiver_name" value="${orderer.member_name}"/>
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">휴대폰 번호</td>
						<td>
							<select id="hp1" name="hp1">
								<option value="010" selected>010</option>
								<option value="011" >011</option>
								<option value="016" >016</option>
								<option value="017" >017</option>
								<option value="018" >018</option>
								<option value="019" >019</option>
							</select>
							- <input type="text" id="hp2" name="hp2" value="${orderer.hp2}" size="10px"/>
							- <input type="text" id="hp3" name="hp3" value="${orderer.hp3}" size="10px"/> <br><br>
							
							<input type="hidden" id="h_hp1" name="h_hp1" value="${orderer.hp1}"/>
							<input type="hidden" id="h_hp2" name="h_hp2" value="${orderer.hp2}"/>
							<input type="hidden" id="h_hp3" name="h_hp3" value="${orderer.hp3}"/>
							<c:set var="orderer_hp" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}"/>
						</td>	
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">유선전화(선택)</td>
						<td>
							<select id="tel1" name="tel1">
								<option value="02">02</option>
								<option value="031">031</option>
								<option value="032">032</option>
								<option value="033">033</option>
								<option value="041">041</option>
								<option value="042">042</option>
								<option value="043">043</option>
								<option value="044">044</option>
								<option value="051">051</option>
								<option value="052">052</option>
								<option value="053">053</option>
								<option value="054">054</option>
								<option value="055">055</option>
								<option value="061">061</option>
								<option value="062">062</option>
								<option value="063">063</option>
								<option value="064">064</option>
								<option value="0502">0502</option>
								<option value="0503">0503</option>
								<option value="0505">0505</option>
								<option value="0506">0506</option>
								<option value="0507">0507</option>
								<option value="0508">0508</option>
								<option value="070">070</option>
							</select>
							 -<input type="text" id="tel2" name="tel2" value="${orderer.tel2}" size="10px"/>
							 -<input type="text" id="tel3" name="tel3" value="${orderer.tel3}" size="10px">

						<input type="hidden" id="h_tel1" name="h_tel1" value="${orderer.tel1 }" />
						<input type="hidden" id="h_tel2" name="h_tel2"	value="${orderer.tel2 }" />
						<input type="hidden" id="h_tel3" name="h_tel3"value="${orderer.tel3 }" />
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">주소</td>
						<td>
							<input type="text" id="zipcode" name="zipcode" value="${orderer.zipcode}" size="5"/>
							<a href="javascript:execDaumPostcode()">우편번호 검색</a><br>
							<p>
								지번주소:<br>
								<input type="text" id="roadAddress" name="roadAddress" value="${orderer.roadAddress}" size="50"/><br><br>
								도로명 주소:
								<input type="text" id="jibunAddress" name="jibunAddress" value="${orderer.jibunAddress}" size="50"/><br><br>
								나머지 주소:
								<input type="text" id="namujiAddress" name="namujiAddress" value="${orderer.namujiAddress}" size="50"/>
							</p>
							<input type="hidden" id="h_zipcode" name="h_zipcode" value="${orderer.zipcode}"/>
							<input type="hidden" id="h_roadAddress" name="h_roadAddress" value="${orderer.roadAddress}"/>
							<input type="hidden" id="h_jibunAddress" name="h_jibunAddress" value="${orderer.jibunAddress}"/>
							<input type="hidden" id="h_namujiAddress" name="h_namujiAddress" value="${orderer.namujiAddress}"/>
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">배송 메시지</td>
						<td>
							<input type="radio" id="gift_wrapping" name="gift_wrapping" value="yes"/>예 &nbsp;&nbsp;&nbsp;
							<input type="radio" id="gift_wrapping" name="gift_wrapping" value="no" checked/>아니오
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div>
			<br><br>
			<h2>주문고객</h2>
			<table>
				<tbody>
					<tr class="dot_line">
						<td><h2>이름</h2></td>
						<td>
							<input type="text" value="${orderer.member_name}" size="15"/>
						</td>
					</tr>
					
					<tr class="dot_line">
						<td><h2>핸드폰</h2></td>
						<td>
							<input type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15"/>
						</td>
					</tr>
					
					<tr class="dot_line">
						<td><h2>이메일</h2></td>
						<td>
							<input type="text" value="${orderer.email1}@${orderer.email2}" size="15"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="clear"></div>
		<br><br><br>
		
		<h1>3.할인정보</h1>
		<div class="detail_table">
			<table>
				<tbody>
					<tr class="dot_line">
						<td width="100">적립금</td>
						<td>
							<input type="text" name="discount_juklip" size="10"/>원/1000원 &nbsp;&nbsp;&nbsp;
							<input type="checkbox"/>모두 사용하기
						</td>
						
					</tr>
						
					<tr class="dot_line">
						<td>예치금</td>
						<td>
							<input name="discount_yechi" type="text" size="10" />원/1000원 &nbsp;&nbsp;&nbsp; 
							<input type="checkbox" /> 모두 사용하기</td>
					</tr>
					
					<tr class="dot_line">
						<td>상품권 전환금</td>
						<td cellpadding="5">
							<input name="discount_sangpum" type="text" size="10" />원/0원 &nbsp;&nbsp;&nbsp; 
							<input type="checkbox" /> 모두사용하기</td>
					</tr>
					
					<tr class="dot_line">
						<td>OK 캐쉬백 포인트</td>
						<td cellpadding="5">
							<input name="discount_okcashbag" type="text" size="10" />원/0원 &nbsp;&nbsp;&nbsp; 
							<input type="checkbox" /> 모두사용하기</td>
					</tr>
					
					<tr class="dot_line">
						<td>쿠폰할인</td>
						<td cellpadding="5">
							<input name="discount_coupon" type="text"size="10" />원/0원 &nbsp;&nbsp;&nbsp; 
							<input type="checkbox" /> 모두사용하기</td>
					</tr>
						
				</tbody>
			</table>
		</div>
		
		<div class="clear"></div>
		<br>
		<table width="80%" class="list_view" style="background:#ccffff">
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
						<p id="p_totalNum">${total_order_goods_qty}개</p>
						<input type="hidden" id="h_total_order_goods_qty" value="${total_order_goods_qty}"/>
					</td>
					
					<td>
						<p id="p_totalPrice">${total_order_price}원</p>
						<input type="hidden" id="h_totalPrice" value="${total_order_price}"/>
					</td>
					
					<td>
						<img width="25" alt="" src="${contextPath}/resources/image/plus.jpg"/>
					</td>
					
					<td>
						<p id="p_totalDelivery">${total_delivery_price}원</p>
						<input type="hidden" id="h_totalDelivery" value="${total_delivery_price}"/>
					</td>
					
					<td>
						<img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"/>
					</td>
					
					<td>
						<p id="p_totalSalesPrice">${total_discount_price}원</p>
						<input type="hidden" id="h_total_sales_price" value="${total_discount_price}"/>
					</td>
					
					<td>
						<img width="25" alt="" src="${contextPath}/resources/image/equal.jpg"/>
					</td>
					
					<td>
						<p id="p_final_totalPrice">
							<font size="15">${final_total_order_price}원</font>
						</p>
						<input type="hidden" id="h_final_total_Price" value="${final_total_order_price}"/>
					</td>
				</tr>
			</tbody>	
		</table>
		
		<div class="clear"></div>
		<br>
		<br>
		<br>
		<div class="detail_table">
			<table width="80%" class="list_view" style="background:#ccfff">
				<tbody>
					<tr>
						<td>
							<input type="radio" id="pay_method" name="pay_method" value="신용카드" onclick="fn_pay_card()" checked/>신용카드 &nbsp;&nbsp;&nbsp;
							<input type="radio" id="pay_method" name="pay_method" value="제휴 신용카드"  >제휴 신용카드 &nbsp;&nbsp;&nbsp; 
						   	<input type="radio" id="pay_method" name="pay_method" value="실시간 계좌이체">실시간 계좌이체 &nbsp;&nbsp;&nbsp;
						  	<input type="radio" id="pay_method" name="pay_method" value="무통장 입금">무통장 입금 &nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<td>
							<input type="radio" id="pay_method" name="pay_method" value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제 &nbsp;&nbsp;&nbsp;
						   	<input type="radio" id="pay_method" name="pay_method" value="카카오페이(간편결제)">카카오페이(간편결제) &nbsp;&nbsp;&nbsp; 
						   	<input type="radio" id="pay_method" name="pay_method" value="페이나우(간편결제)">페이나우(간편결제) &nbsp;&nbsp;&nbsp; 
						   	<input type="radio" id="pay_method" name="pay_method" value="페이코(간편결제)">페이코(간편결제) &nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<td>
							<input type="radio" id="pay_method" name="pay_method" value="직접입금"/>직접입금 &nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr id="tr_pay_card">
						<td>
							<strong>카드선택</strong> &nbsp;&nbsp;&nbsp;
							<select id="card_com_name" name="card_com_name">
								<option value="삼성" selected>삼성</option>
								<option value="하나SK">하나SK</option>
								<option value="현대">현대</option>
								<option value="KB">KB</option>
								<option value="신한">신한</option>
								<option value="롯데">롯데</option>
								<option value="BC">BC</option>
								<option value="시티">시티</option>
								<option value="NH농협">NH농협</option>
							</select>
							<br><br>
							
							<strong>할부기간</strong> &nbsp;&nbsp;&nbsp;
							<select id="card_pay_month" name="card_pay_method">
								<option value="일시불" selected>일시불</option>
								<option value="2개월">2개월</option>
								<option value="3개월">3개월</option>
								<option value="4개월">4개월</option>
								<option value="5개월">5개월</option>
								<option value="6개월">6개월</option>
							</select>
						</td>
					</tr>
					
					<tr id="tr_pay_phone" style="visibility:hidden">
						<td>
							<strong>휴대폰 번호 입력:</strong>
							<input type="text" size="5" id="pay_order_tel1" name="pay_order_tel1" value=""/>
							<input type="text" size="5" id="pay_order_tel2" name="pay_order_tel2" value=""/>
							<input type="text" size="5" id="pay_order_tel3" name="pay_order_tel3" value=""/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	
	<div class="clear"></div>
	<br><br><br>
	
	<center>
	<br><br>
		<a href="javascript:fn_show_order_detail();">
			<img width="125" alt="" src="${contextPath}/resources/image/btn_gulje.jpg">
		</a>
		<a>
			<img width="75" alt="" src="${contextPath}/resources/image/btn_shoping_continue.jpg"/>
		</a>
		
	<div class="clear"></div>
	<div id="layer" style="visibility:hidden">
		<!-- visibility:hidden 으로 설정하여 해당 <div>안의 모든 것들을 가려둔다 -->
		
		<div id="popup_order_detail">
			<!-- 팝업창 닫기 버튼 -->
			<a href="javascript:" onclick="javascript:imagePopup('close','layer01');">
				<img id="close" src="${contextPath}/resources/image/close.png">
			</a>
			<br>
			<div class="detail_table">
				<h1>최종 주문 사항</h1>
				
				<table>
					<tbody align="left">
						<tr>
							<td width="200px">주문상품번호:</td>
							<td><p id="p_order_goods_id">주문번호</p></td>
						</tr>
						
						<tr>
							<td width="200px">주문상품명:</td>
							<td><p id="p_order_goods_title">주문 상품명</p></td>
						</tr>
						
						<tr>
							<td width="200px">주문상품개수:</td>
							<td><p id="p_total_order_goods_qty">주문상품개수</p></td>
						</tr>
						
						<tr>
							<td width="200px">주문금액합계:</td>
							<td><p id="p_total_order_goods_price">주문금액합계</p></td>
						</tr>
						
						<tr>
							<td width="200px">주문자:</td>
							<td><p id="p_orderer_name">주문자 이름</p></td>
						</tr>
						
						<tr>
							<td width="200px">받는사람:</td>
							<td><p id="p_receiver_name">받는사람이름</p></td>
						</tr>
						
						<tr>
							<td width="200px">배송방법:</td>
							<td><p id="p_delivery_method">배송방법</p></td>
						</tr>
						
						<tr>
							<td width="200px">받는사람 휴대폰 번호:</td>
							<td><p id="p_receiver_hp_num"></p></td>
						</tr>
						
						<tr>
							<td width="200px">받는사람 유선전화번호:</td>
							<td><p id="p_receiver_tel_num"></p></td>
						</tr>
						
						<tr>
							<td width="200px">배송주소:</td>
							<td align="left"><p id="p_delivery_address">배송주소</p></td>
						</tr>
						
						<tr>
							<td width="200px">배송메시지:</td>
							<td align="left"><p id="p_delivery_message">배송메시지</p></td>
						</tr>
						
						<tr>
							<td width="200px">선물포장 여부:</td>
							<td align="left"><p id="p_gift_wrapping">선물포장</p></td>
						</tr>
						
						<tr>
							<td width="200px">선물포장 여부:</td>
							<td align="left"><p id="p_gift_wrapping">선물포장</p></td>
						</tr>
						
						<tr>
							<td width="200px">결제방법:</td>
							<td><p id="p_pay_method">결제방법</p></td>
						</tr>
						
						<tr>
							<td colspan="2" align="center">
								<input type="button" name="btn_process_pay_order" onclick="fn_process_pay_order()" value="최종결제하기"/>
								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
<div class="clear"></div>






















