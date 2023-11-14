package com.paradisiac.roomnum.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.NamedQuery;


@Entity
@Table(name = "room_num")
public class RoomNumVO implements java.io.Serializable{
	

	@Id
	@Column(name="r_num")
	private Integer rnum;
	
	@Column(name="room_type_no")
	private Integer roomTypeNo;
		
	@Column(name="room_order_no")
	private Integer roomOrderNo;
	
	@Column(name="checkin_name")
	private String checkInName;
	
	@Column(name="room_status")
	private byte roomStatus;
		
	public RoomNumVO() {
		super();		
	}

	public RoomNumVO(Integer rnum, Integer roomTypeNo, Integer roomOrderNo, String checkInName, byte roomStatus) {
		super();
		this.rnum = rnum;
		this.roomTypeNo = roomTypeNo;
		this.roomOrderNo = roomOrderNo;
		this.checkInName = checkInName;
		this.roomStatus = roomStatus;
	}
	
	public Integer getRnum() {
		return rnum;
	}
	
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public Integer getRoomTypeNo() {
		return roomTypeNo;
	}
	public void setRoomTypeNo(Integer roomTypeNO) {
		this.roomTypeNo = roomTypeNO;
	}
	public Integer getRoomOrderNo() {
		return roomOrderNo;
	}
	public void setRoomOrderNo(Integer roomOrderNo) {
		this.roomOrderNo = roomOrderNo;
	}
	public String getCheckInName() {
		return checkInName;
	}
	public void setCheckInName(String checkInName) {
		this.checkInName = checkInName;
	}
	public byte getRoomStatus() {
		return roomStatus;
	}
	public void setRoomStatus(byte roomStatus) {
		this.roomStatus = roomStatus;
	}

	@Override
	public String toString() {
		return "RoomNumVO [rnum=" + rnum + ", roomTypeNo=" + roomTypeNo + ", roomOrderNo=" + roomOrderNo
				+ ", checkInName=" + checkInName + ", roomStatus=" + roomStatus + "]";
	}
	
}
