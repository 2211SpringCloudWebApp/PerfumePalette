package com.kh.perfumePalette.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.perfumePalette.PageInfo;
import com.kh.perfumePalette.like.Like;
import com.kh.perfumePalette.perfume.Perfume;
import com.kh.perfumePalette.rcomment.ReviewComment;
import com.kh.perfumePalette.report.Report;

@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	private ReviewStore rStore;
	
	@Autowired
	private SqlSession session;
	
	
	@Override
	public Perfume selectOneByPerfumeNo(Integer perfumeNo) {
		Perfume perfume = rStore.selectOneByPerfumeNo(perfumeNo,session);
		return perfume;
	}


	@Override
	public int insertReview(Review review) {
		int result = rStore.insertReview(session, review);
		return result;
	}


	@Override
	public List<Review> selectAllReview(PageInfo  pi) {
		List<Review> rList = rStore.selectAllReview(session, pi);
		return rList;
	}


	@Override
	public Review selectOneReview(Integer reviewNo) {
		Review review = rStore.selectOneReview(session, reviewNo);
		return review;
	}


	@Override
	public int updateReviewCount(Integer reviewNo) {
		return rStore.updateReviewCount(session, reviewNo);
	}


	@Override
	public List<Review> selectListByKeyword(PageInfo pi, Search search) {
		List<Review> searchList = rStore.selectListByKeyword(session,pi,search);
		return searchList;
	}

	@Override
	public int getListCount(Search search) {
		int totalCount = rStore.getListCount(session, search);
		return totalCount;
	}
	
	@Override
	public int getListCount() {
		int result = rStore.getListCount(session);
		return result;
	}


	@Override
	public int updateReview(Review review) {
		int result = rStore.updateReview(session, review);
		return result;
	}

	@Override
		public int deleteReview(int reviewNo) {
			int result = rStore.deleteReview(session, reviewNo);
			return result;
		}
	@Override
	public int reviewReport(Report report) {
		int result = rStore.reviewReport(session, report);
		return result;
	}


	@Override
	public int selectReportCnt(Report report) {
		int result = rStore.selectReportCnt(session, report);
		return result;
	}


	@Override
	public int addLike(Like like) {
		int result = rStore.addLike(session, like);
		return result;
	}

	@Override
	public int selectCheckLike(Like like) {
		int result = rStore.selectCheckLike(session, like);
		return result;
	}


	@Override
	public int selectTotalCnt(Integer reviewNo) {
		int result = rStore.selectTotalCnt(session, reviewNo);
		return result;
	}


	@Override
	public int removeLike(Like like) {
		int result = rStore.removeLike(session, like);
		return result;
	}


	@Override
	public int insertComment(ReviewComment rComment) {
		int result = rStore.insertComment(session, rComment);
		return result;
	}


	@Override
	public List<ReviewComment> listComment(int reviewNo) {
		List<ReviewComment> rList = rStore.listComment(session, reviewNo);
		return rList;
	}


	@Override
	public int deleteComment(int commentNo) {
		int result = rStore.deleteComment(session, commentNo);
		return result;
	}


	

}
