package com.kh.perfumePalette.admin.aqna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.perfumePalette.PageInfo;
import com.kh.perfumePalette.Search;

public interface AdQnaStore {

	List<AdQnaBoard> selectAllQna(SqlSession session, PageInfo pi);

	int deleteAdReview(SqlSession session, int i);

	int getListCount(SqlSession session, Search search);

	List<AdQnaBoard> selectListByKeyword(SqlSession session, PageInfo pi, Search search);

	int getListCount(SqlSession session);

}
