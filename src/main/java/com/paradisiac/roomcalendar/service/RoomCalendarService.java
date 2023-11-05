package com.paradisiac.roomcalendar.service;

import java.util.List;
import java.util.Map;

import com.paradisiac.roomcalendar.model.CalAllDTO;

public interface RoomCalendarService {
	String getCalAllDTOs();	
	String getCalSingleDTOs(int roomTypeno);	
	String getCalSingleDTOsForDay(String day);
}
