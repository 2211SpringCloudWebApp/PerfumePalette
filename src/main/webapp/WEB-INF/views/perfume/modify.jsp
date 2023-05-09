<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon" href="../../../resources/img/common/favicon.png" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../../../resources/perfumeCss/write.css">
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
				<span><a href="/admin/order/list">주문내역관리</a></span>
				<span><a href="/admin/member/amList">회원관리</a></span>
				<span><a href="/admin/qna/list">문의관리</a></span>
				<span><a href="/admin/review/list">후기관리</a></span>
			</div>

			<!-- 여기부터 내용 입력하시면 됩니다! -->
			<h1>상품 수정</h1>
			<div class="conteiner">
				<form action="/perfume/modify" method="post"
					enctype="multipart/form-data">
					<div class="inputArea">
						<input type="hidden" name="perfumeNo" value="${perfume.perfumeNo }">
						<input type="hidden" name="pFilename" value="${perfume.pFilename }">
						<input type="hidden" name="pFilerename"	value="${perfume.pFilerename }"> 
						<input type="hidden" name="pFilepath" value="${perfume.pFilepath }">
						<div class="top_left">
<!-- 							<h3>수정 전 이미지</h3> -->
							<h3>이미지</h3>
							<div id="img-bfViewer">
								<img class="bfImg" id="img-view" alt="이미지" src="../../../resources/img/perfumeFileUploads/${perfume.pFilerename }">
							</div>
