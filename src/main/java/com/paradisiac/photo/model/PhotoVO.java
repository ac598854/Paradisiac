package com.paradisiac.photo.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "photo")
public class PhotoVO implements java.io.Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)//自增主鍵
	@Column(name = "photo_no")	
	private Integer photoNo;
		
	@Column(name = "alb_no")
	private Integer albNo;
	
	@Column(name = "photo_name")
	private String photoName;
	
	@Column(name = "photo", columnDefinition = "mediumblobtext")
	private byte[] photo;
	
	@Column(name = "photo_date", columnDefinition = "datetime")
	private Date photoDate;
	
	public PhotoVO() {
		
	}
	
	public PhotoVO(Integer albNo, Date photoDate){
		this.albNo = albNo;
		this.photoDate = photoDate;
	}
	
	public Integer getPhotoNo() {
		return photoNo;
	}

	public void setPhotoNo(Integer photoNo) {
		this.photoNo = photoNo;
	}

	public Integer getAlbNo() {
		return albNo;
	}

	public void setAlbNo(Integer albNo) {
		this.albNo = albNo;
	}

	public String getPhotoName() {
		return photoName;
	}

	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		System.out.println("VO:call setPhoto()===================");
		this.photo = photo;
		
	}

	public Date getPhotoDate() {
		return photoDate;
	}

	public void setPhotoDate(Date photoDate) {
		this.photoDate = photoDate;
	}


	


}
