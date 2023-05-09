<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성 댓글</title>
<link rel="stylesheet" href="../../../resources/memberCss/myComment.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!-- favicon : 탭에 보이는 아이콘 -->
    <link rel="icon" href="../../resources/img/common/favicon.png" />
    <link
      rel="apple-touch-icon"
      href="../../resources/img/common/favicon.png"
    />
    <style>
    .productName{
    	color:gray;
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
        <h1>내가 작성한 댓글</h1>
        <table>
            <thead>
                <tr>
                    <th style="width:60px;">
                    	<input type="checkbox" class="allCheck" id="thCheck" >
                    </th>
                    <th style="width:30px;">번호</th>
                    <th style="width:135px;" >내용</th>
                    <th style="width:180px;"></th>
                    <th style="width:110px;">작성일</th>
                </tr>
            </thead>
            <tbody>
           <c:forEach items="${myComment }" var="comment" varStatus="i">
            <tr>
              <td>
              	<input type="checkbox" class="check" id="tdCheck" value="${comment.commentNo}">
              </td>
              <td>${i.count }</td>
              <td>
              	<a href="/review/reviewDetail/${comment.reviewNo}">
              	<c:out value="${fn:substring(comment.commentContent, 0, 15)}${fn:length(comment.commentContent) > 15 ? '...' : ''}" />
              	</a>
              </td>
              <td>
              	<a href="/perfume/detail/${comment.perfumeNo}" >
              		<span class="productName">[${comment.perfumeBrand }] ${comment.perfumeName }</span>
              	</a>
              </td>
              <td><fmt:formatDate value="${comment.commentDate }" pattern="yyyy-MM-dd" /></td>
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
		
		// "선택한 댓글을 삭제 하시겠습니까?" 라는 메시지와 함께 확인/취소 버튼이 있는 경고창 띄우기
		if(confirm("선택한 댓글을 삭제 하시겠습니까?")) {
			// Ajax를 이용하여 서버에 선택한 체크박스의 value 값을 전송하여 삭제
			$.ajax({
				url:'/member/removeComment',
				type : 'post',
				dataType : 'json',
				traditional : 'true',
				data : {'arr':del},
				success : function(data){
					// 삭제가 성공적으로 이루어졌을 경우, "삭제되었습니다." 라는 경고창 띄우기
					if(data == 1) {
						alert("삭제되었습니다.");
						// 삭제 완료되면 내 작성댓글 페이지 그대로 유지
						location.href = "/member/myComment";
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