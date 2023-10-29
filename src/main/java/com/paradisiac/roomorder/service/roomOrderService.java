package com.paradisiac.roomorder.service;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomorder.entity.roomOrderVO;

public interface roomOrderService {
	   roomOrderVO addOrd(roomOrderVO roomordervo);


	   roomOrderVO updateOrd(roomOrderVO roomordervo);
		
		void deleteOrd(Integer roomOrderNo);
		
		roomOrderVO getOrdByOrdno(Integer roomOrderNo);
		
		List<roomOrderVO> getAllOrds(int currentPage);
		
		int getPageTotal();
		
		List<roomOrderVO> getOrdsByCompositeQuery(Map<String, String[]> map);
	}
