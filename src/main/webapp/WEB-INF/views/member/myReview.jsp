<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성 후기</title>
<link rel="stylesheet" href="../../../resources/memberCss/myReview.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon"
	href="../../resources/img/common/favicon.png" />
<style>
main table img {
	height: 70px;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<main>
		<!-- 헤더 부분 피하기 위한 div -->
		<div id="forHeader"></div>
		<!-- 본문 내용 가운데 정렬 위한 div -->
		<div id="forCenter"></div>
		<!-- 사이드바 -->
		<div id="hrefList">
			<div id="hrefName">${member.memberName }님</div>
			<span><a href="/member/myPage">마이페이지</a></span> <span><a
				href="/member/orderList">주문내역조회</a></span> <span><a
				href="/member/myReview">작성후기</a></span> <span><a
				href="/member/myQna">작성문의</a></span> <span><a
				href="/member/myComment">작성댓글</a></span> <span><a href="/member/bye">회원탈퇴</a></span>
		</div>

		<!-- 여기부터 내용 입력하시면 됩니다! -->

		<div class="content">
			<h1>내가 작성한 후기</h1>
			<table>
				<thead>
					<!-- 테이블 헤더 -->
					<tr>
						<th style="width: 105px;"><input type="checkbox"
							class="allCheck" id="thCheck"></th>
						<th style="width: 96px;">번호</th>
						<th style="width: 60px;"></th>
						<th style="width: 350px;">상품명</th>
						<th style="width: 355px;">내용</th>
						<th style="width: 150px;">작성일</th>
						<th style="width: 150px;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${myReviews }" var="review" varStatus="i">
						<tr>
							<td><input type="checkbox" class="check" id="tdCheck"
								value="${review.reviewNo}"></td>
							<td>${i.count }</td>
							<td>
								<div>
									<a href="/perfume/detail/${review.perfumeNo}"> <img
										src="../../../../resources/img/perfumeFileUploads/${review.pFilerename}"
										alt="상품이미지">
									</a>
								</div>
							</td>
							<td><a href="/perfume/detail/${review.perfumeNo}">
									[${review.perfumeBrand }] ${review.perfumeName }</td>
							</a>
							<td>
								<a href="/review/reviewDetail/${review.reviewNo}"> 
								<c:out value="${fn:substring(review.reviewContents, 0, 19)}${fn:length(review.reviewContents) > 19 ? '...' : ''}" />
								</a>
							</td>
							<td><fmt:formatDate value="${review.reviewDate }"
									pattern="yyyy-MM-dd" /></td>
							<td>${review.rViewcount }</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr style="border: none;">
						<td><button type="button" id="del" style="margin-top: 30px;">선택삭제</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />


	<script>
    // 전체 선택 박스   
	var allCheck = document.querySelector(".allCheck");
	var list = document.querySelectorAll(".check");
	allCheck.onclick = () => {
		if(allCheck.checked) {
			for(var i = 0; i < list.length; i++) {
				list[i].checked = true;
			}
		} else {
			for(var i = 0; i < list.length; i++) {
				list[i].checked = false;
			}
		}
	}
	
	// 선택 박스 클릭
	var list = document.querySelectorAll(".check");
	for (var i = 0; i < list.length; i++) {
	  list[i].addEventListener('click', function () {
	    var isAllChecked = true;
	    for (var j = 0; j < list.length; j++) {
	      if (!list[j].checked) {
	        isAllChecked = false;
	        break;
	      }
	    }
	    if (isAllChecked) {
	      allCheck.checked = true;
	    } else {
	      allCheck.checked = false;
	    }
	  });
	}
	
	
	// 선택 삭제 
	document.querySelector("#del").addEventListener('click', function() {
		
		// 선택된 체크박스들의 value값을 저장할 배열을 선언 
		var del = new Array();
		
		// .check 클래스를 가진 요소들을 모두 선택하여 배열에 담음 
		var list = document.querySelectorAll(".check");
		for(var i = 0; i < list.length; i++) {
			if(list[i].checked) {
				del.push(list[i].value);
			}
		}
		
		// del 배열이 비어있는 경우 경고창 띄우고 함수 종료하기 
		if(del.length === 0 ) {
			alert("삭제할 항목을 선택해 주세요.");
			return;
		}
		
		// "선택한 후기를 삭제 하시겠습니까?" 라는 메시지와 함께 확인/취소 버튼이 있는 경고창 띄우기
		if(confirm("선택한 후기를 삭제 하시겠습니까?")) {
			// Ajax를 이용하여 서버에 선택한 체크박스의 value 값을 전송하여 삭제
			$.ajax({
				url:'/member/removeReview',
				type : 'post',
				dataType : 'json',
				traditional : 'true',
				data : {'arr':del},
				success : function(data){
					// 삭제가 성공적으로 이루어졌을 경우, "삭제되었습니다." 라는 경고창 띄우기
					if(data == 1) {
						alert("삭제되었습니다.");
						// 삭제가 완료되면 마이페이지의 작성후기 페이지로 이동
						location.href = "/member/myReview";
					}
				},
				error : function(data) {
					console.log(data)
				}
			});
		}
	});






	
	
    </script>
</body>
</html>