package com.paradisiac.roompicture.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.paradisiac.roomtype.model.RoomTypeVO;

	@Entity
	@Table(name = "room_picture")
	public class RoomPictureVO {
		
		@Id
		@Column(name = "picture_no")
		private Integer pictureNo;
		
		@Column(name = "room_type_no")
		private Integer roomTypeNo;
		
		@Column(name = "pic" , columnDefinition = "mediumblobtext")
		private byte[] pic;

		public RoomPictureVO() {
			super();
		}

		public RoomPictureVO(Integer pictureNo, Integer roomTypeNo, byte[] pic) {
			super();
			this.pictureNo = pictureNo;
			this.roomTypeNo = roomTypeNo;
			this.pic = pic;
		}

		public Integer getPictureNo() {
			return pictureNo;
		}

		public void setPictureNo(Integer pictureNo) {
			this.pictureNo = pictureNo;
		}

		public Integer getRoomTypeNo() {
			return roomTypeNo;
		}

		public void setRoomTypeNo(Integer roomTypeNo) {
			this.roomTypeNo = roomTypeNo;
		}

		public byte[] getPic() {
			return pic;
		}

		public void setPic(byte[] pic) {
			this.pic = pic;
		}
	
		
	
		
	}

