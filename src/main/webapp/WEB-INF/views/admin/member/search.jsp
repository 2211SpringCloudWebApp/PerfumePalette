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

/* 			모달 css */
.modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal.show {
	display: block;
}

.modal_body {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 500px;
	height: 600px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}
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
					<button type="submit">검 색</button>
				</form>
			</div>
			<table>
				<thead>
					<tr>
						<th><input type="checkbox" class="allCheck"></th>
						<th>번 호</th>
						<th>이 름</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>닉네임</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>등록일</th>
						<th>수 정</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sList }" var="member" varStatus="i">
						<tr>
							<td class="td"><input type="checkbox" class="check"
								value="${member.memberNo }"></td>
							<td class="td">${i.count }</td>
							<td class="td">${member.memberName }</td>
							<td class="td">${member.memberId }</td>
							<td class="td">${member.memberPw }</td>
							<td class="td">${member.memberNickname }</td>
							<td class="td">${member.memberEmail }</td>
							<td class="td">${member.memberPhone }</td>
							<td class="td">${member.memberAddr }</td>
							<td class="td"><fmt:formatDate value="${member.memberDate }" pattern="yyyy-MM-dd" /></td>
							<td class="td"><button class="modal_btn"
									data-target="#modal${i.index }">상세</button></td>
						</tr>
						<!-- 		여기서부터 모달 -->
						<form action="/admin/member/amList" method="post">
							<input type="hidden" class="" name="memberNo"
								value="${member.memberNo }" />
							<div class="modal" id="modal${i.index }">
								<div class="modal_body">
									<h1>${member.memberNickname }님의 상세정보입니다.</h1>
									<div class="Detail_box">
										<div>
											<label>아이디</label> <input type="text" class=""
												name="memberId" value="${member.memberId }" />
										</div>
										<div>
											<label>비밀번호</label> <input type="password" class=""
												name="memberPw" value="${member.memberPw }">
										</div>
										<div>
											<label>이름</label> <input type="text" class=""
												name="memberName" value="${member.memberName }" />
										</div>
										<div>
											<label>닉네임</label> <input type="text" class=""
												name="memberNickname" value="${member.memberNickname }" />
										</div>
										<div>
											<label>이메일</label> <input type="text" class=""
												name="memberEmail" value="${member.memberEmail }" />
										</div>
										<div>
											<label>전화번호</label> <input type="text" class=""
												name="memberPhone" value="${member.memberPhone }" />
										</div>
										<div>
											<label>주소</label> <input type="text" class=""
												name="memberAddr" value="${member.memberAddr }" readonly />
										</div>
									</div>
									<div>
										<button class="modal_modify">수정하기</button>
										<button type="button" class="modal_close">닫기</button>
									</div>
								</div>
								<br>
							</div>
						</form>
						<!--    	 	모달 끝~ -->
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="11"></td>
						<td><button type="button" class="del">선택 삭제</button></td>
					</tr>
					<tr>
						<td colspan="11" class="line">
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