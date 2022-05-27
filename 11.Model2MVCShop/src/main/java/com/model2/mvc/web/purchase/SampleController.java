package com.model2.mvc.web.purchase;

import com.model2.mvc.service.coupon.CouponService;
import com.model2.mvc.service.coupon.impl.CouponServiceImpl;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.web.purchase.KakaoPay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
 
 
@Controller
public class SampleController {
    
    @Autowired
    private KakaoPay kakaopay;
    
    @Autowired
	@Qualifier("couponServiceImpl")
    private CouponService couponService;
    
    public KakaoPay getKakaopay() {
		return kakaopay;
	}

	public void setKakaopay(KakaoPay kakaopay) {
		this.kakaopay = kakaopay;
	}

	@GetMapping("/kakaoPay")
    public void kakaoPayGet() {
        
    }
    
    @PostMapping("/kakaoPay")
    public String kakaoPay(@ModelAttribute("product") Product product, @ModelAttribute("coupon") Coupon coupon ) {
    	
    	System.out.println("kakaoPay post............................................");
    	
    	System.out.println(coupon);
        
        return "redirect:" + kakaopay.kakaoPayReady(product, coupon);
    }
    
    @GetMapping("/kakaoPaySuccess")
    public void kakaoPaySuccess(@RequestParam("pg_token") String pg_token, @RequestParam("price") String price, 
    		@RequestParam("issueNo") int issueNo, Model model) throws Exception {
    	
    	System.out.println("kakaoPaySuccess get............................................");
    	System.out.println("kakaoPaySuccess pg_token : " + pg_token);
    	System.out.println(issueNo);

    	//CouponService couponService = new CouponServiceImpl();
    	Coupon coupon = couponService.getIssuedCoupon(issueNo);
    	coupon.setIssueStatus("사용완료");
    	couponService.updateIssueStatus(coupon);
    	
    	model.addAttribute("info", kakaopay.kakaoPayInfo(pg_token, price));

    }
    
}