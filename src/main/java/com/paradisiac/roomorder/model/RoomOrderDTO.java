package com.paradisiac.roomorder.model;

import java.sql.Date;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Immutable;

@Entity
@Immutable   //這資料表對映的是一個view的資料表，此註解是告訢Hibernate這是一個不可變的實體，因此不需要一個可變的標識符
@Table(name="checkin")
public class RoomOrderDTO {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="room_order_no")
	private Integer roomOrderNo;
	
	@Column(name="room_order_date")
	private Timestamp roomOrderDate;
	
	@Column(name="mem_name")
	private String memName;
	
	@Column(name="mem_id")	
	private String memId;
	
	@Column(name="mem_phone")
	private String memPhone;
	
	@Column(name="room_type_no")
	private Integer roomTypeNo;
		
	@Column(name="room_name")
	private String roomName;   //房型名稱
	
	@Column(name="room_amount")
	private Integer roomAmount;  //房間下訂數量
	
	@Column(name="price")
	private Integer price;
	
	@Column(name="checkin_date")
	private Timestamp checkInDate;
	
	@Column(name="checkout_date")
	private Timestamp checkOutDate;
	
	@Column(name="order_status")
	private byte orderStatus;

	public RoomOrderDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public RoomOrderDTO(Integer roomOrderNo, Timestamp roomOrderDate, String memName, String memId, String memPhone,
			Integer roomTypeNo, String roomName, Integer roomAmount, Integer price, Timestamp checkInDate,
			Timestamp checkOutDate, byte orderStatus) {
		super();
		this.roomOrderNo = roomOrderNo;
		this.roomOrderDate = roomOrderDate;
		this.memName = memName;
		this.memId = memId;
		this.memPhone = memPhone;
		this.roomTypeNo = roomTypeNo;
		this.roomName = roomName;
		this.roomAmount = roomAmount;
		this.price = price;
		this.checkInDate = checkInDate;
		this.checkOutDate = checkOutDate;
		this.orderStatus = orderStatus;
	}



	public Integer getRoomOrderNo() {
		return roomOrderNo;
	}

	public void setRoomOrderNo(Integer roomOrderNo) {
		this.roomOrderNo = roomOrderNo;
	}

	public Timestamp getRoomOrderDate() {
		return roomOrderDate;
	}

	public void setRoomOrderDate(Timestamp roomOrderDate) {
		this.roomOrderDate = roomOrderDate;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemPhone() {
		return memPhone;
	}

	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}
	
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

	public Integer getRoomAmount() {
		return roomAmount;
	}

	public void setRoomAmount(Integer roomAmount) {
		this.roomAmount = roomAmount;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Timestamp getCheckInDate() {
		return checkInDate;
	}

	public void setCheckInDate(Timestamp checkInDate) {
		this.checkInDate = checkInDate;
	}

	public Timestamp getCheckOutDate() {
		return checkOutDate;
	}

	public void setCheckOutDate(Timestamp checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public byte getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(byte orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	
		
}
