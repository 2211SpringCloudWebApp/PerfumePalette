<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>

		<link rel="stylesheet" href="../../../resources/perfumeShopCss/list.css">
		<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
		
		<!-- favicon : 탭에 보이는 아이콘 -->
		<link rel="icon" href="../../resources/img/common/favicon.png" />
		<link rel="apple-touch-icon" href="../../resources/img/common/favicon.png" />
		
		<!-- 양방향 슬라이더 사용 위함 -->
		<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

		
	</head>

	<body>
		<jsp:include page="../common/header.jsp" />
		<main>
		<!-- 헤더 부분 피하기 위한 div -->
		<div id="forHeader"></div>
		<!-- 본문 내용 가운데 정렬 위한 div -->
		<div id="forCenter">

			<!-- 여기부터 내용 입력하시면 됩니다! -->
			<div id="main-content">
				
				<form id="filter-area" method="post">

					<!-- 향 -->
					<div id="scent-area">
						<div class="scent-category" onclick="pScentCategoryFunc(this)">All</div>
						<div class="scent-category" onclick="pScentCategoryFunc(this)">Citrus</div>
						<div class="scent-category" onclick="pScentCategoryFunc(this)">Fruity</div>
						<div class="scent-category" onclick="pScentCategoryFunc(this)">Floral</div>
						<div class="scent-category" onclick="pScentCategoryFunc(this)">Spicy</div>
						<div class="scent-category" onclick="pScentCategoryFunc(this)">Woody</div>
					</div>
	
					<!-- 정렬 순서 -->
					<div id="sort-by-area">
						<select onchange="perfumeSortFunc(this)">
							<option value="">정렬</option>
							<option value="new" <c:if test="${filtering.perfumeSort eq 'new'}">selected</c:if>>신상품</option>
							<option value="hot" <c:if test="${filtering.perfumeSort eq 'hot'}">selected</c:if>>인기판매</option>
							<option value="review" <c:if test="${filtering.perfumeSort eq 'review'}">selected</c:if>>후기</option>
							<option value="highPrice" <c:if test="${filtering.perfumeSort eq 'highPrice'}">selected</c:if>>높은가격</option>
							<option value="lowPrice" <c:if test="${filtering.perfumeSort eq 'lowPrice'}">selected</c:if>>낮은가격</option>
						</select>
					</div>
	
					<!-- 가격 -->
					<div id="price-area">
						<div>가격</div>
						<div id="price-slider-area">
							<div id="slider-range"></div>
							<p id="slider-values">
								<span id="min-value">0</span>
								~
								<span id="max-value">∞</span>
							</p>
						</div>
					</div>

					<!-- 이름 검색 -->
					<div id="search-area">
						<div>검색</div>
						<input type="text" oninput="perfumeSearchFunc(this)" value="<c:if test='${filtering.perfumeSearch ne null}'>${filtering.perfumeSearch}</c:if>">
					</div>
						

					<input type="hidden" name="page">

					<input type="hidden" name="pScentCategory" value="${filtering.pScentCategory }">
					<input type="hidden" name="perfumeSort" value="${filtering.perfumeSort }">
					<input type="hidden" name="startPerfumePrice" value="${filtering.startPerfumePrice }">
					<input type="hidden" name="endPerfumePrice" value="${filtering.endPerfumePrice }">
					<input type="hidden" name="perfumeSearch" value="${filtering.perfumeSearch }">

					<input type="hidden" name="perfumeNo1" value="${filtering.perfumeNo1 }">
					<input type="hidden" name="perfumeNo2" value="${filtering.perfumeNo2 }">
					<input type="hidden" name="perfumeNo3" value="${filtering.perfumeNo3 }">
					<input type="hidden" name="compareCnt" value="${filtering.compareCnt }" id="compare-cnt">

				</form>

				<div id="compare-area" onclick="compareModal()">
					<div>비교함</div>
					<div><span>${filtering.compareCnt }</span>개</div>
				</div>

				<div id="compare-modal-bg">
					<div id="compare-modal">
						<div id="compare-modal-close-btn" onclick="compareModal()">×</div>
						<div id="compare-real">
							<div id="compare-real-title">향수 비교하기 <span>비교는 최대 3개까지 가능합니다.</span></div>
							<div id="compare-real-info">
								<table>
									<tr id="compare-img">
										<th>이미지</th> 		<td class="compare-1">안녕</td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-brand">
										<th>브랜드</th> 		<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-name">
										<th>제품명</th> 		<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-scent">
										<th>향</th> 			<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-volume">
										<th>용량</th> 			<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-price">
										<th>가격</th> 			<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-25price">
										<th>25ml당 가격</th> 	<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
									<tr id="compare-detailBtn">
										<th>상세버튼</th>		<td class="compare-1"></td> <td class="compare-2"></td> <td class="compare-3"></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 필터링 및 비교 모달 끝! -->

				<div style="height: 200px; width: 100%; background-color: rgba(0, 0, 255, 0);">
					향수추천공간입니다
					<input type="checkbox">
				</div>

				<div style="height: 100px; width: 100%; background-color: rgba(255, 217, 0, 0);">
					pScentCategory공간입니다
				</div>

				<table id="pList">
					<div>${msg}</div>
					<c:forEach items="${pList }" var="perfume" varStatus="status">
	
						<c:if test="${status.index % 4 == 0}">
							<tr>
						</c:if>
	
						<td>
							<div onclick="location.href='/perfume/detail/${perfume.perfumeNo }'">
								<div>
									<!-- <img class="perfumeImg" src="../../../resources/img/perfumeFileUploads/${perfume.pFilerename }" alt="향수이미지"> -->
									<div class="perfumeImg" style="background-image: url('../../../resources/img/perfumeFileUploads/${perfume.pFilerename }');">
										<div id="addWish">
											<div class="wishImg" id="${perfume.perfumeNo }" onclick="wish(event, this)" title="찜하기" data-status="0"></div>
										</div>
									</div>
									
								</div>
								<div>
									<!-- 품절이라면 품절 표시-->
									<c:if test="${perfume.perfumeQuantity eq 0}">
										품절
									</c:if>
									
									<!-- 잘렸을 경우 ...처리해주기!! -->
									<c:set var="perfumeBrand" value="${fn:substring(perfume.perfumeBrand, 0, 5)}" />
									<div>${perfumeBrand }</div>
	
									<c:set var="perfumeName" value="${fn:substring(perfume.perfumeName, 0, 10)}" />
									<div>${perfumeName}</div>
									<div><fmt:formatNumber value="${perfume.perfumePrice }" pattern="#,##0"/>원</div>
								</div>
							</div>

							<!-- 비교함에 넣을 정보 -->
							<div class="pCompareBtn" onclick="compare(this)">
									<c:choose>
										<c:when test="${perfume.perfumeNo ne filtering.perfumeNo1 && perfume.perfumeNo ne filtering.perfumeNo2 && perfume.perfumeNo ne filtering.perfumeNo3}">
											<span class="compareStatus" data-status="0">비교함추가</span>
										</c:when>
										<c:otherwise>
											<span class="compareStatus" data-status="1">비교함삭제</span>
										</c:otherwise>
									</c:choose>
								<input type="hidden" 	class="comparePerfumeNo" 	value="${perfume.perfumeNo }">
							</div>

							<input style="border: 0;" type="text" class="wishCnt" value="">
						</td>
	
						<c:if test="${status.index % 4 == 3 || status.last}">
							</tr>
						</c:if>
	
					</c:forEach>
				</table>
	
				<div id="paging">
					<c:if test="${paging.totalCount ne null }">
						<c:if test="${paging.currentPage != 1}">
							<c:if test="${paging.startNavi != 1}">
								<!-- 첫 페이지로 버튼 -->
								<a href="javascript:getPerfumeList(1)" class="move first">&lt;&lt;</a>
							</c:if>	
							<!-- 이전 페이지로 버튼 -->
							<a href="javascript:getPerfumeList(${paging.currentPage-1})" class="move prev">&lt;</a>
						</c:if>
						
						<c:forEach begin="${paging.startNavi}" end="${paging.endNavi}" var="i">
							<c:choose>
								<c:when test="${i == paging.currentPage}">
									<span class="page current">${i}</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:getPerfumeList(${i})" class="page">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
		
						<c:if test="${paging.currentPage != paging.lastPage}">
							<!-- 다음 페이지로 버튼 -->
							<a href="javascript:getPerfumeList(${paging.currentPage+1})" class="move next">&gt;</a>
							<c:if test="${paging.endNavi != paging.lastPage}">
								<!-- 맨 끝 페이지로 버튼 -->
								<a href="javascript:getPerfumeList(${paging.lastPage})" class="move last">&gt;&gt;</a>
							</c:if>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		</main>
		
		<script>

			// 비교함 오류 - 디테일 들어갔다가 뒤로가기 하면 고장남

			// perfumeNo를 입력받아 비교모달창 빈칸에 넣는 함수
			addCompareModal = function(perfumeNo, modalIndex) {
				$.ajax({
					url: '/perfume/getPerfume',
					type: 'POST',
					data: {
						'perfumeNo': perfumeNo
					},
					success: function(perfume) {

						$('#compare-img .compare-' + modalIndex).html('<img width="100" height="100" src="../../../resources/img/perfumeFileUploads/' + perfume.pFilerename + '">');
						$('#compare-img .compare-' + modalIndex).html($('#compare-img .compare-' + modalIndex).html() + '<input type="hidden" value="' + perfume.perfumeNo + '">');

						$('#compare-brand .compare-' + modalIndex).html(perfume.perfumeBrand);
						$('#compare-name .compare-' + modalIndex).html(perfume.perfumeName);
						$('#compare-scent .compare-' + modalIndex).html(perfume.pScentCategory);
						$('#compare-volume .compare-' + modalIndex).html(perfume.perfumeVolume);
						$('#compare-price .compare-' + modalIndex).html(perfume.perfumePrice);
						$('#compare-25price .compare-' + modalIndex).html('25ㅇㄴㄻㄹ');
						$('#compare-detailBtn .compare-' + modalIndex).html('상세버튼');

					},
					error: function() {
						console.log("아작스실패!");
					}
				});
				
			}

			// 비교 모달창에서 지우는 함수
			removeCompareModal = function(perfumeNo, modalIndex) {

				$('#compare-img .compare-' + modalIndex).html('');

				$('#compare-brand .compare-' + modalIndex).html('');
				$('#compare-name .compare-' + modalIndex).html('');
				$('#compare-scent .compare-' + modalIndex).html('');
				$('#compare-volume .compare-' + modalIndex).html('');
				$('#compare-price .compare-' + modalIndex).html('');
				$('#compare-25price .compare-' + modalIndex).html('');
				$('#compare-detailBtn .compare-' + modalIndex).html('');

			}
			
			// 페이지가 열리면 (페이징, 필터링 등의 이유도!)
			// perfumeNo1, 2, 3의 값이 각각 있는지 확인 후
			// 있다면 번호에 해당하는! 비교모달칸에 넣어주기
			$(function() {
				$('[name^=perfumeNo]').each(function(index) {
					if($(this).val() != 0) {
						// addCompareModal($(this).val());
						// 수정필요
						addCompareModal($(this).val(), index+1)
					}
				});
			});

			// 비교함 추가 삭제
			compare = function(tag) {
				
				let perfumeNo = $(tag).find('.comparePerfumeNo').val();	

				$(tag).filter(function() {

					let modalIndex = 0;
					if ($(tag).find('.compareStatus').data('status') == 0) {
						
						switch ($('#compare-cnt').val()) {

							default:
								// 추가하는 경우
								// 1. hidden input태그 값 바꿔주기 - cnt는 현재값에서 +1, perfumeNo는 빈자리(0)찾아서 넣어주기
								//  - filtering객체에 담아서 필터링, 페이징 시 비교함 정보 그대로 갖고오기 위함
								//  - 이때 perfumeNo Index을 구해 번호에 맞는 모달칸에 넣어주도록 함
								$('#compare-cnt').val(parseInt($('#compare-cnt').val()) + 1);
								$('[name^=perfumeNo]').each(function(index) {
									if($(this).val() == 0) {
										$(this).val(perfumeNo);
										modalIndex = index + 1;
										return false;
									}
								});

								// 2. 해당 향수 .compareStatus span태그의 data-status값 + innerHTML값 바꿔주기 
								$(tag).find('.compareStatus').data('status', 1);
								$(tag).find('.compareStatus').html('비교함삭제');

								// 3. 비교함 모달창 내 perfumeNo1, 2, 3에 각각 향수 정보 입력해주기
								addCompareModal(perfumeNo, modalIndex)

								// 4. 비교함 N개 버튼 정보 업로드
								$('#compare-area span').html(parseInt($('#compare-cnt').val()));
								break;

							case '3':
								alert("비교함이 꽉 찼습니다!")
								break;
						}
					} else {

						// 삭제하는 경우
						// 1. hidden input태그 값 바꿔주기 - cnt는 현재값에서 -1, perfumeNo는 같은 값 찾아서 지워주기
						//  - 추가할 때와는 다르게 순서대로X
						//  - filtering객체에 담아서 필터링, 페이징 시 비교함 정보 그대로 갖고오기 위함
						$('#compare-cnt').val(parseInt($('#compare-cnt').val()) - 1);
						$('[name^=perfumeNo]').each(function(index) {
							if($(this).val() == perfumeNo) {
								$(this).val(0);
								modalIndex = index + 1;
								return false;
							}
						});

						// 2. 해당 향수 .compareStatus span태그의 data-status값 + innerHTML값 바꿔주기
						$(tag).find('.compareStatus').data('status',0);
						$(tag).find('.compareStatus').html('비교함추가');

						// 3. 비교함 모달창 내 perfumeNo에 해당하는 향수 찾아서 지우기
						removeCompareModal(perfumeNo, modalIndex)

						// 4. 비교함 N개 버튼 정보 업로드
						$('#compare-area span').html(parseInt($('#compare-cnt').val()));
						
					}
				});
			}

			


			// 비교함 버튼 눌렀을 때
			compareModal = function() {

				// 모달창 여닫는 속도
				let modalSpeed = 200;

				if ($('#compare-modal').css('display') === 'none') {
					// 모달창이 닫혀있다면 열기
					$("#compare-modal").fadeIn(modalSpeed);
					$("#compare-modal-bg").fadeIn(modalSpeed);
					$("body").css("overflow", "hidden");

				} else if ($('#compare-modal').css('display') === 'block') {
					// 모달창이 열려있다면 닫기
					$("#compare-modal").fadeOut(modalSpeed);
					$("#compare-modal-bg").fadeOut(modalSpeed);
					// 메인화면에선 어차피 overflow hidden이라 바꾸면 안됨
					if (!pattern.test(curURL.slice(-6))) {
						$("body").css("overflow-y", "visible");
					}

				}
			}

			// pScentCategory 선택된 값 글자 속성 바꾸는 함수
			pScentText = function() {
				$('.scent-category').filter(function() {
					if ($(this).html() === $('[name=pScentCategory]').val()) {
						$(this).css({
							"color": "red"
						});
					} else {
						$(this).css({
							"color": "black"
						});
					}
				});
			}
			// 페이지 로드 되자마자 실행
			pScentText();
			

			// 클릭한 pScentCategory hidden 태그에 넣어주기 + 클릭한 pScentCategory 글자 속성 바꿔주기
			pScentCategoryFunc = function(tag) {
				$('[name=pScentCategory]').val(tag.innerHTML);
				pScentText();
			}
			// 클릭한 perfumeSort hidden 태그에 넣어주기
			perfumeSortFunc = function(tag) {
				$('[name=perfumeSort]').val(tag.value);
			}
			// 입력한 perfumeSearch hidden 태그에 넣어주기
			perfumeSearchFunc = function(tag) {
				$('[name=perfumeSearch]').val(tag.value);
			}
			// 조작한 perfumePrice값 두 개 각각의 hidden 태그에 넣어주기
			$('#slider-range').slider({
				range: true,
				min: 0,
				max: 600000,
				values: [$('[name=startPerfumePrice]').val(),  $('[name=endPerfumePrice]').val()],
				step: 50000,
				slide: function(event, ui) {
					$('[name=startPerfumePrice]').val(ui.values[0]);
					$('[name=endPerfumePrice]').val(ui.values[1]);

					$('#min-value').text(ui.values[0]);
					if (ui.values[1] === 600000) {
						$('#max-value').text('∞');
					} else {
						$('#max-value').text(ui.values[1]);
					}

				}
			});

			// 필터를 조작하면 필터에 맞는 리스트 비동기로 불러옴
			$('.scent-category, select, #slider-range, #search-area>input').on('change click input', function() {
				getPerfumeList(0);
			});
				

			// 필터 + 페이징 결과 불러오는 함수
			getPerfumeList = function(page) {

				let pScentCategory = $('[name=pScentCategory]').val();
				let perfumeSort = $('[name=perfumeSort]').val();
				let startPerfumePrice = $('[name=startPerfumePrice]').val();
				let endPerfumePrice = $('[name=endPerfumePrice]').val();
				let perfumeSearch = $('[name=perfumeSearch]').val();

				if (page != 0) {
					// 페이지가 0이 아니면 = 페이지를 조작하면(새로고침)
					$('[name=page]').val(page);
					$('#filter-area').submit();

				} else {
					// 페이지가 0이면 = 필터를 조작하면(비동기)
					$.ajax({
						url: "/perfume/list",
						type: "POST",
						data: {
							"pScentCategory": pScentCategory,
							"perfumeSort": perfumeSort,
							"startPerfumePrice": startPerfumePrice,
							"endPerfumePrice": endPerfumePrice,
							"perfumeSearch": perfumeSearch
						},
						dataType: "html",
						success: function(data) {

							// 가져온 데이터에서 게시글 목록과 페이징 정보 추출
							var pList = $(data).find("#pList").html();
							var paging = $(data).find("#paging").html();

							// 게시글 목록과 페이징 정보를 업데이트
							$("#pList").html(pList);
							$("#paging").html(paging);

							// 위시 정보 업데이트
							checkWish();
						}
					});
				}
			}

			
			// Wish 하트 클릭
			wish = function(e, tag) {

				e.stopPropagation(); // 하트 클릭할 경우 detail로 이동 방지

				let perfumeNo = $(tag).attr('id');
				let memberId = '${sessionScope.member.memberId }';

				if (memberId == '') {
					alert('로그인부터 하시길!')
				} else {
					if($(tag).data('status') == 0) {
						// 찜을 안 누른 상태라면 찜
						$(tag).data('status', 1);
						$.ajax({
							url:'/wish/add',
							type: 'POST',
							data:{
								"perfumeNo": perfumeNo,
								"memberId": memberId
							},
							success: function(result) {
								checkWish();

							},
							error: function(result) {
							}
						});
					} else {
						// 찜을 누른 상태라면 찜 취소
						// 근데 찜 취소가 wishNo를 이용해서 여기서 처리할 수가 없음
						// 임시로 wishNo 가져오겟슴 일단
						$(tag).data('status', 0);
						$.ajax({
							url: '/perfume/getWishNo',
							type:'POST',
							data: {
								"perfumeNo": perfumeNo,
								"memberId": memberId
							},
							success: function(wishNo) {
								$.ajax({
									url: '/wish/remove',
									type: 'POST',
									data:{
										"wishNo": wishNo,
									},
									success: function(result) {
										checkWish();
									},
									error: function(result) {
									}
								});
							},
							error: function(result) {

							}
						});
					}
					
				}
			}

			// wish  전체 개수 및 자기가 누른 위시 여부 확인하기
			checkWish = function() {
				let memberId = '${sessionScope.member.memberId }';
				$('.wishImg').filter(function() {

					let perfumeNo = $(this).attr('id');
					let wishTag = $(this);
					
					$.ajax({
						url: '/perfume/wishCnt',
						type: 'POST',
						data: {
							"perfumeNo": perfumeNo
						},
						success: function(wishCnt) {
							$(wishTag).closest('td').find('.wishCnt').val('❤️' + parseInt(wishCnt));
						},
						error: function(result) {
							alert(result);
						}
					});

					if (memberId != '') {
						$.ajax({
							url:'/perfume/checkWish',
							type:'POST',
							data: {
								"perfumeNo": perfumeNo,
								"memberId": memberId
							},
							success: function(result) {
								if (result == 'success') {
									$(wishTag).css({
										'transition-duration': '0.3s',
										'background-image': 'url(../../../resources/img/common/wish-1.png)'
									});
									$(wishTag).data('status', 1);
									
								} else {
									$(wishTag).css({
										'transition-duration': '0.3s',
										'background-image': 'url(../../../resources/img/common/wish-0.png)' 
									});
									$(wishTag).data('status', 0);
								}
							},
							error: function(result) {
								alert(result);
							}
						});
					} 
					
				});
			}
			checkWish();

			

		</script>

		<jsp:include page="../common/footer.jsp" />

	</body>

	</html>