package com.paradisiac.roomorder.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "room_order")
public class RoomOrderVO {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "room_order_no", updatable = false)
	private Integer roomOrderNo;
	@Column(name = "room_order_date")
	private Date roomOrderDate;
	@Column(name = "checkin_date")
	private Date checkinDate;
	@Column(name = "checkout_date")
	private Date checkoutDate;
	@Column(name = "room_type_no")
	private Integer roomTypeNo;
	@Column(name = "mem_no")
	private Integer memNo;
	@Column(name = "room_amount")
	private Integer roomAmount;
	@Column(name = "price")
	private Integer price;
	@Column(name = "payment_method", columnDefinition = "tinyint")
	private byte paymentMethod;
	@Column(name = "pay_status")
	private boolean payStatus;
	@Column(name = "order_status", columnDefinition = "tinyint")
	private byte orderStatus;
	



	public Integer getRoomOrderNo() {
		return roomOrderNo;
	}
	public void setRoomOrderNo(Integer roomOrderNo) {
		this.roomOrderNo = roomOrderNo;
	}
	public Date getRoomOrderDate() {
		return roomOrderDate;
	}
	public void setRoomOrderDate(Date roomOrderDate) {
		this.roomOrderDate = roomOrderDate;
	}
	public Date getCheckinDate() {
		return checkinDate;
	}
	public void setCheckinDate(Date checkinDate) {
		this.checkinDate = checkinDate;
	}
	public Date getCheckoutDate() {
		return checkoutDate;
	}
	public void setCheckoutDate(Date checkoutDate) {
		this.checkoutDate = checkoutDate;
	}
	public Integer getRoomTypeNo() {
		return roomTypeNo;
	}
	public void setRoomTypeNo(Integer roomTypeNo) {
		this.roomTypeNo = roomTypeNo;
	}
	public Integer getMemNo() {
		return memNo;
	}
	public void setMemNo(Integer memNo) {
		this.memNo = memNo;
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
	public byte getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(byte paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public boolean isPayStatus() {
		return payStatus;
	}
	public void setPayStatus(boolean payStatus) {
		this.payStatus = payStatus;
	}
	public byte getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(byte orderStatus) {
		this.orderStatus = orderStatus;
	}
	@Override
	public String toString() {
		
		return "roomorder [roomorder=" + roomOrderNo + ", roomOrderDate=" + roomOrderDate + ", checkinDate=" + checkinDate + ", checkoutDate=" + checkoutDate + ", roomTypeNo=" + roomTypeNo
				+ ", memNo=" + memNo + ", roomAmount=" + roomAmount + ", price" + price + ", paymentMethod=" + paymentMethod + ""
						+ ", payStatus=" + payStatus + ", orderStatus" + orderStatus + "]";
		
	}

	

}
