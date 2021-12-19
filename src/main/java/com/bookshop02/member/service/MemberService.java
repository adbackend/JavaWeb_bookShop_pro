package com.bookshop02.member.service;

import java.util.Map;

import com.bookshop02.member.vo.MemberVO;

public interface MemberService {

	public MemberVO login(Map loginMap) throws Exception;
}
