package com.paradisiac.roomtype.service;

import static com.paradisiac.util.Constants.PAGE_MAX_RESULT;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.paradisiac.roomtype.model.RoomTypeDAO;
import com.paradisiac.roomtype.model.RoomTypeDAOImpl;
import com.paradisiac.roomtype.model.RoomTypeVO;

public class RoomTypeServiceImpl implements RoomTypeService{
	private RoomTypeDAO dao;
	@Override
	public RoomTypeVO addRoomTypeVO(RoomTypeVO rtvo) {
		dao.insert(rtvo);
		return null;
	}

	public RoomTypeServiceImpl() {
		dao = new RoomTypeDAOImpl();
	}

	@Override
	public RoomTypeVO updateRoomTypeVO(RoomTypeVO rtvo) {
		dao.update(rtvo);
		return null;
	}

	@Override
	public void deleteRoomTypeVO(Integer rtvono) {
		dao.delete(rtvono);
		
	}

	@Override
	public RoomTypeVO getOneRoomType(Integer rtvono) {
		
		return dao.getByteId(rtvono);
	}
	/*
	 * @Override public List<RoomTypeVO> getAllRoomTypeVOs(int currentPage) {
	 * System.out.print("Service: call --> getAll()"); return
	 * dao.getAll(currentPage); }
	 */
	@Override
	public List<RoomTypeVO> getAll() {
		
		return dao.getAll();
	}

	@Override
	public List<RoomTypeVO> getAllRoomTypeVOs(int currentPage) {
		// TODO Auto-generated method stub
		return dao.getAll(currentPage); }
	
	@Override
	public int getPageTotal() {
		long total = dao.getTotal();
		int pageQty = (int)(total % PAGE_MAX_RESULT == 0 ? (total / PAGE_MAX_RESULT) : (total / PAGE_MAX_RESULT + 1));
		return pageQty;
	}

	@Override
	public List<RoomTypeVO> getRoomTypeVOsByCompositeQuery(Map<String, String[]> map) {
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
			String value = row.getValue()[0]; // getValue拿到一個String陣列, 接著[0]取得第一個元素檢查
			if (value == null || value.isEmpty()) {
				continue;
			}
			query.put(key, value);
		}
		
		System.out.println(query);
		
		return dao.getByCompositeQuery(query);
	}

	@Override
	public Integer getTotal(int roomTypeNo) {
		
		return dao.getTotal(roomTypeNo);
	}

	

	

}
