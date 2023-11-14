package com.paradisiac.roomZ.roomtype.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "room_type")
public class RoomTypeeVO {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "room_type_no")
	private Integer roomTypeNo;
	@Column(name = "room_name")
	private String roomName;
	@Column(name = "rtype")
	private String rtype;
	@Column(name = "room_total")
	private Integer roomTotal;
	@Column(name = "price")
	private Integer price;
	@Column(name = "normal_price")
	private Integer normalPrice;
	@Column(name = "holiday_price")
	private Integer holidayPrice;
	@Column(name = "bridge_holiday_price")
	private Integer bridgeHolidayPrice;
	@Column(name = "notice")
	private String notice;
	@Column(name = "facility")
	private String facility;
	@Column(name = "r_type_status")
	private boolean rTypeStatus;
	


	public Integer getRoomTypeNo() {
		return roomTypeNo;
	}
	public void setRoomTypeNo(Integer roomTypeNo) {
		this.roomTypeNo = roomTypeNo;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getRtype() {
		return rtype;
	}
	public void setRtype(String rtype) {
		this.rtype = rtype;
	}
	public Integer getRoomTotal() {
		return roomTotal;
	}
	public void setRoomTotal(Integer roomTotal) {
		this.roomTotal = roomTotal;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public Integer getNormalPrice() {
		return normalPrice;
	}
	public void setNormalPrice(Integer normalPrice) {
		this.normalPrice = normalPrice;
	}
	public Integer getHolidayPrice() {
		return holidayPrice;
	}
	public void setHolidayPrice(Integer holidayPrice) {
		this.holidayPrice = holidayPrice;
	}
	public Integer getBridgeHolidayPrice() {
		return bridgeHolidayPrice;
	}
	public void setBridgeHolidayPrice(Integer bridgeHolidayPrice) {
		this.bridgeHolidayPrice = bridgeHolidayPrice;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getFacility() {
		return facility;
	}
	public void setFacility(String facility) {
		this.facility = facility;
	}
	public boolean isrTypeStatus() {
		return rTypeStatus;
	}
	public void setrTypeStatus(boolean rTypeStatus) {
		this.rTypeStatus = rTypeStatus;
	}
	
	
}

