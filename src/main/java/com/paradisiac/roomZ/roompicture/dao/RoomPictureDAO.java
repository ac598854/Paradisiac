package com.paradisiac.roomZ.roompicture.dao;

import java.util.List;

import com.paradisiac.roomZ.roompicture.entity.RoomPictureVO;

public interface RoomPictureDAO {
	int insert(RoomPictureVO roomPictureVO);
	int update(RoomPictureVO roomPictureVO);
	RoomPictureVO findByPrimaryKey(Integer roomPictureVO);
	
	List<RoomPictureVO> getAll();
}
