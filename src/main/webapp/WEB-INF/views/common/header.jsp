<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../../../resources/commonCss/header.css">
<!-- 채팅 관련 필요 -->
<!-- sockjs  -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- alertify 꾸미는 알림창-->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
<!-- alertify css -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css" />
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css" />
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css" />
</head>
<header>

	<div id="logo-area">
		<div id="logo-img" onclick="location.href='/'"></div>
	</div>

	<div id="navBar-area">
		<div id="nav-left">
			<div class="nav-left-title">
				<div>Perfume</div>
				<div class="nav-left-hidden">
					<div class="nav-left-bar"></div>
					<div style="width: 150px; background-color: rgba(255, 255, 255, 0);"></div>
					<div class="nav-left-detail">
						<div onclick="location.href='/perfume/list'">Shop</div>
						<div>Recommend</div>
					</div>
				</div>
			</div>

			<div class="nav-left-title">
				<div>Community</div>
				<div class="nav-left-hidden">
					<div class="nav-left-bar"></div>
					<div style="width: 150px; background-color: rgba(255, 255, 255, 0);"></div>
					<div class="nav-left-detail">
						<div onclick="location.href='/review/reviewList'">Review</div>
						<div onclick="location.href='/qnaboard/list'">Q&A</div>
					</div>
				</div>
			</div>
		</div>

		<div id="nav-right">

			<!-- 비로그인 상태 -->
			<c:if test="${sessionScope.member eq null }">
				<div onclick="location.href='/member/enroll'">
					<img src="../../resources/img/common/user.png" alt="">
					<div class="menu-info">회원가입</div>
				</div>
				<div onclick="location.href='/member/login'">
					<img src="../../resources/img/common/login.png" alt="">
					<div class="menu-info">로그인</div>
				</div>
			</c:if>

			<!-- 로그인 상태 -->
			<c:if test="${sessionScope.member ne null }">

				<!-- 관리자가 아니라면 마이페이지 -->
				<c:if test="${member.memberId ne 'admin' }">
					<div id="alert-hover-area">
						<img src="../../resources/img/common/user.png" alt="">

						<div id="alert">
							<div onclick="location.href='/member/myPage'">${member.memberNickname}님마이페이지</div>
						</div>

					</div>
				</c:if>

				<!-- 관리자가 맞다면 관리자페이지 -->
				<c:if test="${member.memberId eq 'admin' }">
					<div onclick="location.href='/member/myPage'">Manager Page</div>
				</c:if>

				<div onclick="location.href='/member/logout'">
					<img src="../../resources/img/common/logout.png" alt="">
					<div class="menu-info">로그아웃</div>
				</div>

			</c:if>

			<div>
				<img src="../../resources/img/common/cart.png" alt="" onclick="location.href = '/cart/list'">
				<div class="menu-info">장바구니</div>
			</div>
			<div>
				<img src="../../resources/img/common/wish.png" alt="" onclick="location.href = '/wish/list'">
				<div class="menu-info">찜</div>
			</div>

		</div>
	</div>

	<div id="chat-area">
		<div onclick="chat()" id="chat-btn">
			<img src="../../resources/img/common/chat-white.png" alt="">
		</div>

		<div id="chat-modal-bg">
			<div id="chat-modal">
				<span id="chat-modal-close-btn">×</span>
				<div id="helloMsg">
					<div id="pBox">
						<p>Perfume Palette에 상담하기</p>
						<p>️⚡️월요일 09:00부터 운영</p>
					</div>
					<div class="chatting-area">
						<ul class="display-chatting">
							<c:forEach items="${list }" var="msg">
								<%-- 1) 내가 보낸 메세지 --%>
								<c:if test="${msg.memberId == member.memberId }">
									<li class="myChat"><span class="chatDate">${chatDate}</span>
										<p class="chat" style="text-align: left;">${msg.chatContent}</p></li>
								</c:if>
								<%-- 2) 남(이름)이 보낸 메세지 --%>
								<c:if test="${msg.memberId != member.memberId }">
									<li><b>${msg.memberNickname}</b><br>
										<p class="chat">${msg.chatContent}</p><span class="chatDate">${chatDate}</span></li>
								</c:if>
							</c:forEach>
						</ul>

						<div class="input-area">
							<textarea id="inputChatting" placeholder="메세지를 입력해주세요."></textarea>
							<button id="send">
								<img src="../../../resources/img/chat/arrow.png" alt="arrow">
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</header>

