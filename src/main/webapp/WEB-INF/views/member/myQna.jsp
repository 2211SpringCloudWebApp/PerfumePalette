<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성 문의</title>
<link rel="stylesheet" href="../../../resources/memberCss/myQna.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<!-- favicon : 탭에 보이는 아이콘 -->
    <link rel="icon" href="../../resources/img/common/favicon.png" />
    <link rel="apple-touch-icon" href="../../resources/img/common/favicon.png"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>    
<style>

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
          <div id="hrefName">${member.memberName }님</div>
          <span><a href="/member/myPage">마이페이지</a></span>
          <span><a href="/member/orderList">주문내역조회</a></span>
          <span><a href="/member/myReview">작성후기</a></span>
          <span><a href="/member/myQna">작성문의</a></span>
          <span><a href="/member/myComment">작성댓글</a></span>
          <span><a href="/member/bye">회원탈퇴</a></span>
        </div>

        <!-- 여기부터 내용 입력하시면 됩니다! -->

<div class="content">
        <h1>내가 작성한 문의</h1>
        <table>
            <thead>
                <tr>
                    <th style="width:100px;">
                    	<input type="checkbox" class="allCheck" id="thCheck">
                    </th>
                    <th>번호</th>
                    <th>분류</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>답변 상태</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${myQna }" var="qna" varStatus="i">
            	<tr>
            		<td><input type="checkbox" class="check" id="tdCheck" value="${qna.qnaNo}"></td>
            		<td>${i.count }</td>
            		<td>
            			<c:if test="${qna.qnaType == 1 }">상품문의</c:if>
	                    <c:if test="${qna.qnaType == 2 }">배송문의</c:if>
	                    <c:if test="${qna.qnaType == 3 }">교환/환불</c:if>
	                    <c:if test="${qna.qnaType == 4 }">기타문의</c:if>
	                </td>
            		<td>
            			<a href="/qnaBoard/detail/${qna.qnaNo }">${qna.qnaSubject }</a>
            		</td>
            		<td><fmt:formatDate value="${qna.qnaDate }" pattern="yyyy-MM-dd" /></td>
            		<td>
            			<c:if test="${qna.qQnaNo eq null}">대기</c:if>
	                    <c:if test="${qna.qQnaNo ne null}">완료</c:if>
	                 </td>
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
	
	// 삭제 버튼 클릭 시
	document.querySelector("#del").addEventListener('click', function() {

	    // 선택된 체크박스들의 value 값을 저장할 배열 선언
	    var del = new Array();

	    // .check 클래스를 가진 요소들을 모두 선택하여 배열에 담음
	    var list = document.querySelectorAll(".check");
	    for (var i = 0; i < list.length; i++) {
	        if (list[i].checked) {
	            del.push(list[i].value);
	        }
	    }

	    // del 배열이 비어있는 경우, 경고창을 띄우고 함수 종료
	    if (del.length === 0) {
	        alert("삭제할 항목을 선택해 주세요.");
	        return;
	    }

	    // "선택한 문의를 삭제 하시겠습니까?" 라는 메시지와 함께 확인/취소 버튼이 있는 경고창 띄우기
	    if (confirm("선택한 문의를 삭제 하시겠습니까?")) {
	        // Ajax를 이용하여 서버에 선택한 체크박스의 value 값을 전송하여 삭제
	        $.ajax({
	            url: '/member/removeQna',
	            type: 'post',
	            dataType: 'json',
	            traditional: 'true',
	            data: { 'arr': del },
	            success: function (data) {
	                // 삭제가 성공적으로 이루어졌을 경우, "삭제되었습니다." 라는 경고창 띄우기
	                if (data == 1) {
	                    alert("삭제되었습니다.");
	                    // 삭제가 완료되면 마이페이지의 작성문의 페이지로 이동
	                    location.href = "/member/myQna";
	                }
	            },
	            error: function (data) {
	                console.log(data)
	            }
	        });
	    }
	});


	
	
    </script>
    
</body>
</html>