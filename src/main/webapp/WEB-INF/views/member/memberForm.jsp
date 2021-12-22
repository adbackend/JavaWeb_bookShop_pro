<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("jibunAddress").value = extraAddr;
                
                } else {
                    document.getElementById("jibunAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("jibunAddress").value = addr;
                document.getElementById("roadAddress").value = data.roadAddress;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("namujiAddress").focus();
            }
        }).open();
    }
    
    //아이디 중복체크
    function fn_overlapped(){
    	var _id = $("#_member_id").val();
    	
    	if(_id==''){
    		alert("ID를 입력하세요");
    		return;
    	}
    	
    	if((_id<"0" || _id>"9") && (_id<"A" || _id>"Z") && (_id<"a" || _id>"z") ){
    		alert("한글 및 특수 문자는 아이디로 사용할 수 없습니다.");
    		return ;
    	}
    	
    	
    	$.ajax({
    		type:"post",
    		async:false,
    		url:"${contextPath}/member/overlapped.do",
    		dataType:"text",
    		data:{id:_id},
    		success:function(data,textStatus){
    			
    			if(data=='false'){

    				alert("사용할 수 있는 ID입니다.");
	    			$("btnOverlapped").prop("disabled",true);
	    			$("_member_id").prop("disabled",true);
	    			$("_member_id").val(_id);
    				
    			}else{
    				alert("사용할 수 없는 ID입니다.");
    			}
    		},
    		error:function(data,textStatus){
    			alert("에러가 발생했습니다.");
    		},
    		complete:function(data,textStatus){
//     			alert("작업을 완료했습니다.");
    		}
    	}); //end ajax
    	
    }
    
    //이메일
//     function email_change(email){
//     	if(email=="1")){ //직접입력
//     		document.getElementById("email2").style.display="block";
//     		document.frm.email2.value="";
//     	}else{
//     		document.getElemetById("email2").style.display="none";
//     		document.frm.email2.value=email;
//     	}
//     }
    
    function password_check(){

	var member_pw = document.frm.member_pw.value;
	var member_pw2 = document.frm.member_pw2.value;
	
	if(member_pw.length<4 || member_pw2.length >16) { //비밀번호는 4~16자리
		alert("비밀번호는 4~16자리만 이용가능 합니다.");
		document.getElementById("member_pw").value=document.getElementById("member_pw2").value='';
		document.getElementById("same").innerHTML='';
	}
	
	if(document.getElementById("member_pw").value!='' && document.getElementById("member_pw2").value!=''){
		if(document.getElementById("member_pw").value==document.getElementById("member_pw2").value){
			document.getElementById("same").innerHTML="비밀번호 일치";
			document.getElementById("same").style.color="blue";
		}else{
			document.getElementById("same").innerHTML="비밀번호 불일치";
			document.getElementById("same").style.color="red";
			document.frm.member_pw2.value=""; //초기화
		}
	}
}

    
    
    
    //이메일 직접입력, 선택
    function email_change(email){
    	alert("이메일");
    	if(email=="1"){
    		document.frm.email2.value=""; //직접입력칸 초기화
    		document.frm.email2.disabled=false;
    	}else{
    		
    		document.frm.email2.value=email;
    		document.frm.email2.disabled=true;
    	}
    }
    
