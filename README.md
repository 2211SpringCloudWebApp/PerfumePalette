# PerfumePalette
<img src="https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032753/2105b04a-9066-4fd9-adfc-6cb7bbcc257a">

# 목차
* [프로젝트 소개](https://github.com/2211SpringCloudWebApp/PerfumePalette#-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%86%8C%EA%B0%9C)
* [개발 기간](https://github.com/2211SpringCloudWebApp/PerfumePalette#-%EA%B0%9C%EB%B0%9C-%EA%B8%B0%EA%B0%84)
* [멤버 구성](https://github.com/2211SpringCloudWebApp/PerfumePalette#-%EB%A9%A4%EB%B2%84-%EA%B5%AC%EC%84%B1)
* [개발 환경](https://github.com/2211SpringCloudWebApp/PerfumePalette#-%EA%B0%9C%EB%B0%9C-%ED%99%98%EA%B2%BD)
* [기술 스택](https://github.com/2211SpringCloudWebApp/PerfumePalette#-%EA%B8%B0%EC%88%A0-%EC%8A%A4%ED%83%9D)
* [주요 기능 및 상세](https://github.com/2211SpringCloudWebApp/PerfumePalette#%EC%A3%BC%EC%9A%94-%EA%B8%B0%EB%8A%A5-%EB%B0%8F-%EC%83%81%EC%84%B8)
  * 회원관리
  * MBTI
  * 상품 SHOP
  * 상품 결제
  * 찜 & 장바구니
  * 알림
  * 채팅 기능
  * 문의 게시판
  * 후기 게시판
  * 마이페이지(일반회원, 관리자)
* [실행화면](https://github.com/2211SpringCloudWebApp/PerfumePalette#-%EC%8B%A4%ED%96%89%ED%99%94%EB%A9%B4)

# 💝 프로젝트 소개
Perfume Palette는 요즘 MZ세대 사이에서 니치향수에 대한 관심이 높아지고 있는 추세에 맞추어 성향과 취향을 고려한 
맞춤형 추천 시스템인 MBTI 향수 추천과 함께 사용자들이 향수를 보다 쉽게 이해하고 선택, 추천할 수 있도록 도움을 주는 사이트입니다.

# 📆 개발 기간
```
2023.03.27 ~ 2023.05.09
```

# 👪 멤버 구성
![팀원 1](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/c7894feb-452a-4964-9203-13985fe66f2e)
![팀원 2](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/96acb106-5743-4ce2-a8c3-a1986e00e272)

# 💻 개발 환경
<img src="https://img.shields.io/badge/Eclipse IDE-2C2255?style=for-the-badge&logo=Eclipse IDE&logoColor=white"> <img src="https://img.shields.io/badge/Visual Studio Code-007ACC?style=for-the-badge&logo=Visual Studio Code&logoColor=white"> <img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"> <img src="https://img.shields.io/badge/Apache Maven-C71A36?style=for-the-badge&logo=Apache Maven&logoColor=white"> <img src="https://img.shields.io/badge/MyBatis-black?style=for-the-badge&logo=Apache MyBatis&logoColor=white"> <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">

# 🔧 기술 스택
<img src="https://img.shields.io/badge/html-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"> <img src="https://img.shields.io/badge/JAVA-007396?style=for-the-badge&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"> <img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white">

# 주요 기능 및 상세
## 1. 회원관리

|기능|내용|
|------|---|
|회원가입|개인정보를 입력하여 회원가입(유효성검사와 Ajax를 활용)|
|로그인|세션을 이용하여 로그인 구현, AdminCheck(Boolean) 값을 이용해 관리자와 회원 구분|
|아이디, 비밀번호 찾기|회원가입시 입력했던 정보를 통해 아이디를 알려주고, 비밀번호는 변경할 수 있다.|

## 2. MBTI
|기능|내용|
|------|---|
|MBTI 추천|회원들은 메인화면에 있는 MBTI테스트의 12가지 질문을 통하여 나의 성향과 취향을 알아볼 수 있으며 취합한 정보를 통하여 향수 추천을 받아 볼 수 있다. 비회원도 이용 가능하지만 결과를 보려면 가입 or 로그인이 필요하다.| 

## 3. 상품 SHOP

|기능|내용|
|------|---|
|상품 목록|판매중인 상품 목록을 볼 수 있다. 마음의 드는 상품은 찜 목록 추가 가능하며, 향수의 종류, 브랜드, 가격을 선택하여 검색 가능하고, 이미지를 클릭하면 상세페이지를 볼 수 있다.|
|상품 비교함|상품 리스트 페이지 좌측에 항상 노출된다. 비교함을 통해 상품의 향, 용량, 가격, 25ml당 가격을 한 눈에 볼 수 있으며 상세보기가 가능하다.|
|상품 상세|상세 페이지에서 바로구매 / 장바구니 / 찜 / sns공유/ 재입고 알림 서비스를 이용할 수 있다.(재고가 없을 경우 재입고 알림 버튼 노출) 또, 해당 상품의 재고가 5개 미만인 경우 재고 정보 표시한다. 바로구매를 선택 시 수량 선택후 구매 페이지 이동, 찜과 장바구니 선택 가능, 선택 상품의 정보를 sns공유 api룰 통하여 사람들에게 전달가능하다.|
|페이징|한 페이지당 16개의 상품이 보이도록 처리|

## 4. 상품 구매

|기능|내용|
|------|---|
|결제 정보|배송 정보와 결제 수단(신용카드, 가상계좌, 카카오페이, 네이버페이, 삼성페이) 개인정보 제공에 대한 동의를 입력받는다.|
|결제|결제하기 선택 시 결제 페이지로 이동하며, 결제 api를 통해 결제할 수 있다.

## 5. 찜 & 장바구니

|기능|내용|
|------|---|
|찜|회원은 상품 목록이나 상품 상세에서 찜하기가 가능하며, 찜 목록에서는 장바구니에 추가 할 수 있다.|
|장바구니|회원은 상품 상세에서 장바구니 등록이 가능하며 장바구니 목록에서 상품 선택 후 결제 OR 삭제 가능하다.|

## 6. 알림
|기능|내용|
|------|---|
|재입고 알림|재입고 알림을 신청한 상품의 재고가 0에서 증가하면 알림을 받을 수 있다.|
|좋아요 알림|내가 작성한 후기에 좋아요가 달리면 알림을 받을 수 있다.|
|댓글 알림|내가 작성한 후기에 댓글이 달리면 알림을 받을 수 있다.|
|답댓글 알림|내가 작성한 댓글에 답댓글이 달리면 알림을 받을 수 있다.|

## 7. 채팅 기능
|기능|내용|
|------|---|
|1:1고객센터|회원은 오른쪽 하단의 아이콘을 통해 관리자에게 실시간 1:1 채팅을 통하여 문의 할 수 있다.|

## 8. 문의 게시판
|기능|내용|
|------|---|
|문의 게시판|상품이나, 배송, 교환, 환불, 기타에 관한 문의를 하는 게시판이다. 상품의 상세페이지와 문의 게시판에서 작성 가능하며, 비공개를 원할 시 비밀번호 입력을 통하여 글쓴이만 볼 수 있다. 글 작성, 수정 가능하다.|
|댓글|회원이 남긴 문의 글에는 관리자가 답글을 남겨줄 수 있다.|
|페이징|한 페이지 당 10개의 글을 볼 수 있다.|

## 9. 후기 게시판
|기능|내용|
|------|---|
|후기 게시판|회원들이 상품의 정보를 얻을 수 있는 게시판이다. 후기게시판은 글 작성(구매자), 수정, 삭제, 좋아요, 신고가 가능하다. 글 작성과 수정을 할 때는 에디터 api를 사용하여 사진 첨부와 글을 꾸밀 수 있다.|
|신고|회원들은 구매회원들의 후기글을 보고 신고사유(욕설/혐오/차별적 표현, 부적절한 내용, 기타)와 함께 글을 작성하여 신고 가능하다.|
|댓글|댓글과 대댓글 작성, 수정, 삭제 가능하고 여러명이 작성 가능하다.(Ajax 활용)
|페이징|한 페이지당 10개의 게시물을 보여준다.|

## 10. 마이페이지(일반회원, 관리자)
### 10-1 일반회원
|기능|내용|
|------|---|
|마이페이지|회원은 마이페이지에서 회원의 정보를 확인 가능하며 닉네임, 비밀번호, 이름, 이메일, 휴대번호, 주소에 대해 수정이 가능하다.|
|주문내역 조회|회원이 구매한 제품의 주문번호, 주문상품, 상품가격, 주문수량, 총 결제금액, 주문상태(입금 전, 결제완료, 배송준비중, 배송중, 배송완료, 취소), 후기작성을 확인할 수 있고, 주문상태가 배송완료가 되면 후기 작성이 가능하게 된다.|
|작성 문의|회원이 작성한 문의 글을 확인할 수 있으며, 분류(배송, 교환, 환불, 기타), 제목, 작성일, 답변상태(관리자의 답변 유/무)를 확인할 수 있고, 회원이 작성한 문의는 선택 후 삭제 가능하다.|
|작성 후기|회원이 작성한 후기 글을 확인할 수 있으며, 상품 이미지, 브랜드, 상품명, 작성일, 조회수 확인 가능하며 이미지와 내용을 통해 후기 상세페이지로 이동하고, 회원이 작성한 후기는 체크박스 선택 후 삭제 가능하다.|
|작성 댓글|회원이 작성한 댓글을 확인할 수 있으며, 상품명, 브랜드, 내용, 작성일 확인 가능하고, 내용 클릭 시 자신이 작성한 댓글 페이지로 이동한다. 체크박스 선택 후 삭제 가능|
|회원 탈퇴|회원은 회원탈퇴를 선택하여 비밀번호 입력 후 회원 탈퇴 가능하다.(DB에는 남아있음)|

### 10-2 관리자
|기능|내용|
|------|---|
|판매상품 관리|상품 관리 페이지는 상품의 등록, 수정, 삭제 가능하며, 상품의 정보(이미지, 브랜드, 상품명(상품 상세 이동 가능), 용량, 가격, 재고, 향 분류, 이미지 분류, 찜 수, 장바구니 수, 노출여부, 수정)를 확인하고, 상품 선택 후 상품의 노출, 비노출, 삭제 가능하다.|
|주문내역관리|회원들이 구매한 제품의 주문번호, 주문상태, 구매자, 수취인, 주문 상품, 가격 등 필수 항목들을 볼 수 있고, 상세보기를 통해 상품정보, 결제정보, 주문정보에 대한 내용들을 상세히 볼 수 있으며 주문상태를 수정해 줄 수 있다.|
|회원관리|회원의 대략적인 정보를 볼 수 있으며 수정을 통해 상세정보와 함께 정보 수정이 가능하다. 체크박스를 통해 회원들을 정지, 활성, 완전한 삭제가 가능하다.|
|문의관리|회원들이 작성한 문의 글을 확인할 수 있으며, 분류(배송, 교환, 환불, 기타), 이미지, 브랜드, 상품명, 제목, 작성일, 답변상태(관리자의 답변 유/무)를 확인할 수 있고, 회원들이 작성한 문의는 선택 후 삭제 가능하다.|
|후기관리|회원들이 작성한 후기 글을 확인할 수 있으며, 별점, 상품 이미지, 브랜드, 상품명, 작성일, 조회수, 신고수, 후기상세 확인 가능하며 후기 상세를 통해 후기 상세페이지로 이동하고, 신고수를 통해 신고한 회원 리스트와 상세를 확인할 수 있다. 회원이 작성한 후기는 체크박스 선택 후 삭제 가능하다.|
|검색| 각 관리 페이지에는 상품이나 회원에 대한 검색 기능이 있다.|
|페이징|한 페이지 당 10개의 글을 볼 수 있다.|

# 📹 실행화면
## 1. 메인화면
![메인](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/dd2a18de-f001-4b75-8e0f-f84aac2bca49)
![메인2](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/192d32b9-49d5-4777-9cc0-99d0bd169d6a)
![메인3](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/e2e801b9-2e59-41c8-a918-d7c7b5f9ce6b)

## 2. MBTI
![mbti](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/c79c1dd4-0d8f-47ef-834a-deefbdf90d53)
![MBTI2 1](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/934f5ca3-21c0-43cd-abff-83329bd05929)

## 3. 상품 SHOP
![상품 리스트](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/af387d5c-cf7b-4c3a-a9ef-8e558a7f8eeb)
![비교함](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/88eb7f27-bf65-4a6e-8240-f157e7d8a8e7)
![상품 상세_후기](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/3b711ec7-41a2-4a45-bb12-4c3ac435b1f6)
![상품 상세_문의](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/eb665046-8a42-4336-b9e7-543696e87626)

## 4. 상품 구매
![상품 주문](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/d6ed928a-d120-4123-822c-0cbc130fdaac)
![스크린샷 2023-05-10 025615](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/8dffb1b2-9483-4255-9d61-3ed3db6a7218)

## 5. 찜 & 장바구니
![찜 리스트](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/4c011db0-a45b-414d-9a87-a95aeffda4bd)
![장바구니 리스트](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/e5d94424-0d9f-475e-b9b9-ccdee4f8c7b7)

## 6. 알림
![알림](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/b668d5ce-8c78-4436-b18d-ae309321b6ec)

## 7. 채팅
![1ㄷ1채팅](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/39576e4a-2a8c-48d1-861c-ecff76ff22b0)

## 8. 문의 게시판
![문의 작성](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/1ddf3cc6-c660-4711-b2fe-71fb10003c7e)
![문의 수정](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/5a16c40b-7d74-40bf-8685-068244cca7f6)
![문의 게시판 리스트](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/cc812b73-2038-4a3a-86e7-a86047363f1e)
![문의 상세](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/67e3015f-9313-4a12-807d-3af9d39dd8a7)

## 9. 후기 게시판
![리뷰 등록](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/0ca9a028-2f9a-4ba6-8d21-af5ec79c4bd6)
![리뷰 수정](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/2229bf20-9f06-4b08-b4d8-01430a16d18d)
![리뷰 리스트](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/89ffcfda-e994-47d4-ba29-42ec005e92d2)
![리뷰 상세](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/f27c9cb8-77bd-4a30-827f-adb84789d5d5)

## 10. 마이페이지 회원
### 10.1 정보_수정
![마이페이지 회원 정보_수정](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/8eb0d6c7-8365-45f6-a7c8-37da8881f239)

### 10.2 주문내역 조회
![주문조회](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/303e8b10-b27a-46d0-aac3-ed7a73fede41)

### 10.3 작성 문의
![작성 문의 회원](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/1da5ff44-ef9b-4743-a2c9-5e4290ce7052)

### 10.4 작성 후기
![작성 후기 회원](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/4cfc664f-1357-4d7d-90d0-5c667bde3a50)

### 10.5 작성 댓글
![작성 댓글](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/377b6be1-96f5-4d74-9758-2cc34518928d)

### 10.6 회원 탈퇴
![회원탈퇴](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/38683bc0-c90c-40a9-903f-a8bc6187a205)

## 11 관리자
### 11.1-1 판매상품 관리
![상품 관리](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/76f64e85-4c91-4d56-ba80-33da463719d4)

### 11.1-2 찜 & 장바구니 회원 목록
![찜 회원 목록](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/01032af4-cb88-48df-9041-99893301f3be)
![장바구니 회원 목록](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/aabb93c3-aaa5-43a1-a2a2-22e9ad031e33)

### 11.2-1 주문내역 관리
![주문내역관리](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/b91833c4-fcf4-48ca-ac33-a66761248641)

### 11.2-2 주문내역 상세
![주문내역상세](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/16b72aba-7a59-439a-b5e7-de9247875618)

### 11.3 회원 관리
![회원관리](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/c7cf4edb-2610-459e-8a80-6d7a9e9a98ac)

### 11.4 문의 관리
![문의관리](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/d5f0b299-d80d-4758-9c7c-0cabc02cff91)

### 11.5-1 후기 관리
![후기 관리](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/089f317f-9605-48aa-a74c-2cf35ce412b9)

### 11.5-2 신고 관리
![신고 관리](https://github.com/2211SpringCloudWebApp/PerfumePalette/assets/119032790/207f7dcc-55ee-48d3-ba2b-5c649531a6db)






