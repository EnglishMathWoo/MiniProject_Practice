package com.model2.mvc.service.purchase.dao;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;


public interface PurchaseDAO {
		
	public void insertPurchase(Purchase purchase) throws Exception;
		
	public Purchase findPurchase(int tranNo) throws Exception;
	
	public List<Purchase> getPurchaseList(Map<String, Object> map) throws Exception;
	
	public List<Purchase> getSaleList(Search search) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getPurchaseTotalCount(String buyer) throws Exception;
	
	public int getSaleTotalCount(Search serch) throws Exception;
}