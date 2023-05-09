<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="../../../../resources/adminCss/adReviewCss/list.css">
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon"
	href="../../resources/img/common/favicon.png" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<style>
	
	</style>
</head>
<body>
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
			<div id="subject"></div>
			<div class="continer">
			<h1>REVIEW</h1>
			<div id="search">
				<form action="/admin/review/search">
	         		<select name="searchOder" id="sortby-select">
					    <option name="" value="Date" <c:if test="${search.searchOder == 'Date' }">selected</c:if>>최신순</option>
					    <option name="" value="Popul" <c:if test="${search.searchOder == 'Popul' }">selected</c:if>>조회순</option>
					    <option name="" value="Star" <c:if test="${search.searchOder == 'Star' }">selected</c:if>>별점순</option>
					</select>
					<select name="searchIncense" id="perfume-select">
					    <option name ="" value="All" <c:if test="${search.searchIncense == 'All' }">selected</c:if>>향종류</option>
					    <option name ="" value="Woody" <c:if test="${search.searchIncense == 'Woody' }">selected</c:if>>Woody</option>
					    <option name ="" value="Floral" <c:if test="${search.searchIncense == 'Floral' }">selected</c:if>>Floral</option>
					    <option name ="" value="Fruity" <c:if test="${search.searchIncense == 'Fruity' }">selected</c:if>>Fruity</option>
					    <option name ="" value="Spicy" <c:if test="${search.searchIncense == 'Spicy' }">selected</c:if>>Spicy</option>
					    <option name ="" value="Citrus" <c:if test="${search.searchIncense == 'Citrus' }">selected</c:if>>Citrus</option>
					</select>
					<input type="text" name="searchValue" value="${search.searchValue }" placeholder="상품명 검색">
					<button type="submit" class="small_button">검 색</button>
				</form>
			</div>
			<table>
				<thead>
					<tr>
						<th style="width: 30px;"><input type="checkbox" class="allCheck"></th>
						<th style="width: 100px;">별 점</th>
						<th style="width: 100px;">이미지</th>
						<th style="width: 150px;">상 품</th>
						<th style="width: 100px;">작성자</th>
						<th style="width: 100px">작성일</th>
						<th style="width: 60px;">조회수</th>
						<th style="width: 60px;">신고수</th>
						<th style="width: 60px;">후기상세</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sList }" var="review" varStatus="i">
						<tr>
							<td><input type="checkbox" class="check" value="${review.reviewNo }"></td>
							<td>
								<div class="star-rating">
				                	<span class="fa ${review.rViewscore >= 1 ? 'fa-star' : 'fa-star-o'}" data-rating="1"></span>
									<span class="fa ${review.rViewscore >= 2 ? 'fa-star' : 'fa-star-o'}" data-rating="2"></span>
									<span class="fa ${review.rViewscore >= 3 ? 'fa-star' : 'fa-star-o'}" data-rating="3"></span>
									<span class="fa ${review.rViewscore >= 4 ? 'fa-star' : 'fa-star-o'}" data-rating="4"></span>
									<span class="fa ${review.rViewscore >= 5 ? 'fa-star' : 'fa-star-o'}" data-rating="5"></span>
									<input type="hidden" name="rViewscore" class="rating-value" value="${review.rViewscore }">
								</div>
							</td>
							<td class="onclick">
								<img src="../../../../resources/img/perfumeFileUploads/${review.pFilerename}" alt="">
							</td>
							<td class="onclick tdOver">
								<a href="/perfume/detail/${review.perfumeNo}">
									[${review.perfumeBrand }] ${review.perfumeName }
								</a>
							</td>
