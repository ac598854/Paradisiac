package com.paradisiac.actattendees.model;

public class ActAttendeesVO implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Integer atnno;
	private Integer actorderno;
	private String atnname;
	private String atnidnumber;
	private String atntel;
	
	
	public ActAttendeesVO() {
		
	}


	public ActAttendeesVO(Integer atnno, Integer actorderno, String atnname, String atnidnumber, String atntel) {
		super();
		this.atnno = atnno;
		this.actorderno = actorderno;
		this.atnname = atnname;
		this.atnidnumber = atnidnumber;
		this.atntel = atntel;
	}


	public Integer getAtnno() {
		return atnno;
	}


	public void setAtnno(Integer atnno) {
		this.atnno = atnno;
	}


	public Integer getActorderno() {
		return actorderno;
	}


	public void setActorderno(Integer actorderno) {
		this.actorderno = actorderno;
	}


	public String getAtnname() {
		return atnname;
	}


	public void setAtnname(String atnname) {
		this.atnname = atnname;
	}


	public String getAtnidnumber() {
		return atnidnumber;
	}


	public void setAtnidnumber(String atnidnumber) {
		this.atnidnumber = atnidnumber;
	}


	public String getAtntel() {
		return atntel;
	}


	public void setAtntel(String atntel) {
		this.atntel = atntel;
	}





	
	

}
