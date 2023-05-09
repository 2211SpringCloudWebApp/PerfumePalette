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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="../../../../resources/adminCss/adOrderCss/detail.css">
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon"
	href="../../../resources/img/common/favicon.png" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<style>
		
	</style>
</head>
<body>
	<!-- 	모달 이외 모자이크 -->
	<jsp:include page="../../common/header.jsp" />
	<main>
		<!-- 헤더 부분 피하기 위한 div -->
		<div id="forHeader"></div>

		<!-- 본문 내용 가운데 정렬 위한 div -->
		<div id="forCenter">

			<!-- 여기부터 내용 입력하시면 됩니다! -->
			<h1>주문내역 상세</h1>
			<input type="hidden" value="${order.orderNo }">
<!-- 			상품 정보 -->
			<table>
				<caption class="caption_top"><strong>상품 정보</strong></caption>
				<c:forEach items="${orderList }" var="order" varStatus="i">
				<tr>
					<th class="perfume_info">브랜드</th>
					<td class="perfume_detailB">${order.perfumeBrand}</td>
					<th class="perfume_info">상품명</th>
					<td class="perfume_detail">
						<a href="/perfume/detail/${order.perfumeNo }">
							${order.perfumeName }
						</a>	
					</td>
					<th class="perfume_info">주문 수량</th>
					<td class="orderQuantity">${order.orderQuantity }</td>
				</tr>
				</c:forEach>
				<tr>
					<th>결제 금액</th>
					<td colspan="5"><fmt:formatNumber value="${orderList[0].paymentAmount }" pattern="#,##0"/>원</td>
					
				</tr>
			</table>
			
<!-- 			결제 정보 -->
			<table>
				<caption class="caption_top"><strong>결제 정보</strong></caption>
				<tr>
					<th class="perfume_info">주문번호</th>
					<td class="perfume_detail">${orderList[0].orderNo }</td>
					<th class="perfume_info">주문일자</th>
					<td class="perfume_detail">
						<fmt:formatDate value="${orderList[0].orderDate }" pattern="yyyy-MM-dd" />
					</td>
				</tr>
				<tr>
					<th class="perfume_info">주문자</th>
					<td class="perfume_detail">
						<a href="/admin/member/search?searchCondition=All&searchValue=${orderList[0].memberName }">
							${orderList[0].memberName }
						</a>	
					</td>
					<th class="perfume_info">주문자번호</th>
					<td class="perfume_detail">${orderList[0].memberPhone.substring(0,3) }-${orderList[0].memberPhone.substring(3,7) }-${orderList[0].memberPhone.substring(7,11) }</td>
				</tr>
				<tr>
					<th class="perfume_info">결제수단</th>
					<td class="perfume_detail">${orderList[0].paymentMethod }</td>					
					<th class="perfume_info">은행명</th>
					<td class="perfume_detail">${orderList[0].vBankName }</td>					
				</tr>
				<tr>
					<th class="perfume_info">입금계좌</th>
					<td class="perfume_detail">${orderList[0].vBankNo }</td>					
					<th class="perfume_info">결제 상태</th>
					<td class="perfume_detail">${orderList[0].paymentStatus }</td>					
				</tr>
				<tr>
					<th class="perfume_info"></th>
					<td class="perfume_detail"></td>					
					<th class="perfume_info">주문 상태</th>
					<td class="perfume_detail">
						<form id="updateOrderForm" action="/admin/order/update" method="post">
							<input type="hidden" name="orderNo" value="${orderList[0].orderNo }">
							<select id="orderStatusSelect" name="orderStatus" class="oStatusSelect" onchange="">
								<option id="notPay" value="입금전" ${orderList[0].orderStatus == "입금전" ? 'selected' : ''}>입금전</option>
								<option id="okPay" value="결제완료" ${orderList[0].orderStatus == "결제완료" ? 'selected' : ''}>결제완료</option>
								<option id="redyCar" value="배송준비중" ${orderList[0].orderStatus == "배송준비중" ? 'selected' : ''}>배송준비중</option>
								<option id="ingCar" value="배송중" ${orderList[0].orderStatus == "배송중" ? 'selected' : ''}>배송중</option>
								<option id="okCar" value="배송완료" ${orderList[0].orderStatus == "배송완료" ? 'selected' : ''}>배송완료</option>
								<option id="cancel" value="취소" ${orderList[0].orderStatus == "취소" ? 'selected' : ''}>취소</option>
							</select>
						</form>
<%-- 						${orderList[0].orderStatus } --%>
					</td>					
				</tr>
			</table>
				
<!-- 			주문 정보 -->
			<table>
				<caption class="caption_top"><strong>주문 정보</strong></caption>
				<tr>
					<th class="perfume_info">수령인</th>
					<td class="perfume_detail">${orderList[0].recipientName }</td>
					<th class="perfume_info">전화번호</th>
					<td class="perfume_detail">${orderList[0].recipientPhone.substring(0,3) }-${orderList[0].recipientPhone.substring(3,7) }-${orderList[0].recipientPhone.substring(7,11) }</td>
				</tr>
				<tr>
					<th class="perfume_info">배송주소</th>
					<td colspan="3">${orderList[0].deliveryAddr }</td>
				</tr>
				<tr>
					<th class="perfume_info">배송메모</th>
					<td colspan="3">${orderList[0].deliveryMsg }</td>
				</tr>
			</table>
			<button type="button" onclick="location.href='/admin/order/list'" id="list_btn">목록으로</button>
			<div id="ff"></div>
		</div>
	</main>
	<jsp:include page="../../common/footer.jsp" />
	<script>
// 		$(document).ready(function() {
// 			$('#orderStatusSelect').change(function() {
// 				var form = $('#updateOrderForm');
// 				$.ajax({
// 					type: form.attr('post'),
// 					url: form.attr('/admin/order/update'),
// 					data: form.serialize(),
// 					success: function(data) {
// 						location.reload();
// 					}
// 				});
// 			});
// 		});
		$(document).ready(function() {
			$('#orderStatusSelect').change(function() {
		  		var form = $('#updateOrderForm');
		    	$.ajax({
		      		type: form.attr('method'),
		      		url: form.attr('action'),
		      		data: {
		        		orderStatus: form.find('select[name="orderStatus"]').val(),
		        		orderNo: form.find('input[name="orderNo"]').val()
		      		},
		      		success: function(data) {
		        		location.reload();
		      		}
		    	});
		  	});
		});
	</script>
</body>
</html>
