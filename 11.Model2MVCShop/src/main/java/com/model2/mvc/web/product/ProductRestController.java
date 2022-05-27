package com.model2.mvc.web.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		
		Product product = productService.getProduct(prodNo);
			
		return product;
	}
	

	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Product addProduct( @RequestBody Product product ) throws Exception{
		
		System.out.println("/product/json/addProduct : POST");
		
		//Business Logic
		productService.addProduct(product);
		
		return product;
	}
	
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public Product updateProduct( @RequestBody Product product ) throws Exception{
		
		System.out.println("/product/json/updateProduct : POST");
		
		//Business Logic
		productService.updateProduct(product);
		
		return productService.getProduct(product.getProdNo());
	}
	
	
	@RequestMapping( value="json/listProduct", method=RequestMethod.POST )
	public Map<String, Object> listProduct( @RequestBody Search search ) throws Exception{

		System.out.println("/product/json/listProduct : POST");
		
		//Business Logic
		System.out.println(search);
		search.setPageSize(pageSize);
		Map<String, Object> map = productService.getProductList(search);
		System.out.println(map.get("list"));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, search.getPageSize());
		
		map.put("resultPage", resultPage);
		
		return map;
	}
}