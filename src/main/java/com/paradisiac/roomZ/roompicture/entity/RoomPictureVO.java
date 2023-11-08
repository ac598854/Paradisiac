package com.paradisiac.roomZ.roompicture.entity;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "room_picture")
public class RoomPictureVO {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "photo_no")
	private Integer pictureNo;
	@Column(name = "room_type_no")
	private Integer roomTypeNo;
	@Column(name = "pic", columnDefinition = "mediumblob" )
	private byte[] pic;


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

		@Override
		public String toString() {
			return "roomPicture [photo_no=" + pictureNo + ", "
					+ "roomTypeNo=" + roomTypeNo 
					+ ", pic=" + pic + "]";
		}
	
}


