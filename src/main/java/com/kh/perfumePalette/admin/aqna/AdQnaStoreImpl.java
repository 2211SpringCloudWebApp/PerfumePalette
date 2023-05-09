package com.kh.perfumePalette.admin.aqna;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.perfumePalette.PageInfo;
import com.kh.perfumePalette.Search;

@Repository
public class AdQnaStoreImpl implements AdQnaStore {

	@Override
	public List<AdQnaBoard> selectAllQna(SqlSession session, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int currentPage = pi.getCurrentPage();
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("AdminMapper.selectAdQnaList", null, rowBounds);
	}

	@Override
	public int deleteAdReview(SqlSession session, int i) {
		return session.delete("AdminMapper.deleteQna", i);
	}

	@Override
	public int getListCount(SqlSession session, Search search) {
		return session.selectOne("AdminMapper.getSearchQListCount", search);
	}

	@Override
	public List<AdQnaBoard> selectListByKeyword(SqlSession session, PageInfo pi, Search search) {
		int limit = pi.getBoardLimit();
		int currentPage = pi.getCurrentPage();
		int offset = (currentPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("AdminMapper.selectQListByKeyword", search, rowBounds);
	}

	@Override
	public int getListCount(SqlSession session) {
		return session.selectOne("AdminMapper.getQListCount");
	}

}
