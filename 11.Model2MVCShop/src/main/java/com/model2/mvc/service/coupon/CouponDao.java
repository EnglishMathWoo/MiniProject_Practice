package com.model2.mvc.service.coupon;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Coupon;


public interface CouponDao{
	
	//��������
	public void insertCoupon(Coupon coupon) throws Exception;

	//��������
	public void issueCoupon(Coupon coupon) throws Exception;
	
	//�����˻�
	public List<Coupon> findCoupon() throws Exception;
	
	//���������˻�
	public Coupon findIssuedCoupon(int issueNo) throws Exception;
	
	//���������˻�
	public List<Coupon> findUsableCoupon(String userId) throws Exception;
	
	// ������������Ʈ
	public List<Coupon> getCouponList(Search search) throws Exception;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	// ������������Ʈ
	public List<Coupon> getIssuedCouponList(Search search) throws Exception ;
	
	// �Խ��� Page ó���� ���� ��üRow(totalCount)  return
	public int getIssuedTotalCount(Search search) throws Exception ;
	
	//�������º���
	public void updateIssueStatus(Coupon coupon) throws Exception;
	
	//��������
	public void deleteCoupon(int couponNo) throws Exception;
}