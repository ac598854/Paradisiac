package com.paradisiac.roomcalendar.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Immutable;

@Entity
@Immutable   //這資料表對映的是一個view的資料表，此註解是告訢Hibernate這是一個不可變的實體，因此不需要一個可變的標識符
@Table(name="calall")
public class CalAllDTO {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="v_date")
	private Date vdata;
	
	@Column(name="room_total")
	private Long tRoom;
	
	@Column(name="total_room_booking")
	private Long bRoom;
	
	@Column(name="total_last_room")
	private Long lRoom;
	
	@Column(name="availability_status")
	private String aStatus;
	
	public CalAllDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CalAllDTO(Date vdata, Long tRoom, Long bRoom, Long lRoom, String aStatus) {
		super();
		this.vdata = vdata;    
		this.tRoom = tRoom;
		this.bRoom = bRoom;
		this.lRoom = lRoom;
		this.aStatus = aStatus;
	}
	public Date getVdata() {
		return vdata;
	}
	public void setVdata(Date vdata) {
		this.vdata = vdata;
	}
	public Long gettRoom() {
		return tRoom;
	}
	public void settRoom(Long tRoom) {
		this.tRoom = tRoom;
	}
	public Long getbRoom() {
		return bRoom;
	}
	public void setbRoom(Long bRoom) {
		this.bRoom = bRoom;
	}
	public Long getlRoom() {
		return lRoom;
	}
	public void setlRoom(Long lRoom) {
		this.lRoom = lRoom;
	}
	public String getaStatus() {
		return aStatus;
	}
	public void setaStatus(String aStatus) {
		this.aStatus = aStatus;
	}
	
	
}
