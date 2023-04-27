<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="../../../../resources/adminCss/adMemberCss/amList.css">
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon" href="../../../resources/img/common/favicon.png" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
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
<!-- 	모달 이외 모자이크 -->
	<div id="modal-bg"></div>
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
				<span><a href="#">주문내역관리</a></span>
				<span><a href="/admin/member/amList">회원관리</a></span>
				<span><a href="/admin/qna/list">문의관리</a></span>
				<span><a href="/admin/review/list">후기관리</a></span>
			</div>

			<!-- 여기부터 내용 입력하시면 됩니다! -->
			<h1>회원 관리</h1>
			<div>
				<form action="/admin/member/search" method="get">
					<select name="searchCondition">
						<option value="All" <c:if test="${search.searchCondition == 'All' }">selected</c:if>>전체</option>
						<option value="Name" <c:if test="${search.searchCondition == 'Name' }">selected</c:if>>이름</option>
						<option value="ID" <c:if test="${search.searchCondition == 'ID' }">selected</c:if>>아이디</option>
						<option value="Nickname" <c:if test="${search.searchCondition == 'Nickname' }">selected</c:if>>닉네임</option>
					</select>
					<input type="text" name="searchValue" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="modal_btn">검 색</button>
				</form>
			</div>
			<table>
				<thead>
					<tr class="headList">
						<th style="width: 40px;"><input type="checkbox" class="allCheck"></th>
						<th style="width: 60px;">이 름</th>
						<th style="width: 100px;">아이디</th>
						<th style="width: 120px;">닉네임</th>
						<th style="width: 150px;">이메일</th>
						<th style="width: 110px;">전화번호</th>
						<th style="width: 200px;">주 소</th>
						<th style="width: 100px;">등록일</th>
						<th style="width: 100px;">탈퇴여부</th>
						<th style="width: 120px;">수 정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sList }" var="member" varStatus="i">
						<tr class="amList">
							<td class="td"><input type="checkbox" class="check"
								value="${member.memberNo }"></td>
							<td class="td">${member.memberName }</td>
							<td class="td">${member.memberId }</td>
							<td class="td">${member.memberNickname }</td>
							<td class="td">${member.memberEmail }</td>
							<td class="td">${member.memberPhone.substring(0,3)}-${member.memberPhone.substring(3,7)}-${member.memberPhone.substring(7,11)}</td>
							<td class="td tdAddr">${member.memberAddr }</td>
							<td class="td"><fmt:formatDate value="${member.memberDate }" pattern="yyyy-MM-dd" /></td>
							<td class="td">
								<c:choose>
									<c:when test="${member.memberStatus eq 1}">X</c:when>
									<c:when test="${member.memberStatus eq 0}">O</c:when>
								</c:choose>
							</td>
							<td class="td"><button class="modal_btn"
									data-target="#modal${i.index }">수 정</button></td>
						</tr>
						<!-- 		여기서부터 모달 -->
						<form action="/admin/member/amList" method="post" class="row g-3">
							<input type="hidden" class="" name="memberNo"
								value="${member.memberNo }" />
							<div class="modal" id="modal${i.index }">
								<div class="modal_body">
									<h1 class="modal_h1">${member.memberNickname }님의 상세정보입니다.</h1>
									<div class="Detail_box">
										<div class="mb-3">
											<label class="form-label">아이디</label> <input type="text" class=""
												name="memberId" class="form-control" value="${member.memberId }" />
										</div>
										<div class="mb-3">
											<label class="form-label">비밀번호</label> <input type="password" class=""
												name="memberPw" class="form-control" value="${member.memberPw }">
										</div>
										<div class="mb-3">
											<label class="form-label">이름</label> <input type="text" class=""
												name="memberName" class="form-control" value="${member.memberName }" />
										</div>
										<div class="mb-3">
											<label class="form-label">닉네임</label> <input type="text" class=""
												name="memberNickname" class="form-control" value="${member.memberNickname }" />
										</div>
										<div class="mb-3">
											<label class="form-label">이메일</label> <input type="text" class=""
												name="memberEmail" class="form-control" value="${member.memberEmail }" />
										</div>
										<div class="mb-3">
											<label class="form-label">전화번호</label> <input type="text" class=""
												name="memberPhone" class="form-control" class="form-control" value="${member.memberPhone }" />
										</div>
										<div class="mb-3">
											<label class="form-label">주소</label> <input type="text" class=""
												name="memberAddr" class="form-control" value="${member.memberAddr }" readonly />
										</div>
									</div>
									<div>
										<button class="modal_modify modal_botton">수 정</button>
										<button type="button" class="modal_close modal_botton">닫 기</button>
									</div>
								</div>
								<br>
							</div>
						</form>
						<!--    	 	모달 끝~ -->
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
										<a href="/admin/member/search?page=1&searchCondition=${search.searchCondition }&searchValue=${search.searchValue}" class="move first">&lt;&lt;</a>
									</c:if>	
									<!-- 이전 페이지로 버튼 -->
									<a href="/admin/member/search?page=${paging.currentPage-1}&searchCondition=${search.searchCondition }&searchValue=${search.searchValue}" class="move prev">&lt;</a>
								</c:if>
								
								<c:forEach begin="${paging.startNavi}" end="${paging.endNavi}" var="i">
									<c:choose>
										<c:when test="${i == paging.currentPage}">
											<span class="page current">${i}</span>
										</c:when>
										<c:otherwise>
											<a href="/admin/member/search?page=${i}&searchCondition=${search.searchCondition }&searchValue=${search.searchValue}" class="page">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
				
								<c:if test="${paging.currentPage != paging.lastPage}">
									<!-- 다음 페이지로 버튼 -->
									<a href="/admin/member/search?page=${paging.currentPage+1}&searchCondition=${search.searchCondition }&searchValue=${search.searchValue}" class="move next">&gt;</a>
									<c:if test="${paging.endNavi != paging.lastPage}">
										<!-- 맨 끝 페이지로 버튼 -->
										<a href="/admin/member/search?page=${paging.lastPage}&searchCondition=${search.searchCondition }&searchValue=${search.searchValue}" class="move last">&gt;&gt;</a>
									</c:if>
								</c:if>
							</c:if>
						</div>
						</td>
					</tr>
					<tr>
						<td colspan="7"></td>
						<td><button type="button" class="foot_btn start">선택 활성</button></td>
						<td><button type="button" class="foot_btn stop">선택 정지</button></td>
						<td><button type="button" class="foot_btn del">선택 삭제</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</main>
	<jsp:include page="../../common/footer.jsp" />
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
					url:'/admin/member/amRemove',
					type : 'post',
					dataType : 'json',
					traditional : 'true',
					data : {'arr':del},
					success : function(data){
						if(data == 1) {
							alert("삭제되었습니다!");
							location.href = "/admin/member/amList";
						}
					},
					error : function(data) {
						console.log(data)
					}
				});
			}
		});
		
		// 선택 계정 활성
		document.querySelector(".start").addEventListener('click', function() {
				var start = new Array();
				var list = document.querySelectorAll(".check");
				for(var i = 0; i < list.length; i++) {
					if(list[i].checked) {
						start.push(list[i].value);
					}
				}
				console.log(start);
				if(confirm("정말 변경 하시겠습니까?")) {
					$.ajax({
						url:'/admin/member/start',
						type : 'post',
						dataType : 'json',
						traditional : 'true',
						data : {'arr':start},
						success : function(data) {
							if(data == 1) {
								alert("계정이 활성화 되었습니다.");
								location.href = "/admin/member/amList";
							}
						},
						error : function(data) {
							console.log(data)
						}
					});
				}
			});
		// 선택 계정 정지
		document.querySelector(".stop").addEventListener('click', function() {
				var stop = new Array();
				var list = document.querySelectorAll(".check");
				for(var i = 0; i < list.length; i++) {
					if(list[i].checked) {
						stop.push(list[i].value);
					}
				}
				console.log(stop);
				if(confirm("정말 변경 하시겠습니까?")) {
					$.ajax({
						url:'/admin/member/stop',
						type : 'post',
						dataType : 'json',
						traditional : 'true',
						data : {'arr':stop},
						success : function(data) {
							if(data == 1) {
								alert("계정이 정지되었습니다.");
								location.href = "/admin/member/amList";
							}
						},
						error : function(data) {
							console.log(data)
						}
					});
				}
			});
		
		
		
		// 여기부터 모달!!!!!!!!!!!!!!!!!!!!!!!!!!
		
		// modal, modal_btn, modal_close의 요소를 가져옴
		const modals = document.querySelectorAll('.modal');
    	const btnOpenPopup = document.querySelectorAll('.modal_btn');
    	const btnClosePopup = document.querySelectorAll('.modal_close');
		
    	// 각각의 btnOpenPopup요소에 대해 반복문 수행
    	btnOpenPopup.forEach((btn, i) => {
    		// 클릭시 이벤트 리스너 등록
    		btn.addEventListener('click', () => {
    			// data-target 속성의 값을 가져옴
    			const target = btn.dataset.target;
    			// 해당 요소를 보옂기 위해 디스플레이 속성값 블럭으로 변경
    			document.querySelector(target).style.display = 'block';
    		});
    	});
    	// 각각의 btnClosePopup요소에 대해 반복문 수행
		btnClosePopup.forEach((btn) => {
			btn.addEventListener('click', () => {
// 가장 가까운 modal 요소를 찾아서 display 속성 값을 none으로 변경하여 모달 닫기
				const modal = btn.closest('.modal');
				modal.style.display = 'none';
			});
		});
		</script>
</body>
</html>