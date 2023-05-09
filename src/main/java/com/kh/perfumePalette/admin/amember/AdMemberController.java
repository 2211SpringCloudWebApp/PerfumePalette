package com.kh.perfumePalette.admin.amember;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.perfumePalette.Alert;
import com.kh.perfumePalette.PageInfo;
import com.kh.perfumePalette.Search;
import com.kh.perfumePalette.member.Member;
import com.kh.perfumePalette.review.Review;

@Controller
@RequestMapping("/admin/member")
public class AdMemberController {

	@Autowired
	private AdMemberService amService;

	// 멤버 수정
	@RequestMapping(value = "/amList", method = RequestMethod.POST)
	public ModelAndView amModify(
			@ModelAttribute Member member
			, ModelAndView mv) {
		try {
			int result = amService.updateAmModify(member);
			if(result > 0) {
				Alert alert = new Alert("/admin/member/amList", "정보변경 성공했습니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				Alert alert = new Alert("/admin/member/amList", "정보변경 실패했습니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
	// 회원 리스트
	@RequestMapping(value = "/amList", method = RequestMethod.GET)
	public ModelAndView viewAdminMemberList(ModelAndView mv
			, HttpSession session
			, @RequestParam(value = "page", required = false, defaultValue = "1") Integer currentPage) {
		try {
			if(session.getAttribute("member") == null || !((Member)session.getAttribute("member")).getMemberId().equals("admin")) {
				Alert alert = new Alert("/", "접근권한이 없습니다.");
				mv.addObject("alert", alert).setViewName("common/alert");
			} else {
				int totalCount = amService.getListCount();
				PageInfo pi = new PageInfo(currentPage, totalCount, 10);
				List<Member> amList = amService.selectAdMemberList(pi);
				mv.addObject("paging", pi);
				mv.addObject("amList", amList);
				mv.setViewName("admin/member/amList");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
	// 회원 검색
	@GetMapping("/search")
	public String memberSearchView(
			@ModelAttribute Search search
			, HttpSession session
			, @RequestParam(value = "page", required = false, defaultValue = "1") Integer currentPage
			, Model model) {
		try {
			if(session.getAttribute("member") == null || !((Member)session.getAttribute("member")).getMemberId().equals("admin")) {
				Alert alert = new Alert("/", "접근권한이 없습니다.");
				model.addAttribute("alert", alert);
				return "common/alert";
			} else {
				int totalCount = amService.getListCount(search);
				PageInfo pi = new PageInfo(currentPage, totalCount, 10);
				List<Member> searchList = amService.selectListByKeyword(pi, search);
				if(!searchList.isEmpty()) {
					model.addAttribute("paging", pi);
					model.addAttribute("search", search);
					model.addAttribute("sList", searchList);
					return "admin/member/search";
				} else {
					Alert alert = new Alert("/admin/member/search", "존재하지 않는 회원입니다.");
					model.addAttribute("alert", alert);
					return "common/alert";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", e.getMessage());
			return "common/error";
		}
	}
	
	// 회원 상세 정보
	public ModelAndView memberDetailView(
			@RequestParam("memberNo") int memberNo
			, ModelAndView mv) {
		try {
			Member member = amService.selectOneByNo(memberNo);
			mv.addObject("member", member);
			mv.setViewName("admin/member/amMypage");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage());
			mv.setViewName("common/error");
		}
		return mv;
	}
	
	// 회원 다중 삭제
	@PostMapping("/amRemove")
	@ResponseBody
	public String adMemberRemove(int [] arr
			, HttpServletRequest request) {
		int result = 0;
		try {
			for(int i = 0; i < arr.length; i++) {
				result = amService.deleteAdMember(arr[i]); 
				System.out.println(arr[i]);
			}
			if(result > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	
	// 회원 다중 수정(회원 임시 정지)
	@PostMapping("/stop")
	@ResponseBody
	public String memberStop(int [] arr
			, HttpServletRequest request) {
		int result = 0;
		try {
			for (int i = 0; i < arr.length; i++) {
				result = amService.updateStopMember(arr[i]);
			}
			if(result > 0) {
				return "1";
			} else {
				return "0";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	// 회원 다중 수정(정지 복구)
	@PostMapping("/start")
	@ResponseBody
	public String memberStart(int [] arr
			, HttpServletRequest request) {
		int result = 0;
		try {
			for (int i = 0; i < arr.length; i++) {
				result = amService.updateStartMember(arr[i]);
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
	
	
	
}













