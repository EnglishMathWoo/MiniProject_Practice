package com.model2.mvc.web.notice;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.notice.NoticeService;
import com.model2.mvc.service.user.UserService;


//==> 쿠폰 Controller
@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	///Field
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
		
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	///Constructor
	public NoticeController(){
		System.out.println(this.getClass());
	}
	
	///Method
	@RequestMapping( value="addNotice", method=RequestMethod.POST )
	public String addCoupon(@ModelAttribute("notice") Notice notice) throws Exception{

		System.out.println("/notice/addNotice : POST");
		
		//Business Logic
		System.out.println(notice);
		noticeService.addNotice(notice);
		
		return "forward:/notice/addNotice.jsp";
	}
	
	@RequestMapping(value="/getNotice", method=RequestMethod.GET)
	public String getNotice( @RequestParam("noticeNo") int noticeNo , Model model, HttpServletResponse response) throws Exception {
		
		
		System.out.println("/notice/getNotice : GET");
		//Business Logic
		Notice notice = noticeService.getNotice(noticeNo);
		
		// Model 과 View 연결
		model.addAttribute("notice", notice);
	
		return "forward:/notice/getNotice.jsp";
	}
	
	@RequestMapping("/listNotice")
	public String listProduct( @ModelAttribute("search") Search search , @RequestParam("menu") String menu, Model model) throws Exception{
		
		System.out.println("/listNotice");
			
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	
		// Business logic 수행
		Map<String , Object> map = noticeService.getNoticeList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/notice/listNotice.jsp";
	}
	
	@RequestMapping( value="/updateNotice", method=RequestMethod.GET )
	public String updateNoticeView( @RequestParam("noticeNo") int noticeNo, Model model ) throws Exception{

		System.out.println("/notice/updateNotice : GET");
		//Business Logic
		Notice notice = noticeService.getNotice(noticeNo);
		System.out.println(notice.getNoticeTitle());
		// Model 과 View 연결
		model.addAttribute("notice", notice);
		
		return "forward:/notice/updateNotice.jsp";
	}
	
	
	@RequestMapping( value="/updateNotice", method=RequestMethod.POST )
	public String updateNotice( @ModelAttribute("notice") Notice notice) throws Exception{

		System.out.println("/notice/updateNotice : POST");
		
		System.out.println(notice);
		System.out.println(notice.getNoticeNo());
						
		//Business Logic
		noticeService.updateNotice(notice);
		
		return "redirect:/notice/getNotice?noticeNo="+notice.getNoticeNo();
	}
	
	@RequestMapping( value="/deleteNotice", method=RequestMethod.GET)
	public String deleteNotice( @RequestParam("noticeNo") int noticeNo ) throws Exception{

		System.out.println("/notice/deleteNotice : GET");
		
		//Business Logic
		noticeService.deleteNotice(noticeNo);

		return "forward:/notice/listNotice?menu=manage";
	}
	
}