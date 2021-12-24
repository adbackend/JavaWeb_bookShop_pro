package com.bookshop02.member.vo;

import org.springframework.stereotype.Component;

/**
  * @FileName : MemberVO.java
  * @Date : 2021. 12. 19. 
  * @Author : 최유정
  * @Description : 24개 컬럼
  */

@Component("memberVO")
public class MemberVO {

	private String member_id; //회원 아이디
	private String member_pw; //비밀번호
	private String member_name; //이름
	private String member_gender; //성별
	
	private String tel1; //유선전화1
	private String tel2;
	private String tel3; 
	
	private String hp1; //휴대폰1
	private String hp2; 
	private String hp3;
	
	private String smssts_yn; //sms 메세지 수신여부
	private String email1; //이메일주소1
	private String email2; //이메일주소2
	private String emailsts_yn; //이메일 수신여부
	
	private String zipcode; //우편번호
	private String roadAddress; //도로명 주소
	private String jibunAddress; //지번주소
	private String namujiAddress; //나머지 주소
	
	private String member_birth_y; //생일 년
	private String member_birth_m; //생일 월
	private String member_birth_d; //생일 일
	private String member_birth_gn; //생일 양음력 여부
	
	private String joindate; //회원가입일
	private String del_yn; //회원탈퇴 유무
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getHp1() {
		return hp1;
	}
	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}
	public String getHp2() {
		return hp2;
	}
	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}
	public String getHp3() {
		return hp3;
	}
	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}
	public String getSmssts_yn() {
		return smssts_yn;
	}
	public void setSmssts_yn(String smssts_yn) {
		this.smssts_yn = smssts_yn;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getEmailsts_yn() {
		return emailsts_yn;
	}
	public void setEmailsts_yn(String emailsts_yn) {
		this.emailsts_yn = emailsts_yn;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getRoadAddress() {
		return roadAddress;
	}
	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}
	public String getJibunAddress() {
		return jibunAddress;
	}
	public void setJibunAddress(String jibunAddress) {
		this.jibunAddress = jibunAddress;
	}
	public String getNamujiAddress() {
		return namujiAddress;
	}
	public void setNamujiAddress(String namujiAddress) {
		this.namujiAddress = namujiAddress;
	}
	public String getMember_birth_y() {
		return member_birth_y;
	}
	public void setMember_birth_y(String member_birth_y) {
		this.member_birth_y = member_birth_y;
	}
	public String getMember_birth_m() {
		return member_birth_m;
	}
	public void setMember_birth_m(String member_birth_m) {
		this.member_birth_m = member_birth_m;
	}
	public String getMember_birth_d() {
		return member_birth_d;
	}
	public void setMember_birth_d(String member_birth_d) {
		this.member_birth_d = member_birth_d;
	}
	public String getMember_birth_gn() {
		return member_birth_gn;
	}
	public void setMember_birth_gn(String member_birth_gn) {
		this.member_birth_gn = member_birth_gn;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	
	@Override
	public String toString() {
		return "MemberVO [member_id=" + member_id + ", member_pw=" + member_pw + ", member_name=" + member_name
				+ ", member_gender=" + member_gender + ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3 + ", hp1="
				+ hp1 + ", hp2=" + hp2 + ", hp3=" + hp3 + ", smssts_yn=" + smssts_yn + ", email1=" + email1
				+ ", email2=" + email2 + ", emailsts_yn=" + emailsts_yn + ", zipcode=" + zipcode + ", roadAddress="
				+ roadAddress + ", jibunAddress=" + jibunAddress + ", namujiAddress=" + namujiAddress
				+ ", member_birth_y=" + member_birth_y + ", member_birth_m=" + member_birth_m + ", member_birth_d="
				+ member_birth_d + ", member_birth_gn=" + member_birth_gn + ", joindate=" + joindate + ", del_yn="
				+ del_yn + "]";
	}
	
	

	
	
}
