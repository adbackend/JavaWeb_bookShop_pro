package com.bookshop02.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.member.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO login(Map loginMap) throws DataAccessException;
}
