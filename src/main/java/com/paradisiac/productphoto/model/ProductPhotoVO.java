package com.paradisiac.productphoto.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product_photo")
public class ProductPhotoVO {
	
	@Column(name = "product_photo_no")
	private Integer photono;
	@Id
	@Column(name = "product_no")
	private Integer productno;
	
	@Column(name = "product_photo", columnDefinition = "mediumblob")
	private byte[] picture;

	public Integer getPhotono() {
		return photono;
	}

	public void setPhotono(Integer photono) {
		this.photono = photono;
	}

	public Integer getProductno() {
		return productno;
	}

	public void setProductno(Integer productno) {
		this.productno = productno;
	}

	public byte[] getPicture() {
		return picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}
	@Override
	public String toString() {
		return "商品編號="+productno+",相片編號="+photono+",相片"+picture;
	}
	
	

}
