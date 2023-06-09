package com.kh.perfumePalette.qnaBoard;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.perfumePalette.PageInfo;

@Service
public class QnaBoardServiceImpl implements QnaBoardService {
	
	@Autowired
	private QnaBoardStore qbStore;
	@Autowired
	private SqlSession session;
	
	@Override
	public List<QnaBoard> selectAllQnaBoard(PageInfo pi) {
		List<QnaBoard> qbList =  qbStore.selectAllQnaBoard(session, pi);
		return qbList;
	}

	@Override
	public int writeQnaBoard(QnaBoard qnaboard) {
		int result = qbStore.writeQnaBoard(session, qnaboard);
		return result;
	}

	@Override
	public QnaBoard QnaBoardDetail(Integer qnaNo) {
		QnaBoard qnaboard = qbStore.QnaBoardDetail(session, qnaNo);
		return qnaboard;
	}

	@Override
	public QnaBoard selectOneByNo(Integer qnaNo) {
		QnaBoard qnaboard = qbStore.selectOneByNo(session, qnaNo);
		return qnaboard;
	}

	@Override
	public int updateqnaBoard(QnaBoard qnaboard) {
		int result = qbStore.updateqnaBoard(session, qnaboard);
		return result;
	}

	@Override
	public int deleteQnaBoard(int qnaNo) {
		int result = qbStore.deleteQnaBoard(session, qnaNo);
		return result;
	}

	@Override
	public int getqnaBoardCount() {
		int result  = qbStore.getqnaBoardCount(session);
		return result;
	}

	@Override
	public int insertReply(QnaReply qnaReply) {
		int result = qbStore.insertReply(session, qnaReply);
		return result;
	}

	@Override
	public List<QnaReply> selectAllReply(Integer qnaNo) {
		List<QnaReply> qrlist = qbStore.selectAllReply(session, qnaNo);
		return qrlist;
	}

	@Override
	public void updateReplyStatus(int repQnaNo, String replyStatus) {
		qbStore.updateReplyStatus(session, repQnaNo, replyStatus);
		
	}

	@Override
	public int deleteReply(Integer replyNo) {
		int result = qbStore.deleteReply(session, replyNo);
		return result;
	}

	@Override
	public int samepwd(Integer qnaNo) {
		int result = qbStore.samepwd(session, qnaNo);
		return result;
	}

	@Override
	public int updateReply(QnaReply qnareply) {
		int result = qbStore.updateReply(session, qnareply);
		return result;
	}

	@Override
	public List<QnaBoard> selectAllQnaBoardPerfume(Integer perfumeNo) {
		List<QnaBoard> qbList =  qbStore.selectAllQnaBoardPerfume(session, perfumeNo);
		return qbList;
	}

	@Override
	public int selectAllQnaBoardPerfumeCnt(Integer perfumeNo) {
		int result = qbStore.selectAllQnaBoardPerfumeCnt(session, perfumeNo);
		return result;
	}

	
		
	


}