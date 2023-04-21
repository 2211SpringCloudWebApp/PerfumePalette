package com.kh.perfumePalette.admin.aqna;

import java.util.List;

import com.kh.perfumePalette.Search;
import com.kh.perfumePalette.qnaBoard.QnaBoard;

public interface AdQnaService {

	/**
	 * 관리자 문의 리스트 Service
	 * @return
	 */
	List<QnaBoard> selectAllQna();

	/**
	 * 문의 선택 삭제 Service
	 * @param i
	 * @return int
	 */
	int deleteAdReview(int i);

	/**
	 * 문의 검색 갯수 Service
	 * @param search
	 * @return int
	 */
	int getListCount(Search search);

	/**
	 * 문의 검색 Service
	 * @param search
	 * @return List<QnaBoard>
	 */
	List<QnaBoard> selectListByKeyword(Search search);

}
