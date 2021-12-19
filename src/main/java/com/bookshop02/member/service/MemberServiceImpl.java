package com.bookshop02.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.member.dao.MemberDAO;
import com.bookshop02.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	//로그인
	@Override
	public MemberVO login(Map loginMap) throws Exception{
		
		return memberDAO.login(loginMap);
	}

}
