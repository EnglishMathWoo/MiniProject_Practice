package com.model2.mvc.service.coupon;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.User;

import java.util.List;
import java.util.Map;

public interface CouponService {
	
	//쿠폰생성
	public void addCoupon(Coupon coupon) throws Exception;
	
	//쿠폰지급
	public void issueCoupon(Coupon coupon) throws Exception;
	
	//쿠폰검색
	public List<Coupon> getCoupon() throws Exception;
	
	//발행쿠폰검색
	public Coupon getIssuedCoupon(int issueNo) throws Exception;
	
	//가용쿠폰검색
	public List<Coupon> getUsableCoupon(String userId) throws Exception;
	
	// 생성쿠폰리스트 
	public Map<String , Object> getCouponList(Search search) throws Exception;
	
	// 발급쿠폰리스트 
	public Map<String , Object> getIssuedCouponList(Search search) throws Exception;
	
	// 쿠폰상태변경
	public void updateIssueStatus(Coupon coupon) throws Exception;
	
	// 쿠폰삭제
	public void deleteCoupon(int couponNo) throws Exception;
		
}