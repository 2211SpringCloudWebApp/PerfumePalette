package com.kh.perfumePalette.member;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.perfumePalette.Alert;
import com.kh.perfumePalette.qnaBoard.QnaBoard;
import com.kh.perfumePalette.rcomment.ReviewComment;
import com.kh.perfumePalette.review.Review;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService mService;

	// 회원가입
	@GetMapping("/enroll")
	public ModelAndView enroll(ModelAndView mv, HttpSession session) {
		mv.setViewName("member/enroll");
		
		// 세션에 저장된 회원 정보를 가져오기 
        Member loginUser = (Member) session.getAttribute("member");
        
        // 이미 로그인된 상태인 경우
        if (loginUser != null) {
        	// 홈으로 이동하도록 알림창 띄우고,  알림창을 표시하는 뷰 반환 
            Alert alert = new Alert("/", "이미 로그인된 상태입니다.");
            mv.addObject("alert", alert).setViewName("common/alert");
            return mv; // 홈으로 이동
        }
        
     // 로그인되지 않은 상태인 경우, 알림창을 띄우고 로그인 페이지로 이동 
        Alert alert = new Alert("/member/login", "로그인이 필요한 서비스 입니다.");
        mv.addObject("alert", alert).setViewName("common/alert");
		return mv;
	}

	@PostMapping("/enroll")
	public ModelAndView enroll(ModelAndView mv, @ModelAttribute Member member,
			@RequestParam("memberDetailAddr") String memberDetailAddr
			, String postcode) {
		try {
			member.setMemberAddr(member.getMemberAddr() + "/ " + memberDetailAddr + " (" + postcode + ")");
			int result = mService.insertMember(member);
			if (result > 0) {
				Alert alert = new Alert("/member/login", "회원가입에 성공했습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				Alert alert = new Alert("/member/enroll", "회원가입에 실패했습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace(); // 콘솔창에 에러 출력
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

	// 아이디 유효성 체크
	@PostMapping(value = "/idChk", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public int idCheck(String memberId) {
		int result = mService.checkId(memberId);
		Pattern pattern = Pattern.compile("^[a-zA-Z0-9]{4,20}$");
		Matcher matcher = pattern.matcher(memberId);

		if ((memberId.length() < 4 || memberId.length() > 20) || !matcher.matches()) {
			return -2;
		}

		return result;
	}

	// 닉네임 유효성 체크
	@PostMapping(value = "/nicknameChk", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public int nickname(String memberNickname) {
		int result = mService.checkNickname(memberNickname);
		Pattern pattern = Pattern.compile("^[a-zA-Z0-9가-힣]{2,20}$");
		Matcher matcher = pattern.matcher(memberNickname);

		if ((memberNickname.length() < 2 || memberNickname.length() > 20) || !matcher.matches()) {
			return -2;
		}

		return result;
	}

	// 비밀번호 유효성 체크
	@PostMapping(value = "/pwChk", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public int password(String memberPw, String reMemberPw) {
		int result = 0;
		if (!memberPw.equals(reMemberPw)) {
			result = 1;
		}

		Pattern pattern = Pattern.compile("^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$");
		Matcher matcher = pattern.matcher(String.valueOf(memberPw));

		if (memberPw.length() < 8 || reMemberPw.length() > 20 || !matcher.matches()) {
			return -2;
		}

		return result;
	}

	// 이메일 유효성 체크
	@PostMapping(value = "/emailChk", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public int emailCheck(String memberEmail) {
		int result = mService.checkEmail(memberEmail);
		Pattern pattern = Pattern
				.compile("^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$");
		Matcher matcher = pattern.matcher(memberEmail);

		if (memberEmail.length() > 100) {
			return -2;
		} else if (!matcher.matches()) {
			return -3;
		}

		return result;
	}

	// 로그인
	@GetMapping("/login")
	public ModelAndView login(ModelAndView mv, HttpSession session) {
		
		// 세션에 저장된 회원 정보를 가져오기 
        Member loginUser = (Member) session.getAttribute("member");
        
        // 이미 로그인된 상태인 경우
        if (loginUser != null) {
        	// 홈으로 이동하도록 알림창 띄우고,  알림창을 표시하는 뷰 반환 
            Alert alert = new Alert("/", "이미 로그인된 상태입니다.");
            mv.addObject("alert", alert).setViewName("common/alert");
            return mv; // 홈으로 이동
        }
     // 로그인되지 않은 상태인 경우, 로그인 페이지로 이동 
		mv.setViewName("member/login");
		return mv;
	}
	
	@PostMapping("/login")
	public ModelAndView login(HttpServletRequest request
			, @ModelAttribute Member member
			, ModelAndView mv
			, HttpSession session) {
		try {
			
	        // 로그인 처리
			Member loginUser = mService.login(member);
			if (loginUser != null) {
				// member_status = 1인 사람만 로그인 가능
				if (loginUser.getMemberStatus() == 1) {
					HttpSession session1 = request.getSession();
					// 최종 수정 - memberNo, memberId, memberNickname, memberName 들어있음!
					session1.setAttribute("member", loginUser);

					if (session1.getAttribute("mbtiResult") == null) {
						mv.setViewName("redirect:/");
					} else {
						mv.setViewName("redirect:/mbti/mbtiResult");
					}
				} else { // 탈퇴한 회원일 경우
					Alert alert = new Alert("/member/login", "이미 탈퇴한 회원입니다.");
					mv.addObject("alert", alert).setViewName("common/alert");
				}
			} else { // 로그인 실패
				Alert alert = new Alert("/member/login", "아이디 또는 비밀번호를 다시 확인해주세요");
				mv.addObject("alert", alert).setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

	
	
	// 로그아웃
	@GetMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, ModelAndView mv) {
		try {
			HttpSession session = request.getSession();
			if (session != null) {
				session.invalidate();
				mv.setViewName("redirect:/");
			} else {
				mv.setViewName("redirect:/");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

	// 마이페이지
	@GetMapping("/myPage")
	public ModelAndView myPage(HttpSession session, HttpServletRequest request, ModelAndView mv) {
		try {
			Member member = (Member) session.getAttribute("member");
			if (member != null) {
				member = mService.selectMemberById(member.getMemberId());
				mv.addObject("memerOne", member);
				mv.setViewName("member/myPage");
			} else {
				Alert alert = new Alert("/member/login", "로그인이 필요한 서비스입니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

	@PostMapping("/myPage")
	public ModelAndView myPage(ModelAndView mv, @ModelAttribute Member member,
			@RequestParam("memberDetailAddr") String memberDetailAddr
			, String postcode) {
		try {
			member.setMemberAddr(member.getMemberAddr() + "/ " + memberDetailAddr + " (" + postcode + ")");
			int result = mService.modifyMember(member);
			if (result > 0) {
				Alert alert = new Alert("/member/myPage", "정보변경 성공했습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				Alert alert = new Alert("/member/myPage", "정보변경 실패했습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

	// 아이디 찾기
	@GetMapping("findId")
	public ModelAndView findId(ModelAndView mv, HttpSession session) {
		mv.setViewName("member/findId");
		
		// 세션에 저장된 회원 정보를 가져오기 
        Member loginUser = (Member) session.getAttribute("member");
        
        // 이미 로그인된 상태인 경우
        if (loginUser != null) {
        	// 홈으로 이동하도록 알림창 띄우고,  알림창을 표시하는 뷰 반환 
            Alert alert = new Alert("/", "이미 로그인된 상태입니다.");
            mv.addObject("alert", alert).setViewName("common/alert");
            return mv; // 홈으로 이동
        }
        
     // 로그인되지 않은 상태인 경우, 알림창을 띄우고 로그인 페이지로 이동 
        Alert alert = new Alert("/member/login", "로그인이 필요한 서비스 입니다.");
        mv.addObject("alert", alert).setViewName("common/alert");
		return mv;
		
	}

	@PostMapping("/findId")
	public ModelAndView findId(@ModelAttribute Member member, ModelAndView mv) {
		try {
			Member getUser = mService.findId(member);
			if (getUser != null) {
				mv.addObject("member", getUser);
				mv.setViewName("member/showId");
			} else {
				Alert alert = new Alert("/member/findId", "일치하는 정보가 존재하지 않습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 비밀번호 찾기
	@GetMapping("findPw")
	public ModelAndView findPw(ModelAndView mv, HttpSession session) {
		mv.setViewName("member/findPw");
		
		// 세션에 저장된 회원 정보를 가져오기 
        Member loginUser = (Member) session.getAttribute("member");
        
        // 이미 로그인된 상태인 경우
        if (loginUser != null) {
        	// 홈으로 이동하도록 알림창 띄우고,  알림창을 표시하는 뷰 반환 
            Alert alert = new Alert("/", "이미 로그인된 상태입니다.");
            mv.addObject("alert", alert).setViewName("common/alert");
            return mv; // 홈으로 이동
        }
        
     // 로그인되지 않은 상태인 경우, 로그인 페이지로 이동 
        Alert alert = new Alert("/member/login", "로그인이 필요한 서비스 입니다.");
        mv.addObject("alert", alert).setViewName("common/alert");
		return mv;
	}

	@PostMapping("/findPw")
	public ModelAndView findPw(@ModelAttribute Member member, ModelAndView mv) {
		try {
			Member getUser = mService.findPw(member);
			if (getUser != null) {
				mv.addObject("member", getUser);
				mv.setViewName("member/changePw");
			} else {
				Alert alert = new Alert("/member/findPw", "일치하는 회원 정보가 존재하지 않습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 비밀번호 변경
	@PostMapping("/changePw")
	public ModelAndView changePw(@ModelAttribute Member member, String newPw, String confirmPw, ModelAndView mv) {
		try {
			// 비밀번호 유효성 체크
			String pwPattern = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$";

			boolean isValidPw = newPw.matches(pwPattern);

			if (!newPw.equals(confirmPw)) {
				Alert alert = new Alert("/member/findPw", "새로운 비밀번호와 비밀번호 확인 값이 일치하지 않습니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else if (!isValidPw) {
				Alert alert = new Alert("/member/findPw", "비밀번호는 8자 이상, 영문, 숫자 조합으로 이루어져야 합니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				member.setMemberPw(newPw);
				int result = mService.updatePw(member);
				if (result > 0) {
					Alert alert = new Alert("/member/login", "비밀번호 변경에 성공하였습니다.");
					mv.addObject("alert", alert);
					mv.setViewName("common/alert");
				} else {
					Alert alert = new Alert("/member/findPw", "비밀번호 변경에 실패했습니다. 다시 시도해주세요.");
					mv.addObject("alert", alert);
					mv.setViewName("common/alert");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/error");
		}
		return mv;
	}

	// 주문내역조회
	@GetMapping("/orderList")
	public ModelAndView orderList(ModelAndView mv) {
		mv.setViewName("member/orderList");
		return mv;
	}

	// 내가 작성한 후기
	@GetMapping("/myReview")
	public ModelAndView myReviewList(ModelAndView mv
			, HttpServletRequest request
			, HttpSession session) {
		try {
			Member member = (Member) session.getAttribute("member");
			if (member == null) {
				// member가 null인 경우 처리
				Alert alert = new Alert("/member/login", "로그인이 필요한 서비스입니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				int memberNo = member.getMemberNo();
				// memberNo를 이용한 다른 처리
				// memberNo에 해당하는 후기 목록 가져오기***
				List<Review> myReviews = mService.getMyReviews(memberNo);
				for (Review review : myReviews) {
					String outpuString = review.getReviewContents().replaceAll("<[^>]*>", "");
					review.setReviewContents(outpuString);
					
					// JSP에서 사용할 rList에 myReviews 설정
					mv.addObject("myReviews", myReviews);
				}
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

	// 후기글 삭제
	@PostMapping("/removeReview")
	@ResponseBody
	public String removeReview(int[] arr, HttpServletRequest request) {
		int result = 0;
		try {
			for (int i = 0; i < arr.length; i++) {
				result = mService.removeReview(arr[i]);
			}
			if (result > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}

	// 내가 작성한 문의
	@GetMapping("/myQna")
	public ModelAndView myQna(ModelAndView mv, HttpServletRequest request, HttpSession session) {
		try {
			Member member = (Member) session.getAttribute("member");
			if (member == null) {
				// member가 null인 경우 처리
				Alert alert = new Alert("/member/login", "로그인이 필요한 서비스입니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				int memberNo = member.getMemberNo();
//			    // memberNo를 이용한 다른 처리
//			    // memberNo에 해당하는 문의 목록 가져오기
				List<QnaBoard> myQna = mService.getMyQna(memberNo);
				
//			    // JSP에서 사용할 qList에 myQna 설정
				mv.addObject("myQna", myQna);
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
	// 문의글 삭제
	@PostMapping("/removeQna")
	@ResponseBody
	public String removeQna(int[] arr, HttpServletRequest request) {
		int result = 0;
		try {
			for (int i = 0; i < arr.length; i++) {
				result = mService.removeQna(arr[i]);
			}
			if (result > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	

	// 내가 작성한 댓글
	@GetMapping("/myComment")
	public ModelAndView myComment(ModelAndView mv, HttpSession session) {
		try {
			Member member = (Member) session.getAttribute("member");
			if (member == null) {
				// member가 null인 경우 처리
				Alert alert = new Alert("/member/login", "로그인이 필요한 서비스입니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				int memberNo = member.getMemberNo();
//			    // memberNo를 이용한 다른 처리
//			    // memberNo에 해당하는 문의 목록 가져오기
				List<ReviewComment> myComment = mService.getMyComment(memberNo);
				
//			    // JSP에서 사용할 cList에 myComment 설정
				mv.addObject("myComment", myComment);
			}
		} catch (Exception e) {
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
	// 댓글 삭제
		@PostMapping("/removeComment")
		@ResponseBody
		public String removeComment(int[] arr, HttpServletRequest request) {
			int result = 0;
			try {
				for (int i = 0; i < arr.length; i++) {
					result = mService.removeComment(arr[i]);
				}
				if (result > 0) {
					return "1";
				} else {
					return "0";
				}
			} catch (Exception e) {
				e.printStackTrace();
				return e.getMessage();
			}
		}

		
		
	// 회원탈퇴
	@GetMapping("/bye")
	public ModelAndView bye(ModelAndView mv, HttpSession session) {
		mv.setViewName("member/bye");
		
		// 세션에 저장된 회원 정보를 가져오기 
        Member loginUser = (Member) session.getAttribute("member");
        
        // 이미 로그인된 상태인 경우
        if (loginUser != null) {
        	// 홈으로 이동하도록 알림창 띄우고,  알림창을 표시하는 뷰 반환 
            Alert alert = new Alert("/", "이미 로그인된 상태입니다.");
            mv.addObject("alert", alert).setViewName("common/alert");
            return mv; // 홈으로 이동
        }
        
     // 로그인되지 않은 상태인 경우, 알림창을 띄우고 로그인 페이지로 이동 
        Alert alert = new Alert("/member/login", "로그인이 필요한 서비스 입니다.");
        mv.addObject("alert", alert).setViewName("common/alert");
		return mv;
		
	}

	@PostMapping("/bye")
	public ModelAndView bye(HttpServletRequest request, @ModelAttribute Member member, ModelAndView mv) {
		try {
			// 입력한 비밀번호를 확인하고 맞지 않으면 회원탈퇴 실패 처리
			Member checkPw = mService.checkPw(member);
			if (checkPw == null || !checkPw.getMemberPw().equals(member.getMemberPw())) {
				Alert alert = new Alert("/member/bye", "비밀번호가 일치하지 않습니다");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				// 회원탈퇴 처리
				member.setMemberStatus(0);
				int result = mService.bye(member);
				if (result > 0) {
					// 세션 무효화 후 메인 페이지로 이동
					HttpSession session = request.getSession();
					if (session != null) {
						session.invalidate();
					}
					Alert alert = new Alert("/", "탈퇴처리 되었습니다. 이용해주셔서 감사합니다.");
					mv.addObject("alert", alert);
					mv.setViewName("common/alert");
				} else {
					Alert alert = new Alert("/member/bye", "회원 탈퇴에 실패했습니다. 다시 시도해주세요.");
					mv.addObject("alert", alert);
					mv.setViewName("common/alert");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}

}
