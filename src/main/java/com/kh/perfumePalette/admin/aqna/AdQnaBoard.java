package com.kh.perfumePalette.admin.aqna;

import java.sql.Timestamp;

public class AdQnaBoard {
	
	private int qnaNo; // 게시글 번호
	private int perfumeNo; // 품번
	private String qnaType; // 게시글 분류 1 - 배송, 2 - 결제, 3 - 상품상세
	private String qnaSubject; // 게시글 제목
	private String qnaContents; // 게시글 내용
	private Timestamp qnaDate; // 작성일
	private int memberNo; // 멤버 번호(참조)
	private String qFilename; // 파일 이름
	private String qFilerename; // 파일 리네임
	private String qFilepath; // 파일 경로
	private Integer qnaPassword; // 게시글 비밀번호
	private String qQnaNo; // NULL이면 질문, 값이 있으먄 답변
	private String memberNickname; // 작성자(닉네임)
	private String replyStatus; // 답변 여부
	private String replyContents;
	private Timestamp repDate;
	
	private String perfumeBrand;
	private String perfumeName;
	private String pFilerename;	 	// 파일 리네임
	
	public AdQnaBoard() {}

	public AdQnaBoard(int qnaNo, int perfumeNo, String qnaType, String qnaSubject, String qnaContents,
			Timestamp qnaDate, int memberNo, String qFilename, String qFilerename, String qFilepath,
			Integer qnaPassword, String qQnaNo, String memberNickname, String replyStatus, String replyContents,
			Timestamp repDate, String perfumeBrand, String perfumeName, String pFilerename) {
		super();
		this.qnaNo = qnaNo;
		this.perfumeNo = perfumeNo;
		this.qnaType = qnaType;
		this.qnaSubject = qnaSubject;
		this.qnaContents = qnaContents;
		this.qnaDate = qnaDate;
		this.memberNo = memberNo;
		this.qFilename = qFilename;
		this.qFilerename = qFilerename;
		this.qFilepath = qFilepath;
		this.qnaPassword = qnaPassword;
		this.qQnaNo = qQnaNo;
		this.memberNickname = memberNickname;
		this.replyStatus = replyStatus;
		this.replyContents = replyContents;
		this.repDate = repDate;
		this.perfumeBrand = perfumeBrand;
		this.perfumeName = perfumeName;
		this.pFilerename = pFilerename;
	}

	
	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public int getPerfumeNo() {
		return perfumeNo;
	}

	public void setPerfumeNo(int perfumeNo) {
		this.perfumeNo = perfumeNo;
	}

	public String getQnaType() {
		return qnaType;
	}

	public void setQnaType(String qnaType) {
		this.qnaType = qnaType;
	}

	public String getQnaSubject() {
		return qnaSubject;
	}

	public void setQnaSubject(String qnaSubject) {
		this.qnaSubject = qnaSubject;
	}

	public String getQnaContents() {
		return qnaContents;
	}

	public void setQnaContents(String qnaContents) {
		this.qnaContents = qnaContents;
	}

	public Timestamp getQnaDate() {
		return qnaDate;
	}

	public void setQnaDate(Timestamp qnaDate) {
		this.qnaDate = qnaDate;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getqFilename() {
		return qFilename;
	}

	public void setqFilename(String qFilename) {
		this.qFilename = qFilename;
	}

	public String getqFilerename() {
		return qFilerename;
	}

	public void setqFilerename(String qFilerename) {
		this.qFilerename = qFilerename;
	}

	public String getqFilepath() {
		return qFilepath;
	}

	public void setqFilepath(String qFilepath) {
		this.qFilepath = qFilepath;
	}

	public Integer getQnaPassword() {
		return qnaPassword;
	}

	public void setQnaPassword(Integer qnaPassword) {
		this.qnaPassword = qnaPassword;
	}

	public String getqQnaNo() {
		return qQnaNo;
	}

	public void setqQnaNo(String qQnaNo) {
		this.qQnaNo = qQnaNo;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getReplyStatus() {
		return replyStatus;
	}

	public void setReplyStatus(String replyStatus) {
		this.replyStatus = replyStatus;
	}
	

	public String getReplyContents() {
		return replyContents;
	}

	public void setReplyContents(String replyContents) {
		this.replyContents = replyContents;
	}
	
	public Timestamp getRepDate() {
		return repDate;
	}

	public void setRepDate(Timestamp repDate) {
		this.repDate = repDate;
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

	public String getpFilerename() {
		return pFilerename;
	}

	public void setpFilerename(String pFilerename) {
		this.pFilerename = pFilerename;
	}

	
	@Override
	public String toString() {
		return "AdQnaBoard [qnaNo=" + qnaNo + ", perfumeNo=" + perfumeNo + ", qnaType=" + qnaType + ", qnaSubject="
				+ qnaSubject + ", qnaContents=" + qnaContents + ", qnaDate=" + qnaDate + ", memberNo=" + memberNo
				+ ", qFilename=" + qFilename + ", qFilerename=" + qFilerename + ", qFilepath=" + qFilepath
				+ ", qnaPassword=" + qnaPassword + ", qQnaNo=" + qQnaNo + ", memberNickname=" + memberNickname
				+ ", replyStatus=" + replyStatus + ", replyContents=" + replyContents + ", repDate=" + repDate
				+ ", perfumeBrand=" + perfumeBrand + ", perfumeName=" + perfumeName + "]";
	}

}
