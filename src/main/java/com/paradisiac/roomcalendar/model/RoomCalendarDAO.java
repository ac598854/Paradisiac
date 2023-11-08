package com.paradisiac.roomcalendar.model;

import java.util.*;

public interface RoomCalendarDAO {
		
	String getAll();
	String getSingleForType(int roomTypeno);
	String getSingleForDay(String day);
	
}
