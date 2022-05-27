package com.model2.mvc.web.notice;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.notice.NoticeService;
import com.model2.mvc.service.user.UserService;


//==> ���� Controller
@Controller
@RequestMapping("/notice/*")
public class NoticeRestController {
	
	///Field
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService noticeService;
		
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	///Constructor
	public NoticeRestController(){
		System.out.println(this.getClass());
	}
	
	
	///Method
	@PostMapping(value="/json/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public Map uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		Map map = new HashMap();
		
		String fileRoot = "C:\\summernote_image\\";	//����� �ܺ� ���� ���
		String originalFileName = multipartFile.getOriginalFilename();	//�������� ���ϸ�
		
		System.out.println(originalFileName);
		
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//���� Ȯ����
				
		String savedFileName = UUID.randomUUID() + extension;	//����� ���� ��
		
		System.out.println(savedFileName);
		
		File targetFile = new File(fileRoot + savedFileName);
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//���� ����
			map.put("url", "/summernoteImage/"+savedFileName);
			map.put("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//����� ���� ����
			map.put("responseCode", "error");
			e.printStackTrace();
		}
		
		return map;
	}
	
}