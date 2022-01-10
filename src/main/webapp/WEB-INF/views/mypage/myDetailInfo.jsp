<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    
</script>

</head>
<body>

<h3>내 상세정보</h3>
<form name="frm_mod_member">
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td><input type="text" name="member_id" size="20" value="${memberInfo.member_id}" disabled/></td>
					<td></td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td><input type="password" name="member_pw" size="20" value="${memberInfo.member_pw}"/></td>
					<td><input type="button" value="수정하기" onclick="fn_modify_member_info('member_pw')"/></td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td><input type="text" name="member_name" size="20" value="${memberInfo.member_name}" disabled/></td>
					<td></td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">성별</td>
					<td>
						<c:choose>
							<c:when test="${memberInfo.member_gender=='101'}">
								<input type="radio" name="member_gender" value="102"/>여성
								<span style="padding-left:30px"></span>
								<input type="radio" name="member_gender" value="101" checked/>남성
							</c:when>
							<c:otherwise>
								<input type="radio" name="member_gender" value="102" checked/>여성
								<span style="padding-left:30px"></span>
								<input type="radio" name="member_gender" value="101"/>남성
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<input type="button" value="수정하기" onclick="fn_modify_member_info('member_gender')"/>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">법정생년월일</td>
					<td>
						<select name="member_birth_y">
							<c:forEach var="i" begin="1" end="100">
								<c:choose>
									<c:when test="${memberInfo.membe_birth_y==1920+i}">
										<option value="${1920+i}" selected>${1920+i}</option>
									</c:when>
									<c:otherwise>
										<option value="${1920+i}">${1920+i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>년
						
						<select name="member_birth_m">
							<c:forEach var="i" begin="1" end="12">
								<c:choose>
									<c:when test="${memberInfo.member_birth_m==i}">
										<option value="${i}" selected>${i}</option>
									</c:when>
									<c:otherwise>
										<option value="${i}">${i}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>월
						
						<select name="member_birth_d">
							<c:forEach var="i" begin="1" end="31">
								<c:when test="${memberInfo.member_birth_d==i}">
									<option value="${i}" selected>${i}</option>
								</c:when>
								<c:otherwise>
									<option value="${i}">${i}</option>
								</c:otherwise>
							</c:forEach>
						</select>일 <span style="padding-left:50px"></span>
						
						<c:choose>
							<c:when test="${memberInfo.member_birth_gn=='2'}">
								<input type="radio" name="member_birth_gn" value="2" checked/>양력
								<span style="padding-left:20px"></span>
								<input type="radio" name="member_birth_gn" value="1"/>음력
							</c:when>
							<c:otherwise>
								<input type="radio" name="member_birth_gn" value="2"/>양력
								<input type="radio" name="member_birth_gn" value="1" checked/>음력
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<input type="button" value="수정하기" onclick="fn_modify_member_info('member_birth')"/>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">전화번호</td>
					<td>
						<select name="tel1" id="tel1">
							<option value="00">없음</option>
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
						-<input type="text" name="tel2" value="${memberInfo.tel2}"/>
						-<input type="text" name="tel3" value="${memberInfo.tel3}"/>
					</td>
					<td>
						<input type="button" value="수정하기" onclick="fn_modify_member_info('tel')"/>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">휴대폰 번호</td>
					<td>
						<select name="hp1" id="hp1">
							<option>없음</option>
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						-<input type="text" name="hp2" value="${memberInfo.hp2}"/>
						-<input type="text" name="hp3" value="${memberInfo.hp3}"/><br><br>
						
						<c:choose>
							<c:when test="${memberInfo.smssts_yn=='true'}">
								<input type="checkbox" name="smssts_yn" value="Y" checked/>쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="smssts_yn" value="N"/>쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<input type="button" value="수정하기" onclick="fn_modify_member_info('hp')"/>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					<td>
						<input type="text" name="email1" value="${memberInfo.email1}" size="10"/>@<input type="text" name="email2" value="${memberInfo.email2}" size="10"/>
						<select name="select_email2" onchange="" title="직접입력">
							<option value="non">직접입력</option>
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
						</select><br><br>
						
						<c:choose>
							<c:when test="${memberInfo.emailsts_yn=='true'}">
								<input type="checkbox" name="emailsts_yn" value="Y" checked/>쇼핑몰에서 발송하는 e-mail을 수신합니다.
							</c:when>
							<c:otherwise>
								<input type="checkbox" name="emailsts_yn" value="N"/>쇼핑몰에서 발송하는 e-mail을 수신합니다.
							</c:otherwise>
						</c:choose>
					</td>
					
					<td>
						<input type="button" value="수정하기" onclick="fn_modify_member_info('email')"/>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
						<input type="text" id="zipcode" name="zipcode" value="${memberInfo.zipcode}"/><a href="javascript:execDaumPostcode()">우편번호검색</a>
					</td>
				</tr>
				
			</tbody>
		</table>
	</div>
</form>


</body>
</html>










