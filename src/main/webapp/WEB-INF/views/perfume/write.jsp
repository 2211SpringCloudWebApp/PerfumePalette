<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
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
			<h1>상품 등록</h1>
			<div class="conteiner">
				<form action="/perfume/write" method="post"
					enctype="multipart/form-data">
					<div class="inputArea">
						<div class="top_left">
							<h3>이미지</h3>
							<div id="img-viewer">
								<img id="img-view" width="300px">
							</div>
							<div class="div">
								<input class="file_btn" type="file" name="uploadFile" onchange="loadImg(this);">
							</div>
						</div>
						<div class="top_right">
							<div class="div" id="name">
								<label>상품명</label> <input type="text" class="" name="perfumeName" />
							</div>
							<div class="div" id="brand">
								<label>브랜드명</label> <input type="text" class=""
									name="perfumeBrand" />
							</div>
							<div class="div" id="vol">
								<label>향수 용량 </label>
								<select class="category2" name="perfumeVolume">
									<option value=30>30</option>
									<option value=50>50</option>
									<option value=75>75</option>
									<option value=100>100</option>
								</select>
							</div>
							<div class="div" id="price">
								<label>상품가격</label> <input type="number" class="price_num"
									name="perfumePrice" />
							</div>
							<div class="div" id="EA">
								<label>상품수량</label> <input type="number" name="perfumeQuantity"
									value="0" min="0" max="999">
							</div>
							<div class="div" id="pfSel">
								<label>향수 종류</label> <select class="category1"
									name="pScentCategory">
									<option value="Woody">Woody</option>
									<option value="Floral">Floral</option>
									<option value="Fruity">Fruity</option>
									<option value="Spicy">Spicy</option>
									<option value="Citrus">Citrus</option>
								</select>
							</div>
							<div class="div" id="img_category">
								<label>이미지 분류</label>
								<select id="mySelect" onchange="showCheckboxes()">
									<option id="All">전체</option>
									<option id="Woody">Woody</option>
									<option id="Floral">Floral</option>
									<option id="Fruity">Fruity</option>
									<option id="Spicy">Spicy</option>
									<option id="Citrus">Citrus</option>
								</select>
								<div class="div" id="checkboxes">
									<div id="Woody">
										<input type="checkBox" name="pImageCategory" value="매혹적인">매혹적인
										<input type="checkBox" name="pImageCategory" value="매력적인">매력적인
										<input type="checkBox" name="pImageCategory" value="미스테리">미스테리
										<input type="checkBox" name="pImageCategory" value="성숙함">성숙함
									</div>
									<div id="Floral">
										<input type="checkBox" name="pImageCategory" value="우아한">우아한
										<input type="checkBox" name="pImageCategory" value="연약한">연약한
										<input type="checkBox" name="pImageCategory" value="여성스러운">여성스러운
										<input type="checkBox" name="pImageCategory" value="부드러운">부드러운
										<input type="checkBox" name="pImageCategory" value="사랑스러운">사랑스러운
									</div>
									<div id="Fruity">
										<input type="checkBox" name="pImageCategory" value="명랑한">명랑한
										<input type="checkBox" name="pImageCategory" value="유쾌한">유쾌한
										<input type="checkBox" name="pImageCategory" value="현대적인">현대적인
										<input type="checkBox" name="pImageCategory" value="활기찬">활기찬
									</div>
									<div id="Spicy">
										<input type="checkBox" name="pImageCategory" value="강렬한">강렬한
										<input type="checkBox" name="pImageCategory" value="화끈한">화끈한
										<input type="checkBox" name="pImageCategory" value="섹시한">섹시한
										<input type="checkBox" name="pImageCategory" value="도전적인">도전적인
									</div>
									<div id="Citrus">
										<input type="checkBox" name="pImageCategory" value="매혹적인">상큼한
										<input type="checkBox" name="pImageCategory" value="매력적인">경쾌한
										<input type="checkBox" name="pImageCategory" value="미스테리">여유로운
										<input type="checkBox" name="pImageCategory" value="성숙함">자유로운
									</div>
								</div>
							</div>
							<div class="div" id="ox">
								<label>리스트 노출 여부 </label> 
								<input type="radio" name="perfumeStatus" value="1" checked /> 노출 
								<input type="radio" name="perfumeStatus" value="0" /> 비노출
							</div>
							<div style="text-align: right;">
								<button type="submit" class="sub_btn">등록하기</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<script>
		function loadImg(obj) {
			if (obj.files.length != 0 && obj.files[0] != 0) {
				let reader = new FileReader();
				reader.readAsDataURL(obj.files[0]);
				reader.onload = function(e) {
					document.querySelector("#img-view").setAttribute("src",
							e.target.result);
				}
			} else {
				// 					$("#img-view").attr("src", "");
				document.querySelector("#img-view").setAttribute("src", "");
			}
		}

		// 	            function showCheckboxes() {
		// 	                var select = document.getElementById("mySelect");
		// 	                var checkboxes = document.getElementById("checkboxes").getElementsByTagName("div");

		// 	                for (var i = 0; i < checkboxes.length; i++) {
		// 	                    checkboxes[i].style.display = "none";
		// 	                    if (checkboxes[i].id == select.value) {
		// 	                        checkboxes[i].style.display = "block";
		// 	                    }
		// 	                }
		// 	            }
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