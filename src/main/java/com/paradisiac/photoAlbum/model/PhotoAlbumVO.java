package com.paradisiac.photoAlbum.model;

import java.sql.Blob;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "photo_album")
//@NamedQuery(name = "getAllEmps", query = "from Emp where empno > :empno order by empno desc")
public class PhotoAlbumVO implements java.io.Serializable{
	@Id
	@Column(name = "alb_no")
	private Integer albNo;
	
	@Column(name = "mem_no")
	private Integer memNo;
	
	@Column(name = "alb_name")
	private String albName;

	//private Blob albPhoto;
	// 因為 byte[] 會被 hibernate 視為 tinyblob 型別，所以跟DB裡的 longblob 不符，
	//所以用 columnDefinition 定義
	@Column(name = "alb_photo", columnDefinition = "mediumblobtext")
	private byte[] albPhoto;
	
	@Column(name = "alb_date")
	private Date albDate;
	
	public PhotoAlbumVO() {
		super();
	}
	//以下為小吳搭配TestHQLQueryProperty.java才會用到的建構子
	public PhotoAlbumVO(Integer albNo, Integer memNo, String albName, byte[] albPhoto, Date albDate) {
		super();
		this.albNo = albNo;
		this.memNo = memNo;
		this.albName = albName;
		this.albPhoto = albPhoto;
		this.albDate = albDate;
	}

	public Integer getAlbNo() {
		return albNo;
	}
	public void setAlbNo(Integer albNo) {
		this.albNo = albNo;
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