<!-- 							<td class="onclick tdOver"> -->
<%-- 								<a href="/review/reviewDetail/${review.reviewNo}"> --%>
<%-- 	            					<c:out value="${fn:substring(review.reviewContents, 0, 19)}${fn:length(review.reviewContents) > 19 ? '...' : ''}" /> --%>
<!--             					</a> -->
<!-- 		            		</td> -->
							<td class="onclick tdOver" style="width: 100px;">
								<a href="/admin/member/search?searchCondition=All&searchValue=${review.memberNickname }">
									${review.memberNickname }
								</a>	
							</td>
							<td><fmt:formatDate value="${review.reviewDate }" pattern="yyyy-MM-dd" /></td>
							<td>${review.rViewcount }</td>
							<td>
								<c:if test="${review.reportCount > 0 }">
									<a href="/admin/review/report?reviewNo=${review.reviewNo }">${review.reportCount }</a>
								</c:if>
								<c:if test="${review.reportCount == 0 }">
									${review.reportCount }
								</c:if>
							</td>
							<td>
								<button class="rDetail_btn" type="button" onclick="location.href='/review/reviewDetail/${review.reviewNo}'">
									상 세
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="7"></td>
						<td colspan="2"><button type="button" class="del">삭제하기</button></td>
					</tr>
			        <tr>
						<td colspan="9" class="line">
					        <div id="paging">
							<c:if test="${paging.totalCount ne null }">
								<c:if test="${paging.currentPage != 1}">
									<c:if test="${paging.startNavi != 1}">
										<!-- 첫 페이지로 버튼 -->
										<a href="/admin/review/search?page=1&searchOder=${search.searchOder}&searchIncense=${search.searchIncense}&searchValue=${search.searchValue}" class="move first">&lt;&lt;</a>
									</c:if>	
									<!-- 이전 페이지로 버튼 -->
									<a href="/admin/review/search?page=${paging.currentPage-1}&searchOder=${search.searchOder}&searchIncense=${search.searchIncense}&searchValue=${search.searchValue}" class="move prev">&lt;</a>
								</c:if>
								
								<c:forEach begin="${paging.startNavi}" end="${paging.endNavi}" var="i">
									<c:choose>
										<c:when test="${i == paging.currentPage}">
											<span class="page current">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="/admin/review/search?page=${i}&searchOder=${search.searchOder}&searchIncense=${search.searchIncense}&searchValue=${search.searchValue}" class="page">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
				
								<c:if test="${paging.currentPage != paging.lastPage}">
									<!-- 다음 페이지로 버튼 -->
									<a href="/admin/review/search?page=${paging.currentPage+1}&searchOder=${search.searchOder}&searchIncense=${search.searchIncense}&searchValue=${search.searchValue}" class="move next">&gt;</a>
									<c:if test="${paging.endNavi != paging.lastPage}">
										<!-- 맨 끝 페이지로 버튼 -->
										<a href="/admin/review/search?page=${paging.lastPage}&searchOder=${search.searchOder}&searchIncense=${search.searchIncense}&searchValue=${search.searchValue}" class="move last">&gt;&gt;</a>
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
		// 전체 선택 박스
		var allCheck = document.querySelector(".allCheck");
		allCheck.onclick = () => {
			if (allCheck.checked) {
				for (var i = 0; i < list.length; i++) {
					list[i].checked = true;
				}
			} else {
				for (var i = 0; i < list.length; i++) {
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
// 		// 전체 선택 박스
// 		var allCheck = document.querySelector(".allCheck");
// 		allCheck.onclick = () => {
// 			if (allCheck.checked) {
// 				for (var i = 0; i < list.length; i++) {
// 					list[i].checked = true;
// 				}
// 			} else {
// 				for (var i = 0; i < list.length; i++) {
// 					list[i].checked = false;
// 				}
// 			}
// 		}
		
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
// 		// 전체 선택 박스
// 		var allCheck = document.querySelector(".allCheck");
// 		var list = document.querySelectorAll(".check");
// 		allCheck.onclick = () => {
// 			if(allCheck.checked) {
// 				for(var i = 0; i < list.length; i++) {
// 					list[i].checked = true;
// 				}
// 			} else {
// 				for(var i = 0; i < list.length; i++) {
// 					list[i].checked = false;
// 				}
// 			}
// 		}
		
		// 선택 삭제 
		document.querySelector(".del").addEventListener('click', function() {
			var del = new Array();
			var list = document.querySelectorAll(".check");
			for(var i = 0; i < list.length; i++) {
				if(list[i].checked) {
					del.push(list[i].value);
				}
			}
			console.log(del);
			if(confirm("정말 삭제 하시겠습니까?")) {
				$.ajax({
					url:'/admin/review/arRemove',
					type : 'post',
					dataType : 'json',
					traditional : 'true',
					data : {'arr':del},
					success : function(data){
						if(data == 1) {
							alert("삭제되었습니다!");
							location.href = "/admin/review/list";
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
















