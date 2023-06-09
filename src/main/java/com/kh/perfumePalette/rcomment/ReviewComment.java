package com.kh.perfumePalette.rcomment;

import java.sql.Timestamp;

public class ReviewComment {
	private int commentNo;
	private int reviewNo;
	private int memberNo;
	private int pcommentNo;
	private String commentContent;
	private Timestamp commentDate;
	private String memberNickname;

	// 작성한 댓글에 있는 제품정보 추가
	private int perfumeNo;
	private String perfumeBrand;
	private String perfumeName;
	
	public ReviewComment() {
		super();
	}

	public ReviewComment(int commentNo, int reviewNo, int memberNo, int pcommentNo, String commentContent,
			Timestamp commentDate, String memberNickname, int perfumeNo, String perfumeBrand, String perfumeName) {
		super();
		this.commentNo = commentNo;
		this.reviewNo = reviewNo;
		this.memberNo = memberNo;
		this.pcommentNo = pcommentNo;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		this.memberNickname = memberNickname;
		this.perfumeNo = perfumeNo;
		this.perfumeBrand = perfumeBrand;
		this.perfumeName = perfumeName;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getPcommentNo() {
		return pcommentNo;
	}

	public void setPcommentNo(int pcommentNo) {
		this.pcommentNo = pcommentNo;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Timestamp getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Timestamp commentDate) {
		this.commentDate = commentDate;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public int getPerfumeNo() {
		return perfumeNo;
	}

	public void setPerfumeNo(int perfumeNo) {
		this.perfumeNo = perfumeNo;
	}

	public String getPerfumeBrand() {
		return perfumeBrand;
	}

	public void setPerfumeBrand(String perfumeBrand) {
		this.perfumeBrand = perfumeBrand;
	}

	public String getPerfumeName() {
		return perfumeName;
	}

	public void setPerfumeName(String perfumeName) {
		this.perfumeName = perfumeName;
	}

	@Override
	public String toString() {
		return "ReviewComment [commentNo=" + commentNo + ", reviewNo=" + reviewNo + ", memberNo=" + memberNo
				+ ", pcommentNo=" + pcommentNo + ", commentContent=" + commentContent + ", commentDate=" + commentDate
				+ ", memberNickname=" + memberNickname + ", perfumeNo=" + perfumeNo + ", perfumeBrand=" + perfumeBrand
				+ ", perfumeName=" + perfumeName + "]";
	}

}
