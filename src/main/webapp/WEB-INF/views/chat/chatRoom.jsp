<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<!-- 공통적으로 사용할 라이브러리 추가 -->
<!-- Jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- sockjs  -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- 부트스트랩에서 제공하는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- alertify 꾸미는 알림창-->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
<!-- alertify css -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css" />
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css" />
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css" />
<style>
.chatting-area {
	margin: auto;
	height: 600px;
	width: 800px;
	margin-top: 50px;
	margin-bottom: 500px;
}

#exit-area {
	text-align: right;
	margin-bottom: 10px;
}

.display-chatting {
	width: 100%;
	height: 450px;
	border: 1px solid gold;
	overflow: auto;
	/*스크롤 처럼*/
	list-style: none;
	padding: 10px 10px;
	background: lightblue;
	z-index: 1;
	positon: absoulte;
}

.chat {
	display: inline-block;
	border-radius: 5px;
	padding: 5px;
	background-color: #eee;
}

.input-area {
	width: 100%;
	display: flex;
}

#inputChatting {
	width: 80%;
	resize: none;
}

#send {
	width: 20%;
}

.myChat {
	text-align: right;
}

.myChat>p {
	background-color: gold;
}

.chatDate {
	font-size: 10px;
}

.img {
	width: 100%;
	height: 100%;
	position: relative;
	z-index: -100;
}
</style>
</head>

<body>

	<div class="chatting-area">
		<br> <br>
		<div id="exit-area">
			<button class="btn btn-outline-danger" id="exit-btn">나가기</button>
		</div>
		<ul class="display-chatting">
			<!-- <img src=""/> -->
			<c:forEach items="${list }" var="msg">
				<fmt:formatDate var="chatDate" value="${msg.chatDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" />
				<%-- 1) 내가 보낸 메세지 --%>
				<c:if test="${msg.memberId == member.memberId }">
					<li class="myChat"><span class="chatDate">${chatDate }</span>
						<p class="chat">${msg.chatContent }</p></li>
				</c:if>
				<%-- 2) 남(이름)이 보낸 메세지 --%>
				<c:if test="${msg.memberId != member.memberId }">
					<li><b>${msg.memberNickname }</b>
						<p class="chat">${msg.chatContent }</p> <span class="chatDate">${chatDate }</span></li>
				</c:if>
			</c:forEach>
		</ul>

		<div class="input-area">
			<textarea id="inputChatting" rows="3"></textarea>
			<button id="send">보내기</button>
		</div>

	</div>

	<script>
		//el태그통해 js변수 셋팅
		const memberId = "${member.memberId}";
		const memberNickname = "${member.memberNickname}";
		const roomNo = "${roomNo}";

		// /chat이라는 요청주소로 통신할수있는 webSocket 객체 생성 --> /spring/chat
		let chatSocket = new SockJS("/chat");
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

		document.getElementById("send").addEventListener("click", sendMessage);

		//채팅보내는함수
		function sendMessage() {

			//채팅이 입력되는 textarea요소 가져오기.
			const inputChatting = document.getElementById("inputChatting");

			//클라이언트가 채팅내용을 입력하지 않은상태로 보내기 버튼을 누른경우
			if (inputChatting.value.trim().length == 0) {

				alert("채팅내용을 입력해주세요.");

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
				console.log(JSON.stringify(chatMessage));

				// chatSocket(웹소켓객체)를 이용하여 메세지 보내기
				// chatSocket.send(값) : 웹소켓 핸들러로 값을 보냄.

				chatSocket.send(JSON.stringify(chatMessage));

				inputChatting.value = "";
			}

		}

		// 웹소켓에서  sendMessage라는 함수가 실행되었을때 -> 메세지가 전달되었을때

		chatSocket.onmessage = function(e) {
			//debugger;
			// 매개변수 e : 발생한 이벤트에 대한 정보를 담고있는 객체 
			// e.data  : 전달된 메세지 -> message.getPayload() -> (JSON형태) 로

			// 전달받은 메세지를 JS객체로 변환
			const chatMessage = JSON.parse(e.data); // js객체로 변환.
			console.log(chatMessage);

			/*
				<li>
					[<b></b>]
					<p>메세지</p>
					<span>메세지 보낸 날짜</span>
				</li>
			 */
			const li = document.createElement("li");
			const p = document.createElement("p");

			p.classList.add("chat");

			p.innerHTML = chatMessage.chatContent.replace(/\\n/gm, "<br>"); //줄바꿈 처리

			//span태그 추가
			const span = document.createElement("span");
			span.classList.add("chatDate");

			span.innerText = getCurrentTime();

			if (chatMessage.memberId == memberId) {//내가 쓴 채팅
				li.append(span, p);
				li.classList.add("myChat");
			} else { // 남이 쓴 채팅
				li.innerHTML = "<b>" + chatMessage.memberNickname + "</b>";
				li.append(p, span);
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

			const time = now.getFullYear() + "년 " + addZero(now.getMonth() + 1)
					+ "월 " + addZero(now.getDate()) + "일 "
					+ addZero(now.getHours()) + ":" + addZero(now.getMinutes())
					+ ":" + addZero(now.getSeconds()) + " ";

			return time;
		}

		// 10보다 작은수가 매개변수로 들어오는경우 앞에 0을 붙여서 반환해주는함수.
		function addZero(number) {
			return number < 10 ? "0" + number : number;
		}

		document.getElementById("exit-btn").addEventListener("click", exit);

		function exit() {

			$.ajax({
				url : "/chat/exit",
				data : {
					"roomNo" : roomNo,
					"memberId" : memberId
				},
				success : function(result) {
					if (result == 1) { // 정상적으로 종료됨.
						location.href = "/chat/chatRoomList"
					} else { //
						alert("에러가 발생했습니다.");
					}
				}
			})
		}
	</script>


</body>

</html>