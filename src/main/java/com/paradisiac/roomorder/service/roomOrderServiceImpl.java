package com.paradisiac.roomorder.service;

import static  com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.paradisiac.roomorder.dao.roomOrderDAO;
import com.paradisiac.roomorder.dao.roomOrderDAOImpl;
import com.paradisiac.roomorder.entity.roomOrderVO;
import com.paradisiac.util.HibernateUtil;

public class roomOrderServiceImpl implements roomOrderService{
	private roomOrderDAO dao;

	
	public roomOrderServiceImpl() {
		dao = new roomOrderDAOImpl(HibernateUtil.getSessionFactory());
	}
	
	@Override
	public roomOrderVO addOrd(roomOrderVO roomordervo) {
		return null;
		
	}

	@Override
	public roomOrderVO updateOrd(roomOrderVO roomordervo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteOrd(Integer roomOrderNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public roomOrderVO getOrdByOrdno(Integer roomOrderNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<roomOrderVO> getAllOrds(int currentPage) {
		return dao.getAll(currentPage);
	}



	@Override
	public List<roomOrderVO> getOrdsByCompositeQuery(Map<String, String[]> map) {
		Map<String, String> query = new HashMap<>();
		// Map.Entry即代表一組key-value
		Set<Map.Entry<String, String[]>> entry = map.entrySet();
		
		for (Map.Entry<String, String[]> row : entry) {
			String key = row.getKey();
			// 因為請求參數裡包含了action，做個去除動作
			if ("action".equals(key)) {
				continue;
			}
			// 若是value為空即代表沒有查詢條件，做個去除動作
			String value = row.getValue()[0];
			if (value.isEmpty() || value == null) {
				continue;
			}	
			query.put(key, value);
		}
		
		System.out.println(query);
		
		return dao.getByCompositeQuery(query);
	}
	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		// 計算Emp數量每頁3筆的話總共有幾頁
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}
}
