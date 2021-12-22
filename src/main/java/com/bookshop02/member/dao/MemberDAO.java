package com.bookshop02.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.member.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO login(Map loginMap) throws DataAccessException; //로그인
	
	public String selectOverlappedID(String id) throws DataAccessException; //아이디 중복체크
	
	public void insertNewMember(MemberVO memberVO) throws DataAccessException; //회원가입
}
