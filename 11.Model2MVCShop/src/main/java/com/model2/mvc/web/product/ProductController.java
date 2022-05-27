package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['filepath']}")
	private String FILE_SERVER_PATH;
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	///Constructor
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping( value="/addProduct", method=RequestMethod.POST )
	public String addProduct( @ModelAttribute("product") Product product, Model model, 
							@RequestParam("uploadFile") List<MultipartFile> multiFileList ) throws IOException, Exception {

		System.out.println("/product/addProduct : POST");
		
		System.out.println(product);
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		//FileUpload
		List<String> fileList = new ArrayList<String>();
		String fileName = "";
		
		if(multiFileList.size() != 0) {
			for(MultipartFile mf : multiFileList) {
				fileList.add(mf.getOriginalFilename());
				mf.transferTo(new File(FILE_SERVER_PATH, mf.getOriginalFilename()));
			}
				
			for(int i=0; i<fileList.size(); i++) {
				if(i==fileList.size()-1) {
					fileName += fileList.get(i);
				} else {
					fileName += fileList.get(i)+"/";
				}
			}
			product.setFileName(fileName);
		}
		
		if(fileList != null) {
			String[] listFile = fileName.split("/");			
			model.addAttribute("listFile", listFile);
		}
		
		//Business Logic
		productService.addProduct(product);
		
		return "forward:/product/listProduct?menu=manage";
	}

	
	@RequestMapping(value="/getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model, 
			@CookieValue(value = "history", required = false) Cookie cookie, HttpServletResponse response) throws Exception {
		
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		if(product.getFileName() != null) {
			String[] fileList = product.getFileName().split("/");
			model.addAttribute("fileList", fileList);
		}
		
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		String history = Integer.toString(prodNo) + "/" + product.getProdName();

		///최근 본 상품
		if(cookie == null) {
			cookie = new Cookie("history", history);
			System.out.println(cookie.getValue());
		} else {
			history = history + "/" + cookie.getValue();
			cookie.setValue(history);
			System.out.println(cookie.getValue());
		}
		
		cookie.setPath("/");
		response.addCookie(cookie);

		return "forward:/product/getProduct.jsp";
	}
	
	
	@RequestMapping( value="/updateProduct", method=RequestMethod.GET )
	public String updateProductView( @RequestParam("prodNo") int prodNo, Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	
	@RequestMapping( value="/updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product,
								@RequestParam("uploadFile") List<MultipartFile> multiFileList ) throws IOException, Exception{

		System.out.println("/product/updateProduct : POST");
		
		System.out.println(product);
		
		int prodNo= product.getProdNo();
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		//FileUpload
		List<String> fileList = new ArrayList<String>();
		String fileName = "";
		
		if(multiFileList.size() != 0) {
			for(MultipartFile mf : multiFileList) {
				fileList.add(mf.getOriginalFilename());
				mf.transferTo(new File(FILE_SERVER_PATH, mf.getOriginalFilename()));
			}
				
			for(int i=0; i<fileList.size(); i++) {
				if(i==fileList.size()-1) {
					fileName += fileList.get(i);
				} else {
				fileName += fileList.get(i)+"/";
				}
			}
				
			product.setFileName(fileName);
		
		}
			
		//Business Logic
		productService.updateProduct(product);
		
		return "redirect:/product/getProduct?prodNo="+prodNo;
	}

	
	@RequestMapping("/listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model, HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/listProduct");
			
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		if( request.getParameter("menu") != null) {
			session.setAttribute("menu", request.getParameter("menu"));
		} else {
			session.getAttribute("menu");
		}

		System.out.println(map.get("list"));
		
		return "forward:/product/listProduct.jsp";
	}

}