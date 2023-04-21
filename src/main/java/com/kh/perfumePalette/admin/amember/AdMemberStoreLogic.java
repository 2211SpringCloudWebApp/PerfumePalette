package com.kh.perfumePalette.admin.amember;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.perfumePalette.Search;
import com.kh.perfumePalette.member.Member;

@Repository
public class AdMemberStoreLogic implements AdMemberStore {

	
	@Override
	public int updateAmModify(SqlSession session, Member member) {
		return session.update("AdminMapper.updateAdMemberModify", member);
	}
	
	@Override
	public List<Member> selectAdMemberList(SqlSession session) {
		List<Member> amList = session.selectList("AdminMapper.selectAdMemberList");
		return amList;
	}

	@Override
	public Member selectOneByNo(SqlSession session, int memberNo) {
		return session.selectOne("AdminMapper.selectAdMemberDetail", memberNo);
	}

	@Override
	public int deleteAdMember(SqlSession session, int memberNo) {
		return session.delete("AdminMapper.deleteMember", memberNo);
	}

	@Override
	public int getListCount(SqlSession session, Search search) {
		return session.selectOne("AdminMapper.getSearchMListCount", search);
	}

	@Override
	public List<Member> selectListByKeyword(SqlSession session, Search search) {
		return session.selectList("AdminMapper.selectMListByKeyword", search);
	}


}