<script>
	/* 여기 아래부터 채팅 관련 스크립트 절대 건들지 마시오! */

	// Enter key를 누르면 send 버튼을 클릭하는 이벤트 핸들러
	document.getElementById("inputChatting").addEventListener("keydown",
			function(event) {
				if (event.keyCode === 13 && !event.shiftKey) { // Enter key
					event.preventDefault(); // 기본 동작 취소 (textarea에서 줄바꿈 되는 것 방지)
					document.getElementById("send").click(); // send 버튼 클릭
				}
			});

	let curURL = window.location.href;
	const pattern = /:\d{4}\//;

	// 방만들었는지 확인하는 변수
	var storeRoomNum = -1;
	var chatSocket = null;

	// 채팅 버튼 눌렀을 때
	chat = function() {
		
		if(${sessionScope.member eq null}){
			alert("로그인이 필요한 서비스입니다.");
			return;
		}
		
		if(${sessionScope.member.memberId eq 'admin'}){
			location.href = '/chat/chatRoomList';
			return;
		}

		// 모달창 여닫는 속도
		let modalSpeed = 200;

		if ($('#chat-modal').css('display') === 'none') {
			// 모달창이 닫혀있다면 열기
			$("#chat-modal").fadeIn(modalSpeed);
			$("#chat-modal-bg").fadeIn(modalSpeed);
			$("body").css("overflow", "hidden");
			$("#chat-btn").css("display", "none");

			if (storeRoomNum == -1) {
				/* 방이 만들어지지 않은 경우 */
				/* 새로운 방을 만들고 그 방으로 이동 */
				$.ajax({
					type : 'POST',
					url : '/chat/openChatRoom2',
					success : function(roomNum) {
						storeRoomNum = roomNum;
						goChatRoom(storeRoomNum);
					},
					error : function(roomNum) {
						/* console.log("방 만들기 실패..") */
					}
				});
			} else {
				/* 방이 이미 만들어진 경우 */
				/* 새로운방을 만들지 않고 기존 방으로 이동 */
				goChatRoom(storeRoomNum);
			}
		}

		function goChatRoom(no) {
			$
					.ajax({
						type : 'GET',
						url : '/chat/room2/' + no,
						success : function(result) {
							const memberId = "${member.memberId}";
							const memberNickname = "${member.memberNickname}";
							const roomNo = no;

							// /chat이라는 요청주소로 통신할수있는 webSocket 객체 생성 --> /spring/chat
							if (!chatSocket) {
								chatSocket = new SockJS("/chat");
							}
							//-> websocket 프로토콜을 이용해서 해당주소로 데이터를 송/수신 할수 있다.

							/*	WebSocket
							- 브라우저와 웹 서버간의 전이중 통신을 지원하는 프로토콜
							 * 전이중 통신 (full duplex) : 두대의 단말기가 데이터를 동시에 송/수신하기위해 각각 독립된 회선을 사용하는 통신방식
							 * HTML5 , JAVA7버전 이상, SPRING 4버전이상에서 지원.
							 */

							//1. 페이지 로딩 완료시 채팅창을 맨 아래로 내리기.
							// 즉시 실행함수. IIFE
							(function() {
								const displayChatting = document
										.getElementsByClassName("display-chatting")[0];

								if (displayChatting != null) {
									displayChatting.scrollTop = displayChatting.scrollHeight;
								}
							})();

							document.getElementById("send").addEventListener(
									"click", sendMessage);

							//채팅보내는함수
							function sendMessage() {

								//채팅이 입력되는 textarea요소 가져오기.
								const inputChatting = document
										.getElementById("inputChatting");

								//클라이언트가 채팅내용을 입력하지 않은상태로 보내기 버튼을 누른경우
								if (inputChatting.value.trim().length == 0) {

									/* alert("채팅내용을 입력해주세요."); */

									inputChatting.value = ""; // 공백문자 제거해주기.
									inputChatting.focus();
								} else { // 입력이 된경우
									//메세지 입력시 필요한 데이터를 js객체로 생성.
									const chatMessage = {
										"memberId" : memberId,
										"memberNickname" : memberNickname,
										"roomNo" : roomNo,
										"chatContent" : inputChatting.value
									};

									// JSON.parse(문자열) : JSON -> JS object로 변환
									// JSON.stringify(객체) : JS Ojbect -> JSON

									/* console.log(chatMessage); */
									/* console.log(JSON.stringify(chatMessage)); */

									// chatSocket(웹소켓객체)를 이용하여 메세지 보내기
									// chatSocket.send(값) : 웹소켓 핸들러로 값을 보냄.

									chatSocket
											.send(JSON.stringify(chatMessage));

									inputChatting.value = "";
								}
								/* console.log(chatSocket.readyState
										+ ": 1이 출력되어야 정상");
								console.log(roomNo + ": 방 번호 체크"); */
							}

							// 웹소켓에서  sendMessage라는 함수가 실행되었을때 -> 메세지가 전달되었을때

							chatSocket.onmessage = function(e) {
								//debugger;
								// 매개변수 e : 발생한 이벤트에 대한 정보를 담고있는 객체 
								// e.data  : 전달된 메세지 -> message.getPayload() -> (JSON형태) 로

								// 전달받은 메세지를 JS객체로 변환
								const chatMessage = JSON.parse(e.data); // js객체로 변환.
								/* console.log(chatMessage + "sendMessage가 실행됨!!"); */

								/*
									<li>
										[<b></b>]
										<p>메세지</p>
										<span>메세지 보낸 날짜</span>
									</li>
								 */
								const li = document.createElement("li");
								const p = document.createElement("p");
								const br = document.createElement("br");

								p.classList.add("chat");

								p.innerHTML = chatMessage.chatContent.replace(
										/\n/g, "<br>"); /* 줄바꿈 효과 */

								//span태그 추가
								const span = document.createElement("span");
								span.classList.add("chatDate");

								span.innerText = getCurrentTime();

								if (chatMessage.memberId == memberId) {//내가 쓴 채팅
									li.append(span, p);
									li.classList.add("myChat");
								} else { // 남이 쓴 채팅
									li.innerHTML = "<b>"
											+ chatMessage.memberNickname
											+ "</b>";
									li.append(br, p, span);
								}

								// 채팅창
								const displayChatting = document
										.getElementsByClassName("display-chatting")[0];

								// 채팅창에 채팅 추가
								displayChatting.append(li);

								// 채팅창을 제일밑으로 내리기
								displayChatting.scrollTop = displayChatting.scrollHeight;
								// scrollTop : 스크롤 이동
								// scrollHeight : 스크롤이되는 요소의 전체 높이.

							};

							function getCurrentTime() {
								const now = new Date();
								let h = now.getHours() < 12 ? ('오전 '
										+ now.getHours() + ":") : ('오후 '
										+ (now.getHours() - 12) + ":");
								const time = " " + h
										+ addZero(now.getMinutes()) + ":"
										+ addZero(now.getSeconds()) + " ";
								return time;
							}

							function addZero(number) {
								return number < 10 ? "0" + number : number;
							}

							document.getElementById("chat-modal-close-btn")
									.addEventListener("click", exit);

							function exit() {
								$("#chat-modal").fadeOut(modalSpeed);
								$("#chat-modal-bg").fadeOut(modalSpeed);
								$("#chat-btn").css("display", "flex");
								// 메인화면에선 어차피 overflow hidden이라 바꾸면 안됨
								if (!pattern.test(curURL.slice(-6))) {
									$("body").css("overflow-y", "visible");
								}
								$.ajax({
									type : 'GET',
									url : "/chat/exit",
									data : {
										"roomNo" : roomNo,
										"memberId" : memberId
									},
									success : function(result) {
										/* chatSocket.close(); */
										/* console.log("정상적 방나가기!!") */
									},
									error : function(result) {
										/* console.log("비정상적 방나가기..") */
									}
								});
							}
						},
						error : function(result) {
							console.log("방 입장 실패..");
						}
					});
		}
	}
</script>