package com.kh.perfumePalette.admin.aorder;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.perfumePalette.Alert;
import com.kh.perfumePalette.PageInfo;
import com.kh.perfumePalette.admin.aorder.domain.AdOrder;
import com.kh.perfumePalette.member.Member;
import com.siot.IamportRestClient.IamportClient;

@Controller
@RequestMapping("/admin/order")
public class AdOrderController {

	@Autowired
	private AdOrderService oService;
	
	private IamportClient client;
	
	public AdOrderController() {
		// 토큰 발급
		this.client = new IamportClient("4277187304487763", "lNYZWFOP2ClwCRWgcbvA87zCMWStJQn4ChyXvL0M4aojX3h8OayURuVM46qC9tQy2zvi7RDYF4v5sxFf");
	}
	
	// 주문내역 수정
	@PostMapping("/update")
	public ModelAndView orderUpdate(
			@ModelAttribute AdOrder order
			, ModelAndView mv
			, HttpServletRequest request) {
		try {
			int result = oService.updateOrder(order);
			if(result > 0) {
				Alert alert = new Alert("/admin/order/list", "주문상태가 수정되었습니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			} else {
				Alert alert = new Alert("/admin/order/detail?orderNo=" + order.getOrderNo(), "주문상태 변경이 완료되지 않았습니다.");
				mv.addObject("alert", alert);
				mv.setViewName("common/alert");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
	
	// 주문내역 리스트
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView viewAdminOderList(
			ModelAndView mv
			, HttpSession session
			, @RequestParam(value = "page", required = false, defaultValue = "1") Integer currentPage) {
		try {
			if (session.getAttribute("member") == null || !((Member)session.getAttribute("member")).getMemberId().equals("admin")) {
				Alert alert = new Alert("/", "접근권한이 없습니다.");
				mv.addObject("alert", alert).setViewName("common/alert");
			} else {
				int totalCount = oService.getOrderListCount();
				PageInfo pi = new PageInfo(currentPage, totalCount, 10);
				List<AdOrder> oList = oService.selectAdminOrderList(pi);
				mv.addObject("paging", pi);
				mv.addObject("oList", oList);
				mv.setViewName("admin/order/list");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
	// 주문내역 상세 뷰
	@GetMapping("/detail")
	public ModelAndView adminOrderDetailView(ModelAndView mv
			, @RequestParam("orderNo") long orderNo
			, HttpSession session) {
		System.out.println("주문번호:"+ orderNo);
		try {
			if (session.getAttribute("member") == null || !((Member)session.getAttribute("member")).getMemberId().equals("admin")) {
				Alert alert = new Alert("/", "접근권한이 없습니다.");
				mv.addObject("alert", alert).setViewName("common/alert");
			} else {
				List<AdOrder> orderList = oService.selectOneByNo(orderNo);
				System.out.println(orderList);
				mv.addObject("orderList", orderList);
				mv.setViewName("admin/order/detail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", e.getMessage()).setViewName("common/error");
		}
		return mv;
	}
	
}
