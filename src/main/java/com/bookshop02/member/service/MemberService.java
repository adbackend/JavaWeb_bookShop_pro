package com.bookshop02.member.service;

import java.util.Map;

import com.bookshop02.member.vo.MemberVO;

public interface MemberService {

	public MemberVO login(Map loginMap) throws Exception; //로그인
	
	public String overlapped(String id) throws Exception; //아이디 중복체크
	
	public void addMember(MemberVO memberVO) throws Exception; //회원가입
}
