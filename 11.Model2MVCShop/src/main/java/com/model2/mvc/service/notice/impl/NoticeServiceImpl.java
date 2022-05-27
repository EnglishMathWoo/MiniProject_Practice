package com.model2.mvc.service.notice.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.Notice;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.notice.NoticeDao;
import com.model2.mvc.service.notice.NoticeService;


@Service("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService{
	
	///Field
	@Autowired
	@Qualifier("noticeDaoImpl")
	private NoticeDao noticeDao;

	
	/// Constructor
	public NoticeServiceImpl() {
		System.out.println(this.getClass());
	}


	///Method
	public void addNotice(Notice notice) throws Exception {
		noticeDao.insertNotice(notice);
	}
	
	public Notice getNotice(int noticeNo) throws Exception {
		return noticeDao.findNotice(noticeNo);
	}

	//생성쿠폰리스트 검색
	public Map<String , Object > getNoticeList(Search search) throws Exception {
		List<Coupon> list= noticeDao.getNoticeList(search);
		int totalCount = noticeDao.getNoticeTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	//updateNotice
	public void updateNotice(Notice notice) throws Exception{
		noticeDao.updateNotice(notice);
	}
		
	//deleteNotice
	public void deleteNotice(int noticeNo) throws Exception{
		noticeDao.deleteNotice(noticeNo);
	};
}