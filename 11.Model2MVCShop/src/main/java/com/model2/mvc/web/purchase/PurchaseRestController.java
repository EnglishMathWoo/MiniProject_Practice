package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception{
		
		System.out.println("/purchase/json/getPurchase : GET");
		
		return purchaseService.getPurchase(tranNo);
	}
	
	
	@RequestMapping( value="json/addPurchase", method=RequestMethod.POST )
	public Purchase addPurchase( @RequestBody Purchase purchase ) throws Exception{
		
		System.out.println("/purchase/json/addPurchase : POST");
		
		//Business Logic
		purchaseService.addPurchase(purchase);
		
		return purchase;
	}
	
	
	@RequestMapping( value="json/updateTranCode/{tranNo}/{tranCode}", method=RequestMethod.GET )
	public Purchase updateTranCode( @PathVariable int tranNo,  @PathVariable String tranCode ) throws Exception{
		
		System.out.println("/purchase/json/updateTranCode : GET");
		
		//Business Logic
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		return purchaseService.getPurchase(tranNo);
	}
	
	
	@RequestMapping( value="json/updatePurchase", method=RequestMethod.POST )
	public Purchase updatePurchase( @RequestBody Purchase purchase ) throws Exception{
		
		System.out.println("/purchase/json/updatePurchase : POST");
		
		//Business Logic
		purchaseService.updatePurchase(purchase);
		
		return purchaseService.getPurchase(purchase.getTranNo());
	}
	
	
	@RequestMapping( value="json/listPurchase/{buyer}", method=RequestMethod.POST )
	public Map<String, Object> listPurchase( @RequestBody Search search, @PathVariable String buyer ) throws Exception{

		System.out.println("/purchase/json/listProduct : POST");
		
		//Business Logic
		System.out.println(search);
		search.setPageSize(pageSize);
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyer);
		System.out.println(map.get("list"));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, search.getPageSize());
		
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	@RequestMapping( value="json/listSale", method=RequestMethod.POST )
	public Map<String, Object> listSale( @RequestBody Search search ) throws Exception{

		System.out.println("/purchase/json/listSale : POST");
		
		//Business Logic
		System.out.println(search);
		search.setPageSize(pageSize);
		Map<String, Object> map = purchaseService.getSaleList(search);
		System.out.println(map.get("list"));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, search.getPageSize());
		
		map.put("resultPage", resultPage);
		
		return map;
	}
	
	
}