package com.paradisiac.roomcalendar.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name = "room_calendar")
public class RoomCalendarVO implements java.io.Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "calendar_no", updatable = false)
	private Integer calendarNo;
	
	@Column(name = "room_type_no")
	private Integer roomTypeno;
	
	@Column(name = "cdata")
	private Date cDate;
	
	@Column(name = "room_total")
	private Integer roomTotal;
	
	@Column(name = "room_booking")
	private Integer roomBooking;
	
	@Column(name = "available")
	private Byte available;	
	
	public Integer getCalendarNo() {
		return calendarNo;
	}
	public void setCalendarNO(Integer calendarNO) {
		this.calendarNo = calendarNO;
	}
	public Integer getRoomTypeno() {
		return roomTypeno;
	}
	public void setRoomTypeno(Integer roomTypeno) {
		this.roomTypeno = roomTypeno;
	}
	public Date getcDate() {
		return cDate;
	}
	public void setcDate(Date cDate) {
		this.cDate = cDate;
	}
	public Integer getRoomTotal() {
		return roomTotal;
	}
	public void setRoomTotal(Integer roomTotal) {
		this.roomTotal = roomTotal;
	}
	public Integer getRoomBooking() {
		return roomBooking;
	}
	public void setRoomBooking(Integer roomBooking) {
		this.roomBooking = roomBooking;
	}
	public Byte getAvailable() {
		return available;
	}
	public void setAvailable(Byte available) {
		this.available = available;
		
	}	
}
