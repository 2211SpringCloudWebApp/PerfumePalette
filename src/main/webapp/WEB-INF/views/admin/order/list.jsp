<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="../../../../resources/adminCss/adOrderCss/list.css">
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon" href="../../../resources/img/common/favicon.png" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<!-- 	모달 이외 모자이크 -->
	<jsp:include page="../../common/header.jsp" />
	<main>
		<!-- 헤더 부분 피하기 위한 div -->
		<div id="forHeader"></div>

		<!-- 본문 내용 가운데 정렬 위한 div -->
		<div id="forCenter">

			<!-- 사이드바 -->
			<div id="hrefList">
				<div id="hrefName">${sessionScope.member.memberName }님</div>
				<span><a href="/perfume/mList">판매상품관리</a></span>
				<span><a href="/admin/order/list">주문내역관리</a></span>
				<span><a href="/admin/member/amList">회원관리</a></span>
				<span><a href="/admin/qna/list">문의관리</a></span>
				<span><a href="/admin/review/list">후기관리</a></span>
			</div>

			<!-- 여기부터 내용 입력하시면 됩니다! -->
			<div class="continer">
			<h1>주문내역 관리</h1>
			
			<table>
				<thead>
					<tr>
						<th colspan="1" style="width: 120px;">주문번호</th>
						<th style="width: 100px;">주문 일자</th>
						<th style="width: 110px;">구매자명</th>
						<th style="width: 110px;">수취인</th>
						
						<th rowspan="2" style="width: 120px;">브랜드명</th>
						<th rowspan="2" style="width: 150px;">주문 상품</th>
						<th rowspan="2" style="width: 100px;">상품 가격</th>
						<th rowspan="2" style="width: 100px;">주문 수량</th>
						<th rowspan="2" style="width: 100px;">총 결제금액</th>
<!-- 						<th rowspan="2">주문 취소</th> -->
						
						<th rowspan="2" style="width: 50px;">상세</th>
					</tr>
					<tr>
						<th>주문상태</th>
						<th>결제상태</th>
						<th>구매자 번호</th>
						<th>수취인 번호</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${oList }" var="order" varStatus="i">
						<tr class="orderTrTag" style="background-color: ${i.index % 2 == 0 ? '#fff' : '#ccc'};">
							<td class="tdOver orderNo${i.index}">${order.orderNo}</td>
							<td class="tdOver orderDate${i.index }"><fmt:formatDate value="${order.orderDate }" pattern="yyyy-MM-dd" /></td>
							<td class="tdOver memberName${i.index }">
								<a href="/admin/member/search?searchCondition=All&searchValue=${order.memberName }">
									${order.memberName }
								</a>	
							</td>
							<td class="tdOver recipientName${i.index }">${order.recipientName }</td>
							<td class="tdOver" id="perfumeBrand${i.index}" rowspan="2">
							        ${order.perfumeBrand}
							</td>
							<td class="tdOver" id="perfumeName${i.index}" rowspan="2">
								<a href="/perfume/detail/${order.perfumeNo }">
									${order.perfumeName }
								</a>
							</td>
							<td class="tdOver" id="perfumePrice${i.index}" rowspan="2"><fmt:formatNumber value="${order.perfumePrice}" pattern="#,##0"/></td>
							<td class="tdOver" id="orderQuantity${i.index}" rowspan="2">${order.orderQuantity }</td>
							<td rowspan="2" class="tdOver" id="paymentAmount${i.index }"><fmt:formatNumber value="${order.paymentAmount}" pattern="#,##0"/></td>
<!-- 							주문 취소 자리 -->
							<td class="tdOver" id="showOrder${i.index}" rowspan="2"><button type="button" onclick="location.href='/admin/order/detail?orderNo=${order.orderNo}'">보 기</button></td>
						</tr>
						<tr class="orderTrTag" style="background-color: ${i.index % 2 == 0 ? '#fff' : '#ccc'};">
							<td class="tdOver orderNo${i.index }">${order.orderStatus}</td>
							<td class="tdOver orderDate${i.index }">${order.paymentStatus }</td>
							<td class="tdOver memberName${i.index }">${order.memberPhone.substring(0,3)}-${order.memberPhone.substring(3,7)}-${order.memberPhone.substring(7,11)}</td>
							<td class="tdOver recipientName${i.index }">${order.recipientPhone.substring(0,3)}-${order.recipientPhone.substring(3,7)}-${order.recipientPhone.substring(7,11)}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr class="paging">
						<td colspan="10" class="line">
					        <div id="paging">
							<c:if test="${paging.totalCount ne null }">
								<c:if test="${paging.currentPage != 1}">
									<c:if test="${paging.startNavi != 1}">
										<!-- 첫 페이지로 버튼 -->
										<a href="/admin/order/list?page=1" class="move first">&lt;&lt;</a>
									</c:if>	
									<!-- 이전 페이지로 버튼 -->
									<a href="/admin/order/list?page=${paging.currentPage-1}" class="move prev">&lt;</a>
								</c:if>
								
								<c:forEach begin="${paging.startNavi}" end="${paging.endNavi}" var="i">
									<c:choose>
										<c:when test="${i == paging.currentPage}">
											<span class="page current">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="/admin/order/list?page=${i}" class="page">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
				
								<c:if test="${paging.currentPage != paging.lastPage}">
									<!-- 다음 페이지로 버튼 -->
									<a href="/admin/order/list?page=${paging.currentPage+1}" class="move next">&gt;</a>
									<c:if test="${paging.endNavi != paging.lastPage}">
										<!-- 맨 끝 페이지로 버튼 -->
										<a href="/admin/order/list?page=${paging.lastPage}" class="move last">&gt;&gt;</a>
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
	<jsp:include page="../../common/footer.jsp" />
	<script>
	
    

	</script>
</body>
</html>