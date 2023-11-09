package com.paradisiac.photoAlbum.model;

import java.util.List;

import com.paradisiac.photo.model.PhoWithAlbDTO;
import com.paradisiac.photoAlbum.model.PhotoAlbumVO;


//此介面定義對資料庫的相關存取抽象方法
public interface PhotoAlbumDAO_interface {
	
    public int insert(PhotoAlbumVO photoAlbumVO);
    
    public int update(PhotoAlbumVO photoAlbumVO);
    
    public int delete(Integer albNo);
    
    public PhotoAlbumVO findByPrimaryKey(Integer albNo);
    
    public List<PhotoAlbumVO> getAll();
	
    List<PhotoAlbumVO> getAll(int currentPage);
	
	long getTotal();	
	
	//DTO
	public List<PhoWithAlbDTO> searchAllPhoto(Integer albNo, int currentPage);
	
	public int getTotalQty(Integer albNo);

}
