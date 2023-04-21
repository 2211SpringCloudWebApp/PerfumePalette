package com.kh.perfumePalette.admin.amember;

import java.util.List;

import com.kh.perfumePalette.Search;
import com.kh.perfumePalette.member.Member;

public interface AdMemberService {

	/**
	 * 회원 수정
	 * @param member
	 * @return int
	 */
	int updateAmModify(Member member);
	
	/**
	 * 회원 리스트
	 * @return List<Member> 
	 */
	List<Member> selectAdMemberList();

	/**
	 * 회원 상세 정보
	 * @param memberNo
	 * @return Member
	 */
	Member selectOneByNo(int memberNo);

	/**
	 * 회원 다중 삭제
	 * @param memberNo
	 * @return int
	 */
	int deleteAdMember(int memberNo);

	/**
	 * 리뷰 검색 갯수 Service
	 * @param search
	 * @return int
	 */
	int getListCount(Search search);

	/**
	 * 리뷰 검색 Service
	 * @param search
	 * @return List<Member>
	 */
	List<Member> selectListByKeyword(Search search);


}
