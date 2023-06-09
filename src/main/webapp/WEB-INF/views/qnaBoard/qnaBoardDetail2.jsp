<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="../../../../resources/qnaCss/qnaBoardDetail2.css">
<!-- favicon : 탭에 보이는 아이콘-->
<link rel="icon" href="../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon" href="../../resources/img/common/favicon.png" />

</head>

<body>
	<jsp:include page="../common/header.jsp" />
	<main>
		<!-- 헤더 부분 피하기 위한 div -->
		<div id="forHeader"></div>
		<!-- 본문 내용 가운데 정렬 위한 div -->
		<div id="forCenter">
			<div class="container">
				<h1>문의 상세</h1>
				<div id="perfumeInfo">
					<div id="imgBox">
						<img src="../../../resources/img/perfumeFileUploads/${perfume.pFilerename }" alt="image">
					</div>
					<div id="infoBox">
						<div>${perfume.perfumeBrand }</div>
						<div>${perfume.perfumeName }</div>
						<div>${perfume.perfumeVolume }ml</div>
						<div>
							<fmt:formatNumber value="${perfume.perfumePrice }" pattern="#,##0" />
							원
						</div>
					</div>
				</div>
				<div id="category">
					<input type="hidden" class="radius" name="qnaType" value="${qnaboard.qnaType}">
					<c:if test="${qnaboard.qnaType == 1 }">
						<span class="qnatype"><strong>상품문의</strong></span>
					</c:if>
					<c:if test="${qnaboard.qnaType == 2 }">
						<span class="qnatype"><strong>배송문의</strong></span>
					</c:if>
					<c:if test="${qnaboard.qnaType == 3 }">
						<span class="qnatype"><strong>교환/환불</strong></span>
					</c:if>
					<c:if test="${qnaboard.qnaType == 4 }">
						<span class="qnatype"><strong>기타문의</strong></span>
					</c:if>
				</div>

				<input class="radius title" name="qnaSubject" value="${qnaboard.qnaSubject}" type="text" placeholder="제목을 입력해 주세요">
				<div id="textarea" style="padding: 10px;">${qnaboard.qnaContents }</div>
			</div>

			<div class="submit-btn">
				<!-- 작성자와 일치 or 관리자 -->
				<c:if test="${member.memberNo == qnaboard.memberNo || member.memberId == 'admin'}">
					<input type="button" value="수정" onclick="location.href='/qnaboard/modify2/${qnaboard.qnaNo}'">
					<input type="button" id="qnaboardDelete" value="삭제" onclick="removeCheck('${qnaboard.qnaNo}', '${qnaboard.perfumeNo}');">
					<input type="button" value="목록" onclick="location.href='/perfume/detail/${qnaboard.perfumeNo}'">
				</c:if>
				<!-- 작성자와 다르면서 관리자가 아닌 경우 -->
				<c:if test="${member.memberNo != qnaboard.memberNo && member.memberId != 'admin'}">
					<input type="button" value="목록" onclick="location.href='/perfume/detail/${qnaboard.perfumeNo}'">
				</c:if>
			</div>

			<c:if test="${member.memberId == 'admin'}">
				<!-- 답변이 안달렸을때 -->
				<!-- 댓글 등록 -->
				<c:if test="${qnaboard.replyStatus != 'Y' }">
					<table id="replyWriteBox">
						<tr>
							<td colspan="3">${member.memberNickname}</td>
						</tr>
						<tr>
							<td colspan="3"><textarea class="contentsinput" id="replyContents" maxlength="666" rows="6" cols="111" style="resize: none;"></textarea></td>
							<td><button id="rsubmit">등록하기</button></td>
						</tr>
					</table>
				</c:if>
			</c:if>

			<c:if test="${member.memberId != 'admin'}">
				<!-- 답변이 안달렸을때 -->
				<!-- 댓글 등록 -->
				<c:if test="${qnaboard.replyStatus != 'Y' }">
					<div id="repInput">등록된 답변이 존재하지 않습니다.</div>
				</c:if>
			</c:if>

			<!-- 댓글 목록 -->
			<table id="replyTable">
				<thead>
					<tr>
						<!-- 댓글 갯수 -->
						<!-- <td colspan="4"><b id="replyCount"></b></td> -->
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>

		</div>

	</main>
	<jsp:include page="../common/footer.jsp" />

	<script>
				// detail textarea 높이 자동 조절
				function resize() {
					let textarea = document.getElementById("textarea");

					textarea.style.height = "400px";

					let scrollHeight = textarea.scrollHeight;
					let style = window.getComputedStyle(textarea);
					let borderTop = parseInt(style.borderTop);
					let borderBottom = parseInt(style.borderBottom);

					textarea.style.height = (scrollHeight + borderTop + borderBottom) + "px";
				}

				window.addEventListener("load", resize);
				window.onresize = resize;

				// 삭제버튼 클릭한 경우 한번 더 묻는 팝업창 생성, 확인 시 삭제완료
				function removeCheck(qnaNo, perfumeNo) {
					if (confirm("정말 삭제하시겠습니까?")) {
						location.href = "/qnaboard/remove/" + qnaNo + "/" + perfumeNo;
					}
				}

				getReplyList();
				// 댓글 등록 ajax
				$("#rsubmit").on("click", function () {
					event.preventDefault();  // 버튼의 기본 동작을 막음
					const qnaNo = "${qnaboard.qnaNo}";
					const memberNo = "${member.memberNo}";
					const replyContents = $("#replyContents").val();
					console.log({
						repQnaNo: qnaNo,
						memberNo: memberNo,
						replyContents: replyContents
					});
					$.ajax({
						url: "/qnaboard/reply/register",  // ajax 요청을 보낼 URL
						data: {
							repQnaNo: qnaNo,
							memberNo: memberNo,
							replyContents: replyContents
						},
						type: "POST",  // ajax 요청 방식
						success: function (result) {
							if (result == '1') {
								alert("댓글이 등록되었습니다.");
								$("#replyContents").val("");  // 댓글 입력창 비우기
								getReplyList();
								document.getElementById('replyWriteBox').classList.add('hidden');
							}
						}
					})
				});

				// 댓글 목록을 가져오는 함수
				function getReplyList() {
					const qnaNo = "${qnaboard.qnaNo}"; // Q&A 게시물 번호
					$.ajax({
						url: "/qnaboard/reply/list", // 댓글 목록을 가져오는 URL
						data: { "qnaNo": qnaNo },
						type: "GET",
						success: function (data) {
							const tableBody = $("#replyTable tbody");
							tableBody.html("");
							console.log(data);
							let tr, rWriter, rContent, repDate, btnArea;
							if (data.length > 0) {
								for (let i in data) {
									tr = $("<tr>");
									rWriter = $("<td colspan='3'>").text("관리자");
									repDate = $("<td>").text(formatDate(data[i].repDate)).addClass("repDate"); // repDate 열에 CSS 클래스 추가

									tr.append(rWriter);
									tr.append(repDate);
									tableBody.append(tr);

									tr = $("<tr>");
									rContent = $("<td colspan='3'>").html(data[i].replyContents.replace(/\n/g, "<br>"));
									btnArea = $("<td>");

									// memberNo가 2인 경우에만 수정 및 삭제 버튼을 보여줌
									if ('${ member.memberNo }' == '2') {
										btnArea.append(
											$("<a href='javascript:void(0)' onclick='modifyReply(this, \"" + data[i].replyContents + "\", " + data[i].replyNo + ");'>수정</a>")
										).append(
											$("<a href='javascript:void(0)' onclick='removeReply(" + data[i].replyNo + ");'>삭제</a>")
										);
									}

									tr.append(rContent);
									tr.append(btnArea);
									tableBody.append(tr);
								}
							}
						},
						error: function () {
							alert("AJAX 처리 실패! 관리자 문의 요망");
						}
					});
				}

				// 날짜 형식을 변경하는 함수
				function formatDate(dateString) {
					var date = new Date(dateString);
					var year = date.getFullYear();
					var month = (date.getMonth() + 1).toString().padStart(2, '0');
					var day = date.getDate().toString().padStart(2, '0');
					return year + "/" + month + "/" + day;
				}

				// 댓글 삭제 ajax
				function removeReply(replyNo) {
					$.ajax({
						url: "/qnaboard/reply/delete",
						data: { "replyNo": replyNo },
						type: "get",
						success: function (data) {
							console.log(data); // data 출력
							if (data == "1") {
								alert("댓글이 삭제 되었습니다.");
								getReplyList();
								// 댓글 작성 폼을 보이도록 설정
								if (${ qnaboard.replyStatus != 'Y' }) {
						document.getElementById('replyWriteBox').classList.remove('hidden');
					}
				}
						},
				error: function () {
					alert("AJAX 삭제 처리 실패!");
				}
					})
				}

				// 댓글 수정 ajax
				function modifyReply(obj, replyContents, replyNo) {
					$(obj).closest('tr').next().remove();

					let trModify = $("<tr>");
					trModify.append("<td colspan='3'><textarea class='contentsinput' id='modifyContent' maxlength='666' rows='6' cols='111' style='resize: none;'>" + replyContents + "</textarea></td>");
					trModify.append("<td><button class='modifybtn' type='button' onclick='modifyReplyContents(" + replyNo + ");'>수정완료</button></td>");
					$(obj).closest('tr').after(trModify);
				}

				function modifyReplyContents(replyNo) {
					const modifiedContents = $("#modifyContent").val();
					$.ajax({
						url: "/qnaboard/reply/modify",
						data: { "replyNo": replyNo, "replyContents": modifiedContents },
						type: "post",
						success: function (data) {
							if (data === "1") {
								alert("댓글 수정 성공");
								getReplyList();
							} else {
								alert("댓글 수정 실패. 로그를 확인해주세요.");
								console.log(data);
							}
						},
						error: function () {
							alert("AJAX 처리 실패!");
						}
					});
				}

			</script>
</body>

</html>