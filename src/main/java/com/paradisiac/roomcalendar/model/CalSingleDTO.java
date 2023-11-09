package com.paradisiac.roomcalendar.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

import org.hibernate.annotations.Immutable;

@Entity
@Immutable // 這資料表對映的是一個view的資料表，此註解是告訢Hibernate這是一個不可變的實體，因此不需要一個可變的標識符
@Table(name = "calsingle")
//指定2個ID，因為view的欄位組成若每欄都會有重覆值，則必須指定雙主鍵(雙主鍵必須能成為唯一值)，否則只會找到多筆重覆的資料
@IdClass(CalSingleDTO.CompositeDetail.class)
public class CalSingleDTO {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "room_type_no")
	private Integer roomTypeNo;
	@Id
	@Column(name = "vdate")
	private Date vDate;

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
	private Integer holiDayPrice;

	@Column(name = "bridge_holiday_price")
	private Integer bridgeHolidayPrice;

	@Column(name = "notice")
	private String notice;

	@Column(name = "facility")
	private String facility;

	@Column(name = "r_type_status",columnDefinition = "bit")
	private byte rTypeStatus;
	
	@Column(name = "rbooking")
	private Long rbooking;
	
	@Column(name = "astatus")
	private String aStatus;

	public CalSingleDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getRoomTypeNo() {
		return roomTypeNo;
	}

	public void setRoomTypeNo(Integer roomTypeNo) {
		this.roomTypeNo = roomTypeNo;
	}

	public Date getVdate() {
		return vDate;
	}

	public void setVdate(Date vDate) {
		this.vDate = vDate;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public String getRtype() {
		return rType;
	}

	public void setRtype(String rType) {
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

	public Integer getHoliDayPrice() {
		return holiDayPrice;
	}

	public void setHoliDayPrice(Integer holiDayPrice) {
		this.holiDayPrice = holiDayPrice;
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

	public byte getrTypeStatus() {
		return rTypeStatus;
	}

	public void setrTypeStatus(byte rTypeStatus) {
		this.rTypeStatus = rTypeStatus;
	}

	public String getaStatus() {
		return aStatus;
	}

	public void setaStatus(String aStatus) {
		this.aStatus = aStatus;
	}
	public Long getRbooking() {		
		return this.rbooking;
	}

	public void setRbooking(Long rbooking) {		
		this.rbooking = rbooking;
	}
	
	public CalSingleDTO(Integer roomTypeNo, Date vDate, String roomName, String rType, Integer roomTotal, Integer price,
			Integer normalPrice, Integer holiDayPrice, Integer bridgeHolidayPrice, String notice, String facility,
			byte rTypeStatus, Long rbooking, String aStatus) {
		super();
		this.roomTypeNo = roomTypeNo;
		this.vDate = vDate;
		this.roomName = roomName;
		this.rType = rType;
		this.roomTotal = roomTotal;
		this.price = price;
		this.normalPrice = normalPrice;
		this.holiDayPrice = holiDayPrice;
		this.bridgeHolidayPrice = bridgeHolidayPrice;
		this.notice = notice;
		this.facility = facility;
		this.rTypeStatus = rTypeStatus;
		this.rbooking = rbooking;
		this.aStatus = aStatus;
	}


	//設定雙主鍵還要，建立一個CompositeDetail implements Serializable
		 public static class CompositeDetail implements Serializable {
		        private Integer roomTypeNo;
		        private Date vDate;

		        public CompositeDetail() {
		        }

		        public CompositeDetail(Integer roomTypeNo, Date vdate) {
		            this.roomTypeNo = roomTypeNo;
		            this.vDate = vdate;
		        }

		        // 覆寫equals和hashCode方法
		        @Override
		        public boolean equals(Object o) {
		            if (this == o) return true;
		            if (o == null || getClass() != o.getClass()) return false;
		            CompositeDetail that = (CompositeDetail) o;
		            return Objects.equals(this.roomTypeNo, that.roomTypeNo) && Objects.equals(this.vDate, that.vDate);
		        }

		        @Override
		        public int hashCode() {
		            return Objects.hash(roomTypeNo, vDate);
		        }
		    }
	
}
