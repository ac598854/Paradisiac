package com.paradisiac.csmessages.model;

import java.sql.Timestamp;

public class CsMessagesVO implements java.io.Serializable{

	private Integer csmsgno;
	private Integer memno;
	private Integer empno;
	private String cscontent;
	private Timestamp csaskdate;
	private String csreply;
	private Timestamp csredate;
	
	public CsMessagesVO() {
		
	}
	
	public CsMessagesVO(Integer csmsgno, Integer memno, Integer empno, String cscontent, Timestamp csaskdate,
			String csreply, Timestamp csredate) {
		super();
		this.csmsgno = csmsgno;
		this.memno = memno;
		this.empno = empno;
		this.cscontent = cscontent;
		this.csaskdate = csaskdate;
		this.csreply = csreply;
		this.csredate = csredate;
	}

	public Integer getCsmsgno() {
		return csmsgno;
	}

	public void setCsmsgno(Integer csmsgno) {
		this.csmsgno = csmsgno;
	}

	public Integer getMemno() {
		return memno;
	}

	public void setMemno(Integer memno) {
		this.memno = memno;
	}

	public Integer getEmpno() {
		return empno;
	}

	public void setEmpno(Integer empno) {
		this.empno = empno;
	}

	public String getCscontent() {
		return cscontent;
	}

	public void setCscontent(String cscontent) {
		this.cscontent = cscontent;
	}

	public Timestamp getCsaskdate() {
		return csaskdate;
	}

	public void setCsaskdate(Timestamp csaskdate) {
		this.csaskdate = csaskdate;
	}

	public String getCsreply() {
		return csreply;
	}

	public void setCsreply(String csreply) {
		this.csreply = csreply;
	}

	public Timestamp getCsredate() {
		return csredate;
	}

	public void setCsredate(Timestamp csredate) {
		this.csredate = csredate;
	}
	
	
	
}
