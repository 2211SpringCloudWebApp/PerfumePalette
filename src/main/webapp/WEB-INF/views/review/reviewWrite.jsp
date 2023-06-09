<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>𝑷𝒆𝒓𝒇𝒖𝒎𝒆 𝑷𝒂𝒍𝒆𝒕𝒕𝒆</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
 
<link rel="stylesheet" href="../../../resources/reviewCss/reviewWrite.css">
<!-- favicon : 탭에 보이는 아이콘 -->
<link rel="icon" href="../../resources/img/common/favicon.png" />
<link rel="apple-touch-icon" href="../../resources/img/common/favicon.png" />
</head>
<body>
   <jsp:include page="../common/header.jsp" />
   <main>
      <!-- 헤더 부분 피하기 위한 div -->
      <div id="forHeader"></div>
      <!-- 본문 내용 가운데 정렬 위한 div -->
      <div id="forCenter">
         <form action="/review/reviewWrite" method="post" enctype="multipart/form-data">
         <input type="hidden" name="id" value="${id }" id="id">
         <input type="hidden" name="perfumeNo" value="${perfume.perfumeNo }">
         <input type="hidden" name="perfumeBrand" value="${perfume.perfumeBrand}">
         <input type="hidden" name="perfumeName" value="${perfume.perfumeName}">
         <input type="hidden" name="perfumePrice" value="${perfume.perfumePrice}">
         <input type="hidden" name="memberNo" value="${member.memberNo }">
            <div id="outter">
               <div id="subject">REVIEW</div>
               <div class="productInfo">
                  <div class="product">
                     <label>상품정보</label>
                  </div>
                  <div class="product-info">
                     <div class="productImg">
                        <img src="../../../resources/img/perfumeFileUploads/${perfume.pFilerename}" alt="">
                     </div>
                     <div class=productDetails>
                           <div class="productTitle">[${perfume.perfumeBrand}] ${perfume.perfumeName}</div>
                           <div class="productPrice"><fmt:formatNumber value="${perfume.perfumePrice }" pattern="#,##0"/>원</div>
                        </div>
                  </div>
               </div>
               <div class="productInfo">
                  <div class="product">
                     <label>작성자</label>
                  </div>
                  <div class="user-name">${member.memberNickname }</div>
               </div>
               <div class="productInfo">
                  <div class="product">
                  	<label>별점</label>
                  </div>
                  <div class="star-rating">
                        <span class="fa fa-star-o" data-rating="1"></span>
                        <span class="fa fa-star-o" data-rating="2"></span>
                        <span class="fa fa-star-o" data-rating="3"></span>
                        <span class="fa fa-star-o" data-rating="4"></span>
                        <span class="fa fa-star-o" data-rating="5"></span>
                        <!-- 별 몇개 찍혔는지 출력해 줌 -->
                        <input type="hidden" name="rViewscore" class="rating-value" value="0">
                    </div>
               </div>
               <div class="productInfo">
                  <div class="product">
                  	<label>상품평</label>
                  </div>
               </div>
               <div id="editorapi">
                  <textarea id="summernote" name="reviewContents" required="required"></textarea>
               </div>
               <div class="input-btn">
                  <input type="submit" value="등록하기">
                  <input type="reset" value="취소하기" onclick="cancel()">
               </div>
            </div>
         </form>
      </div>
   </main>
   
   <script>
   <!-- 별점 -->
    const stars = document.querySelectorAll('.star-rating span');
    
    stars.forEach(function (star) {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-rating');
            const ratingInput = document.querySelector('.rating-value');
            ratingInput.value = rating;
            for (let i = 0; i < stars.length; i++) {
                if (i < rating) {
                    stars[i].classList.add('checked');
                } else {
                    stars[i].classList.remove('checked');
                }
            }
        });
    });
        console.log($('#summernote'))
        const fontList = ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'MapoFlowerIsland', '맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'];
        $('#summernote').summernote({
           placeholder: '내용을 작성하세요',
           height: 500,
            maxHeight: 400,
         lang: "ko-KR",
         toolbar: [
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                ['color', ['forecolor','color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert',['picture']],
                ['view', ['fullscreen', 'help']]
             ],
             fontNames: fontList,
             fontNamesIgnoreCheck: fontList,
             fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
             callbacks : {
                   onImageUpload : function(files, editor, welEditable) {
                       for (let i = files.length - 1; i >= 0; i--) {
                           uploadSummernoteImageFile(files[i],
                               this);
                       }
                   }
               }
          });
        
        function uploadSummernoteImageFile(file, el) {
            let data = new FormData();
            let id = document.getElementById("id").value;
            data.append("file", file);
            data.append("id", id);
            $.ajax({
                data : data,
                type : "POST",
                url : "/review/ImgFileUpload",
                contentType : false,
                enctype : 'multipart/form-data',
                processData : false,
                success : function(data) {
                    $img = $('<img>').attr({ src: data.src });
                    $(el).summernote('insertNode', $img[0]);
                }
            });
        }
        
        function cancel() {
        	  if (confirm("정말 취소하시겠습니까?")) {
        	    location.href="/review/reviewList"
        	  }
        	}
        
   </script>
   
<jsp:include page="../common/footer.jsp" />

</body>
</html>