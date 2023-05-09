package com.kh.perfumePalette.admin.aqna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.perfumePalette.PageInfo;
import com.kh.perfumePalette.Search;

@Service
public class AdQnaServiceImpl implements AdQnaService {

	@Autowired
	private AdQnaStore qStore;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<AdQnaBoard> selectAllQna(PageInfo pi) {
		return qStore.selectAllQna(session, pi);
	}

	@Override
	public int deleteAdReview(int i) {
		return qStore.deleteAdReview(session, i);
	}

	@Override
	public int getListCount(Search search) {
		return qStore.getListCount(session, search);
	}

	@Override
	public List<AdQnaBoard> selectListByKeyword(PageInfo pi, Search search) {
		return qStore.selectListByKeyword(session, pi, search);
	}

	@Override
	public int getListCount() {
		return qStore.getListCount(session);
	}

}
