package com.paradisiac.roomtype.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.paradisiac.roompicture.model.RoomPictureVO;

@Entity
@Table(name = "room_type")
public class RoomTypeVO {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "room_type_no", updatable = false)
	private Integer roomTypeno;
	
	@Column(name = "room_name")
	private String roomName;
	
	@Column(name = "rtype")
	private String rType;
	
	@Column(name = "room_total")
	private Integer roomTotal;
	
	@Column(name = "price")
	private Integer price;
	
	@Column(name = "normal_price")
	private Integer normalPrice;
	
	@Column(name = "holiday_price")
	private Integer holidayPrice;
	
	@Column(name = "bridge_holiday_price")
	private Integer bridgeHolidayprice;
	
	@Column(name = "notice")
	private String notice;
	
	@Column(name = "facility")
	private String facility;
	
	@Column(name = "r_type_status",columnDefinition = "bit")
	private Byte rTypestatus;

	public RoomTypeVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RoomTypeVO(Integer roomTypeno, String roomName, String rType, Integer roomTotal, Integer price,
			Integer normalPrice, Integer holidayPrice, Integer bridgeHolidayprice, String notice, String facility,
			Byte rTypestatus) {
		super();
		this.roomTypeno = roomTypeno;
		this.roomName = roomName;
		this.rType = rType;
		this.roomTotal = roomTotal;
		this.price = price;
		this.normalPrice = normalPrice;
		this.holidayPrice = holidayPrice;
		this.bridgeHolidayprice = bridgeHolidayprice;
		this.notice = notice;
		this.facility = facility;
		this.rTypestatus = rTypestatus;
	}

	public Integer getRoomTypeno() {
		return roomTypeno;
	}

	public void setRoomTypeno(Integer roomTypeno) {
		this.roomTypeno = roomTypeno;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getrType() {
		return rType;
	}

	public void setrType(String rType) {
		this.rType = rType;
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

	public Integer getBridgeHolidayprice() {
		return bridgeHolidayprice;
	}

	public void setBridgeHolidayprice(Integer bridgeHolidayprice) {
		this.bridgeHolidayprice = bridgeHolidayprice;
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

	public Byte getrTypestatus() {
		return rTypestatus;
	}

	public void setrTypestatus(Byte rTypestatus) {
		this.rTypestatus = rTypestatus;
	}

	@Override
	public String toString() {
		return "RoomTypeVO [roomTypeno=" + roomTypeno + ", roomName=" + roomName + ", rType=" + rType + ", roomTotal="
				+ roomTotal + ", price=" + price + ", normalPrice=" + normalPrice + ", holidayPrice=" + holidayPrice
				+ ", bridgeHolidayprice=" + bridgeHolidayprice + ", notice=" + notice + ", facility=" + facility
				+ ", rTypestatus=" + rTypestatus + "]";
	}
	
		


}
