package com.model2.mvc.service.domain;

import java.sql.Date;
import com.model2.mvc.service.domain.User;

public class Coupon {
 
	private int couponNo;
	private int issueNo;
    private String couponStatus;
    private String issueStatus;
    private Date endDate;
	private Date startDate;
    private double discountRate;
    private int discountValue;
    private User couponUser;
    private String couponName;
    
    
	public int getCouponNo() {
		return couponNo;
	}
	public void setCouponNo(int couponNo) {
		this.couponNo = couponNo;
	}
	public int getIssueNo() {
		return issueNo;
	}
	public void setIssueNo(int issueNo) {
		this.issueNo = issueNo;
	}
	public String getCouponStatus() {
		return couponStatus;
	}
	public void setCouponStatus(String couponStatus) {
		this.couponStatus = couponStatus;
	}
	public String getIssueStatus() {
		return issueStatus;
	}
	public void setIssueStatus(String issueStatus) {
		this.issueStatus = issueStatus;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(double discountRate) {
		this.discountRate = discountRate;
	}
	public int getDiscountValue() {
		return discountValue;
	}
	public void setDiscountValue(int discountValue) {
		this.discountValue = discountValue;
	}
	public User getCouponUser() {
		return couponUser;
	}
	public void setCouponUser(User couponUser) {
		this.couponUser = couponUser;
	}
	public String getCouponName() {
		return couponName;
	}
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	
	public String toString() {
		return "coupon : [couponName]" + couponName +" [couponNo]" + couponNo;
	}
    
}