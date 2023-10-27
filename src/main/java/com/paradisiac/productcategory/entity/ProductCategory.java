package com.paradisiac.productcategory.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product_category")
public class ProductCategory {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "product_category_no", updatable = false)
	private Integer product_category_no;
	
	@Column(name = "product_category_name")
	private String product_category_name;
	
	@Column(name = "product_category_desc")
	private String product_category_desc;

	public Integer getProduct_category_no() {
		return product_category_no;
	}

	public void setProduct_category_no(Integer product_category_no) {
		this.product_category_no = product_category_no;
	}

	public String getProduct_category_name() {
		return product_category_name;
	}

	public void setProduct_category_name(String product_category_name) {
		this.product_category_name = product_category_name;
	}

	public String getProduct_category_desc() {
		return product_category_desc;
	}

	public void setProduct_category_desc(String product_category_desc) {
		this.product_category_desc = product_category_desc;
	}

	@Override
	public String toString() {
		return "ProductCategory [product_category_no=" + product_category_no + ", product_category_name="
				+ product_category_name + ", product_category_desc=" + product_category_desc + "]";
	}
	
	
}
