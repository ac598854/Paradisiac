package com.paradisiac.roomZ.roompicture.dao;

import java.util.List;

import com.paradisiac.roomZ.roompicture.entity.RoomPictureeVO;

public interface RoomPictureDAO {
	int insert(RoomPictureeVO roomPictureVO);
	int update(RoomPictureeVO roomPictureVO);
	RoomPictureeVO findByPrimaryKey(Integer roomPictureVO);
	
	List<RoomPictureeVO> getAll();
}
