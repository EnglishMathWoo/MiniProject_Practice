package com.model2.mvc.service.coupon.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.dao.PurchaseDAO;
import com.model2.mvc.service.coupon.CouponDao;
import com.model2.mvc.service.coupon.CouponService;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;


@Service("couponServiceImpl")
public class CouponServiceImpl implements CouponService{
	
	///Field
	@Autowired
	@Qualifier("couponDaoImpl")
	private CouponDao couponDao;

	
	/// Constructor
	public CouponServiceImpl() {
		System.out.println(this.getClass());
	}


	///Method
	public void addCoupon(Coupon coupon) throws Exception {
		couponDao.insertCoupon(coupon);
	}
	
	//쿠폰지급
	public void issueCoupon(Coupon coupon) throws Exception{
		couponDao.issueCoupon(coupon);
	};
	
	//쿠폰검색
	public List<Coupon> getCoupon() throws Exception {
		
		List<Coupon> couponList = couponDao.findCoupon();
		
		System.out.println(couponList);
		
		return couponList;
	}
	
	//발행쿠폰검색
	public Coupon getIssuedCoupon(int issueNo) throws Exception {
		
		Coupon issuedCoupon = couponDao.findIssuedCoupon(issueNo);
		
		System.out.println(issuedCoupon);
		
		return issuedCoupon;
	}
	
	//가용쿠폰검색
	public List<Coupon> getUsableCoupon(String userId) throws Exception {
		
		List<Coupon> couponList = couponDao.findUsableCoupon(userId);
		
		System.out.println(couponList);
		
		return couponList;
	}
	
	
	//생성쿠폰리스트 검색
	public Map<String , Object > getCouponList(Search search) throws Exception {
		List<Coupon> list= couponDao.getCouponList(search);
		int totalCount = couponDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	//발급쿠폰리스트 검색
	public Map<String , Object > getIssuedCouponList(Search search) throws Exception {
		List<Coupon> list= couponDao.getIssuedCouponList(search);
		int totalCount = couponDao.getIssuedTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	//쿠폰상태변경
	public void updateIssueStatus(Coupon coupon) throws Exception{
		couponDao.updateIssueStatus(coupon);
	}
	
	// 쿠폰삭제
	public void deleteCoupon(int couponNo) throws Exception{
		couponDao.deleteCoupon(couponNo);
	};
	
}