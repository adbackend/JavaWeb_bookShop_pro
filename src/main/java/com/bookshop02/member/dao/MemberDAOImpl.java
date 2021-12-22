package com.bookshop02.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop02.member.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	//로그인
	@Override
	public MemberVO login(Map loginMap) throws DataAccessException{
		
		MemberVO member = sqlSession.selectOne("mapper.member.login",loginMap);
		
		return member;
	}
	
	//아이디 중복 검사
	@Override
	public String selectOverlappedID(String id) throws DataAccessException{
		
		String result = sqlSession.selectOne("mapper.member.selectOverlappedID",id);
		
		return result;
	}
	
	//회원가입
	@Override
	public void insertNewMember(MemberVO memberVO) throws DataAccessException{
		
		sqlSession.insert("mapper.member.insertNewMember",memberVO);
	}
}
