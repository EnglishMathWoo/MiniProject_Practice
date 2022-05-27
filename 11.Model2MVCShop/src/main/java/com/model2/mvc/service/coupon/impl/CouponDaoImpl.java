package com.model2.mvc.service.coupon.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.coupon.CouponDao;
import com.model2.mvc.service.domain.Coupon;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.dao.PurchaseDAO;


@Repository("couponDaoImpl")
public class CouponDaoImpl implements CouponDao {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/// Constructor
	public CouponDaoImpl() {
		System.out.println(this.getClass());
	}

	/// Method
	/// insertCoupon Method
	public void insertCoupon(Coupon coupon) throws Exception {
		sqlSession.insert("CouponMapper.addCoupon", coupon);
	}
	
	/// insertCoupon Method
	public void issueCoupon(Coupon coupon) throws Exception {
		sqlSession.insert("CouponHolderMapper.issueCoupon", coupon);
	}
	
	/// findCoupon Method
	public List<Coupon> findCoupon() throws Exception {
		return sqlSession.selectList("CouponMapper.findCoupon");
	}
	
	/// findUsableCoupon Method
	public List<Coupon> findUsableCoupon(String userId) throws Exception {
		return sqlSession.selectList("CouponHolderMapper.findUsableCoupon", userId);
	}
	
	/// findIssuedCoupon Method
	public Coupon findIssuedCoupon(int issueNo) throws Exception {
		return sqlSession.selectOne("CouponHolderMapper.findIssuedCoupon", issueNo);
	}
	
	public List<Coupon> getCouponList(Search search) throws Exception {
		return sqlSession.selectList("CouponMapper.getCouponList", search);
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("CouponMapper.getTotalCount", search);
	}
	
	public List<Coupon> getIssuedCouponList(Search search) throws Exception {
		return sqlSession.selectList("CouponHolderMapper.getIssuedCouponList", search);
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getIssuedTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("CouponHolderMapper.getTotalCount", search);
	}
	
	/// updateProduct Method
	public void updateIssueStatus(Coupon coupon) throws Exception {
		sqlSession.update("CouponHolderMapper.updateIssueStatus", coupon);
	}
	
	//쿠폰삭제
	public void deleteCoupon(int couponNo) throws Exception{
		sqlSession.delete("CouponMapper.deleteCoupon", couponNo);
	};
}