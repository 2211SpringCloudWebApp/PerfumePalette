<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="../../../resources/perfumeCss/cartWish.css">
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon" href="../../../resources/img/common/favicon.png" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
	/* 		고정 */
	#id_ok, #pw_ok, #nickName_ok, #email_ok {
		color: #008000;
		display: none;
	}
	
	#id_not_ok2, #id_not_ok3, #pw_not_ok2, #pw_not_ok3, #nickName_not_ok2,
		#nickName_not_ok3, #email_not_ok2, #email_not_ok3, #email_not_ok4 {
		color: #6A82FB;
		display: none;
	}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<main>
	<!-- 헤더 부분 피하기 위한 div -->
		<div id="forHeader"></div>

		<!-- 본문 내용 가운데 정렬 위한 div -->
		<div id="forCenter">

			<!-- 사이드바 -->
			<div id="hrefList">
				<div id="hrefName">${sessionScope.member.memberName }님</div>
				<span><a href="/perfume/mList">판매상품관리</a></span>
				<span><a href="#">주문내역관리</a></span>
				<span><a href="/admin/member/amList">회원관리</a></span>
				<span><a href="/admin/qna/list">문의관리</a></span>
				<span><a href="/admin/review/list">후기관리</a></span>
			</div>
			<!-- 여기부터 내용 입력하시면 됩니다! -->
			<h1>찜 회원 목록</h1>
			<div class="table_continer">
			<table style="text-align: center;">
				<thead>
					<tr id="thead">
						<th style="width: 100px">번 호</th>
						<th style="width: 200px">품 명</th>
						<th style="width: 200px">아이디</th>
						<th style="width: 200px">날 짜</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${wList }" var="perfume" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<td>${perfume.perfumeName }</td>
						<td class="id">
							<a href="/admin/member/search?searchCondition=All&searchValue=${perfume.memberId }">${perfume.memberId }</a>
						</td>
						<td><fmt:formatDate value="${perfume.wishDate }" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="line">
					        <div id="paging">
							<c:if test="${paging.totalCount ne null }">
								<c:if test="${paging.currentPage != 1}">
									<c:if test="${paging.startNavi != 1}">
										<!-- 첫 페이지로 버튼 -->
										<a href="/perfume/wishList?page=1" class="move first">&lt;&lt;</a>
									</c:if>	
									<!-- 이전 페이지로 버튼 -->
									<a href="/perfume/wishList?page=${paging.currentPage-1}" class="move prev">&lt;</a>
								</c:if>
								<c:forEach begin="${paging.startNavi}" end="${paging.endNavi}" var="i">
								
									<c:choose>
										<c:when test="${i == paging.currentPage}">
											<span class="page current">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="/perfume/wishList?page=${i}" class="page">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
				
								<c:if test="${paging.currentPage != paging.lastPage}">
									<!-- 다음 페이지로 버튼 -->
									<a href="/perfume/wishList?page=${paging.currentPage+1}" class="move next">&gt;</a>
									<c:if test="${paging.endNavi != paging.lastPage}">
										<!-- 맨 끝 페이지로 버튼 -->
										<a href="/perfume/wishList?page=${paging.lastPage}" class="move last">&gt;&gt;</a>
									</c:if>
								</c:if>
							</c:if>
						</div>
						</td>
					</tr>
				</tfoot>
			</table>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>