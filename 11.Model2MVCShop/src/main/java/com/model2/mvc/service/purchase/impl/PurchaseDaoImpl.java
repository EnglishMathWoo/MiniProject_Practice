package com.model2.mvc.service.purchase.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.dao.PurchaseDAO;


@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDAO {

	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/// Constructor
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}

	/// Method
	/// insertPurchase Method
	public void insertPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}

	/// findPurchase Method
	public Purchase findPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.findPurchase", tranNo);
	}

	/// getPurchaseList Method
	public List<Purchase> getPurchaseList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}
	
	/// getSaleList Method
	public List<Purchase> getSaleList(Search search) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}

	/// updatePurchase Method
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}
	
	/// updateTranCode Method
	public void updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	// 게시판 Page 처리를 위한 전체 Row(totalCount) return
	public int getPurchaseTotalCount(String buyer) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchaseTotalCount", buyer);
	}
	
	public int getSaleTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getSaleTotalCount", search);
	}
}