<!-- 							<div id="img-viewer"> -->
<!-- 								<img id="img-view" width="300px"> -->
<!-- 							</div> -->
							<div class="div" style="text-align: center;">
								<input class="file_btn" type="file" name="reloadFile" onchange="loadImg(this);">
							</div>
						</div>
						<div class="top_right">
			
							<div class="div" id="name">
								<label>상품명</label> <input type="text" class="" name="perfumeName"
									value="${perfume.perfumeName }" />
							</div>
							<div class="div" id="brand">
								<label>브랜드명</label> <input type="text" class="" name="perfumeBrand"
									value="${perfume.perfumeBrand }" />
							</div>
							<div class="div" id="vol">
								<label>향수 용량 </label>
								<%--                             <input type="number" name="perfumeVolume" value="${perfume.perfumeVolume }"> --%>
								<select class="category2" name="perfumeVolume">
									<option value=30
										<c:if test="${perfume.perfumeVolume eq 30}">selected</c:if>>30</option>
									<option value=50
										<c:if test="${perfume.perfumeVolume eq 50}">selected</c:if>>50</option>
									<option value=75
										<c:if test="${perfume.perfumeVolume eq 75}">selected</c:if>>75</option>
									<option value=100
										<c:if test="${perfume.perfumeVolume eq 100}">selected</c:if>>100</option>
								</select>
							</div>
							<div class="div" id="price">
								<label>상품가격</label> <input type="number" class="price_num"
									name="perfumePrice" value="${perfume.perfumePrice }" />
							</div>
							<div class="div" id="EA">
								<label>상품수량</label> <input type="number" name="perfumeQuantity"
									value="${perfume.perfumeQuantity }" min="0" max="999">
							</div>
							<div class="div" id="pfSel">
								<label>향수 종류</label> <select class="category1"
									name="pScentCategory">
									<option value="Woody"
										<c:if test="${perfume.pScentCategory eq 'Woody'}">selected</c:if>>Woody</option>
									<option value="Floral"
										<c:if test="${perfume.pScentCategory eq 'Floral'}">selected</c:if>>Floral</option>
									<option value="Fruity"
										<c:if test="${perfume.pScentCategory eq 'Fruity'}">selected</c:if>>Fruity</option>
									<option value="Spicy"
										<c:if test="${perfume.pScentCategory eq 'Spicy'}">selected</c:if>>Spicy</option>
									<option value="Citrus"
										<c:if test="${perfume.pScentCategory eq 'Citrus'}">selected</c:if>>Citrus</option>
								</select>
							</div>
							<div class="div" id="img_category">
								<label>이미지 분류</label>
								<!--                             <input type="text" class="" name="pImageCategory" > -->
								<select id="mySelect" onchange="showCheckboxes()">
									<option value="Woody"
										<c:if test="${perfume.pScentCategory eq 'Woody'}">selected</c:if>>Woody</option>
									<option value="Floral"
										<c:if test="${perfume.pScentCategory eq 'Floral'}">selected</c:if>>Floral</option>
									<option value="Fruity"
										<c:if test="${perfume.pScentCategory eq 'Fruity'}">selected</c:if>>Fruity</option>
									<option value="Spicy"
										<c:if test="${perfume.pScentCategory eq 'Spicy'}">selected</c:if>>Spicy</option>
									<option value="Citrus"
										<c:if test="${perfume.pScentCategory eq 'Citrus'}">selected</c:if>>Citrus</option>
								</select>
								<div id="checkboxes">
									<div id="Woody">
										<!-- 		                            <input type="checkBox" name="pImageCategory" value="매혹적인">매혹적인 -->
										<input type="checkBox" name="pImageCategory" value="매혹적인"
											<c:if test="${perfume.pImageCategory eq '매혹적인'}">checked</c:if>>매혹적인
										<input type="checkBox" name="pImageCategory" value="매력적인"
											<c:if test="${perfume.pImageCategory eq '매력적인'}">checked</c:if>>매력적인
										<input type="checkBox" name="pImageCategory" value="미스테리"
											<c:if test="${perfume.pImageCategory eq '미스테리'}">checked</c:if>>미스테리
										<input type="checkBox" name="pImageCategory" value="성숙함"
											<c:if test="${perfume.pImageCategory eq '성숙함'}">checked</c:if>>성숙함
									</div>
									<div id="Floral">
										<input type="checkBox" name="pImageCategory" value="우아한"
											<c:if test="${perfume.pImageCategory eq '우아한'}">checked</c:if>>우아한
										<input type="checkBox" name="pImageCategory" value="연약한"
											<c:if test="${perfume.pImageCategory eq '연약한'}">checked</c:if>>연약한
										<input type="checkBox" name="pImageCategory" value="여성스러운"
											<c:if test="${perfume.pImageCategory eq '여성스러운'}">checked</c:if>>여성스러운
										<input type="checkBox" name="pImageCategory" value="부드러운"
											<c:if test="${perfume.pImageCategory eq '부드러운'}">checked</c:if>>부드러운
										<input type="checkBox" name="pImageCategory" value="사랑스러운"
											<c:if test="${perfume.pImageCategory eq '사랑스러운'}">checked</c:if>>사랑스러운
									</div>
									<div id="Fruity">
										<input type="checkBox" name="pImageCategory" value="명랑한"
											<c:if test="${perfume.pImageCategory eq '명랑한'}">checked</c:if>>명랑한
										<input type="checkBox" name="pImageCategory" value="유쾌한"
											<c:if test="${perfume.pImageCategory eq '유쾌한'}">checked</c:if>>유쾌한
										<input type="checkBox" name="pImageCategory" value="현대적인"
											<c:if test="${perfume.pImageCategory eq '현대적인'}">checked</c:if>>현대적인
										<input type="checkBox" name="pImageCategory" value="활기찬"
											<c:if test="${perfume.pImageCategory eq '활기찬'}">checked</c:if>>활기찬
									</div>
									<div id="Spicy">
										<input type="checkBox" name="pImageCategory" value="강렬한"
											<c:if test="${perfume.pImageCategory eq '강렬한'}">checked</c:if>>강렬한
										<input type="checkBox" name="pImageCategory" value="화끈한"
											<c:if test="${perfume.pImageCategory eq '화끈한'}">checked</c:if>>화끈한
										<input type="checkBox" name="pImageCategory" value="섹시한"
											<c:if test="${perfume.pImageCategory eq '섹시한'}">checked</c:if>>섹시한
										<input type="checkBox" name="pImageCategory" value="도전적인"
											<c:if test="${perfume.pImageCategory eq '도전적인'}">checked</c:if>>도전적인
									</div>
									<div id="Citrus">
										<input type="checkBox" name="pImageCategory" value="매혹적인"
											<c:if test="${perfume.pImageCategory eq '상큼한'}">checked</c:if>>상큼한
										<input type="checkBox" name="pImageCategory" value="매력적인"
											<c:if test="${perfume.pImageCategory eq '경쾌한'}">checked</c:if>>경쾌한
										<input type="checkBox" name="pImageCategory" value="미스테리"
											<c:if test="${perfume.pImageCategory eq '여유로운'}">checked</c:if>>여유로운
										<input type="checkBox" name="pImageCategory" value="성숙함"
											<c:if test="${perfume.pImageCategory eq '자유로운'}">checked</c:if>>자유로운
									</div>
								</div>
							</div>
							<div class="div" id="ox">
								<label>리스트 노출 여부 </label> <input type="radio" name="perfumeStatus"
									value="1"
									<c:if test="${perfume.perfumeStatus eq '1'}">checked</c:if> /> 노출
								<input type="radio" name="perfumeStatus" value="0"
									<c:if test="${perfume.perfumeStatus eq '0'}">checked</c:if> /> 비노출
							</div>
							<div style="text-align: right;">
								<button type="submit" class="sub_btn">수정하기</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<script>
		$("input:checkbox[name='pImageCategory']:checked").val()
		loadCheckboxes();
		// 			파일 선택시 이미지 불러옴
		function loadImg(obj) {
			if (obj.files.length != 0 && obj.files[0] != 0) {
				let reader = new FileReader();
				reader.readAsDataURL(obj.files[0]);
				reader.onload = function(e) {
					document.querySelector("#img-view").setAttribute("src",
							e.target.result);
				}
			} else {
				document.querySelector("#img-view").setAttribute("src", "");
			}
		}
		function loadCheckboxes() {
			var selectBox = document.getElementById("mySelect");
			var checkboxes = document.getElementById("checkboxes").children;
			var pImgCategory = "${perfume.pImageCategory}";
			var pScentCategory = "${perfume.pScentCategory}";
			if (selectBox.value == "All") {
				for (var i = 0; i < checkboxes.length; i++) {
					checkboxes[i].style.display = "block";
				}
			} else {
				// checked 박아주는 코드 (챗지피티) DB에 중복 적용 문제 있음
				// 					for (var i = 0; i < checkboxes.length; i++) {
				// 					    checkboxes[i].style.display = checkboxes[i].id === selectBox.value ? "block" : "none";
				// 					    var pCategoryArr = pImgCategory.split(",");
				// 					    for (var j = 0; j < checkboxes[i].children.length; j++) {
				// 					        checkboxes[i].children[j].checked = pCategoryArr.includes(checkboxes[i].children[j].value);
				// 					    }
				// 					}
				// checked 박아주는 코드 (강사님)
				for (var i = 0; i < checkboxes.length; i++) {
					checkboxes[i].style.display = "none";
					if (checkboxes[i].id === selectBox.value) {
						checkboxes[i].style.display = "block";
						var pCategoryArr = pImgCategory.split(",");
						for (var j = 0; j < checkboxes[i].children.length; j++) {
							for (var k = 0; k < pCategoryArr.length; k++) {
								if (checkboxes[i].children[j].value == pCategoryArr[k]) {
									checkboxes[i].children[j].checked = "true";
								}
							}
						}
					}
				}
			}
		}

		function showCheckboxes() {
			var selectBox = document.getElementById("mySelect");
			var checkboxes = document.getElementById("checkboxes").children;

			if (selectBox.value == "All") {
				for (var i = 0; i < checkboxes.length; i++) {
					checkboxes[i].style.display = "block";
				}
			} else {
				for (var i = 0; i < checkboxes.length; i++) {
					checkboxes[i].style.display = "none";
					if (checkboxes[i].id === selectBox.value) {
						checkboxes[i].style.display = "block";
					}
				}
			}
		}
	</script>
</body>
</html>