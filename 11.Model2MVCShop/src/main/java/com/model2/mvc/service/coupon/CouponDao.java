package com.model2.mvc.service.coupon;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Coupon;


public interface CouponDao{
	
	//쿠폰생성
	public void insertCoupon(Coupon coupon) throws Exception;

	//쿠폰지급
	public void issueCoupon(Coupon coupon) throws Exception;
	
	//쿠폰검색
	public List<Coupon> findCoupon() throws Exception;
	
	//발행쿠폰검색
	public Coupon findIssuedCoupon(int issueNo) throws Exception;
	
	//가용쿠폰검색
	public List<Coupon> findUsableCoupon(String userId) throws Exception;
	
	// 생성쿠폰리스트
	public List<Coupon> getCouponList(Search search) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	// 생성쿠폰리스트
	public List<Coupon> getIssuedCouponList(Search search) throws Exception ;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getIssuedTotalCount(Search search) throws Exception ;
	
	//쿠폰상태변경
	public void updateIssueStatus(Coupon coupon) throws Exception;
	
	//쿠폰삭제
	public void deleteCoupon(int couponNo) throws Exception;
}