</script>
</head>
<body>
	<h3>필수 입력사항</h3>
	<form  name="frm" action="${contextPath}/member/addMember.do" method="post">
		<div id="detail_table">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">아이디</td>
						<td>
							<input type="text" name="_member_id" id="_member_id" size="20"/>
							<input type="hidden" name="member_id" id="member_id"/>
							<input type="button" id="btnOverlapped" value="중복체크" onClick="fn_overlapped()"/>
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">비밀번호</td>
						<td><input type="password" name="member_pw" id="member_pw" size="20" onChange="password_check()"/></td>
					</tr>

					<tr class="dot_line">
						<td class="fixed_join">비밀번호 확인</td>
						<td>
							<input type="password" name="member_pw2"  id="member_pw2" size="20"/>
							<span id="same"></span>
						</td>
					</tr>
					
					
					
					<tr class="dot_line">
						<td class="fixed_join">이름</td>
						<td><input type="text" name="member_name" size="20"/></td>
					</tr>
					
					<tr>
						<td class="fixed_join">성별</td>
						<td>
							<input type="radio" name="member_gender" value="102"/>여성
							<span style="padding-left:120px"></span>
							<input type="radio" name="member_gender" value="101" checked/>남성
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">법정생년월일</td>
						<td>
							<select name="member_birth_y">
								<c:forEach var="year" begin="1" end="100">
									<c:choose>
										<c:when test="${year==80 }">
											<option value="${1920+year}" selected>${1920+year}</option>
										</c:when>
									
										<c:otherwise>
											<option value="${1920+year}">${1920+year}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>년
							
							<select name="member_birth_m">
								<c:forEach var="month" begin="1" end="12">
									<c:choose>
										<c:when test="${month==5}">
											<option value="${month}" selected>${month}</option>
										</c:when>
										
										<c:otherwise>
											<option value="${month}">${month}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>월
							
							<select name="member_birth_d">
								<c:forEach var="day" begin="1" end="31">
									<c:choose>
										<c:when test="${day==10}">
											<option value="${day}" selected>${day}</option>
										</c:when>
										
										<c:otherwise>
											<option value="${day}">${day}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>일
								<span style="padding-left:50px"></span>
								<input type="radio" name="member_birth_gn" value="2" checked/>양력
								<span style="padding-left:50px"></span>
								<input type="radio" name="member_birth_gn" value="1"/>음력
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">전화번호</td>
						<td>
							<select name="tel1">
								<option>없음</option>
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
							</select> - <input type="text" name="tel2" size="10px"/> - <input type="text" name="tel3" size="10px"/>
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">휴대폰번호</td>
						<td>
							<select name="hp1">
								<option>없음</option>
								<option selected value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							- <input type="text" name="hp2" size="10px"/> - <input type="text" name="hp3" size="10px"/>
							<br><br>
							<input type="checkbox" name="smssts_yn" value="Y" checked/>쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
						</td>
					</tr>
					
					<tr class="dot_line">
						<td class="fixed_join">이메일<br>(e-mail)</td>
						<td>
							<input type="text" name="email1" size="10px"/> 
							@ <input type="text" name="email2" size="10px"/>
							
								<select name="emailAddr" id="email_select" onChange="email_change(this.value)" >
									<option value="" selected>==이메일 선택==</option>
									<option value="1">직접입력</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="paran.com">paran.com</option>
									<option value="nate.com">nate.com</option>
									<option value="google.com">google.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="empal.com">empal.com</option>
									<option value="korea.com">korea.com</option>
									<option value="freechal.com">freechal.com</option>
								</select>
								<br><br>
								<input type="checkbox" name="emailsts_yn" value="Y" checked/>쇼핑몰에서 발송하는 e-mail을 수신합니다.
						</td>
					</tr>
					
					<tr class="dot_line">
							<td class="fixed_join">주소</td>
							<td>
								<input type="text" id="zipcode" size="10"/><a href="javascript:sample6_execDaumPostcode()">우편번호 검색</a>
								<p>
									도로명 주소:<br><input type="text" id="roadAddress" name="roadAddress" size="50"/><br><br>
									지번 주소: <input type="text" id="jibunAddress" name="jibunAddress" size="50"/><br><br>
									<span id="guide" style="color:#999;display:none"></span>
									나머지 주소:<input type="text" id="namujiAddress" name="namujiAddress" size="50"/>
								</p>
							</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="clear">
			<br><br>
			<table align="center">
				<tr>
					<td>
						<input type="submit" value="회원가입"/>
						<input type="reset" value="다시입력"/>
					</td>
				</tr>
			</table>
		</div>
		
	</form>
</body>
</html>







