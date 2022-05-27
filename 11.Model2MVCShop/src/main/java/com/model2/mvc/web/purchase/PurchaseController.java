package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.coupon.CouponService;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("couponServiceImpl")
	private CouponService couponService;
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="/addPurchase", method=RequestMethod.GET )
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo, HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchase : GET");
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		User user = (User)session.getAttribute("user");
		List<Coupon> coupon = couponService.getUsableCoupon(user.getUserId());
			
		//M/V 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject("product", product);
		modelAndView.addObject("coupon", coupon);
		
	    System.out.println(coupon);
				
		return modelAndView;
	}
	
	@RequestMapping(value="/addPurchase", method=RequestMethod.POST )
	public ModelAndView addPurchase( @ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") int prodNo,
			HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchase : POST");
				
		//Business Logic
		Product product = productService.getProduct(prodNo);
		purchase.setPurchaseProd(product);
		User user = (User)session.getAttribute("user");
		purchase.setBuyer(user);
		purchase.setTranCode("구매완료");
		purchaseService.addPurchase(purchase);
		
		//M/V 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("product", product);
		
		System.out.println(purchase);

		return modelAndView;
	}
	
	@RequestMapping(value="/getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase( @RequestParam("tranNo") int tranNo ) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		
		System.out.println(purchase);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	@RequestMapping( value="/updatePurchase", method=RequestMethod.GET)
	public ModelAndView updatePurchaseView( @RequestParam("tranNo") int tranNo ) throws Exception{

		System.out.println("/purchase/updatePurchase : GET");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updatePurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}

	
	@RequestMapping( value="/updatePurchase", method=RequestMethod.POST)
	public ModelAndView updatePurchase( @ModelAttribute("purchase") Purchase purchase ) throws Exception{

		System.out.println("/purchase/updatePurchase : POST");
		
		System.out.println(purchase);
		
		//Business Logic
		purchaseService.updatePurchase(purchase);

		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo());
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping( value="/updateTranCode", method=RequestMethod.GET)
	public ModelAndView updateTranCode( @RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode,
			@RequestParam("currentPage") int currentPage, @RequestParam("menu") String menu) throws Exception{

		System.out.println("/purchase/updateTranCode : GET");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);


		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		if( menu.equals("search")) {
			modelAndView.setViewName("redirect:/purchase/listPurchase?currentPage="+currentPage);
		} else {
			modelAndView.setViewName("redirect:/purchase/listSale?currentPage="+currentPage);
		}
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	

	@RequestMapping("/listSale")
	public ModelAndView listSale( @ModelAttribute("search") Search search, HttpServletRequest request ) throws Exception{

		System.out.println("/listSale");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listSale.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}

	
	@RequestMapping("/listPurchase")
	public ModelAndView listPurchase( @ModelAttribute("search") Search search, HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/listPurchase");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		String buyer = ((User)session.getAttribute("user")).getUserId();
		Map<String , Object> map = purchaseService.getPurchaseList(search, buyer);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}

}