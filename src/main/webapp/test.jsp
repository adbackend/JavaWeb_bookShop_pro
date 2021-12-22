<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function changeEmail ( email ) {
	if(email == "1") {
	document.getElementById("email3").style.display = "block";
	document.frm.email3.value = "";
	} else {
	document.getElementById("email3").style.display = "none";
	document.frm.email3.value = email;
	}
	}
	</script>

	<form name="frm">
	<input name="email1" type="text"> @
	<select name="email2" onChange=changeEmail(this.value)>
	<option value="" selected>이메일선택</option>
	<option value="naver.com">naver.com</option>
	<option value="dreamwiz.com">dreamwiz.com</option>
	<option value="empal.com">empal.com</option>
	<option value="hanmir.com">hanmir.com</option>
	<option value="hanafos.com">hanafos.com</option>
	<option value="hotmail.com">hotmail.com</option>
	<option value="lycos.co.kr">lycos.co.kr</option>
	<option value="nate.com">nate.com</option>
	<option value="paran.com">paran.com</option>
	<option value="netian.com">netian.com</option>
	<option value="yahoo.co.kr">yahoo.co.kr</option>
	<option value="kornet.net">kornet.net</option>
	<option value="nownuri.net">nownuri.net</option>
	<option value="unitel.co.kr">unitel.co.kr</option>
	<option value="freechal.com">freechal.com</option>
	<option value="korea.com">korea.com</option>
	<option value="orgio.net">orgio.net</option>
	<option value="chollian.net">chollian.net</option>
	<option value="hitel.net">hitel.net</option>
	<option value="1">직접입력</option>
	</select>
	<input type="text" name="email3" style="display:none">
	</form>
</script>
</head>
<body>

</body>
</html>