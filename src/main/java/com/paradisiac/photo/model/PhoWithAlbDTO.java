package com.paradisiac.photo.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "phowithalb")
public class PhoWithAlbDTO {
	
	@Id
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
	
	@Column(name = "mem_no")
	private Integer memNo;
	
	@Column(name = "alb_name")
	private String albName;
	
	@Column(name = "alb_photo", columnDefinition = "mediumblobtext")
	private byte[] albPhoto;
	
	@Column(name = "alb_date")
	private Date albDate;
	
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
		this.photo = photo;
	}

	public Date getPhotoDate() {
		return photoDate;
	}

	public void setPhotoDate(Date photoDate) {
		this.photoDate = photoDate;
	}

	public Integer getMemNo() {
		return memNo;
	}

	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
	}

	public String getAlbName() {
		return albName;
	}

	public void setAlbName(String albName) {
		this.albName = albName;
	}

	public byte[] getAlbPhoto() {
		return albPhoto;
	}

	public void setAlbPhoto(byte[] albPhoto) {
		this.albPhoto = albPhoto;
	}

	public Date getAlbDate() {
		return albDate;
	}

	public void setAlbDate(Date albDate) {
		this.albDate = albDate;
	}


	
	
}
