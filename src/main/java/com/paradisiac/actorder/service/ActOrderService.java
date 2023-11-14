package com.paradisiac.actorder.service;

import java.sql.Timestamp;
import java.util.List;

import com.paradisiac.actattendees.model.ActAttendeesVO;
import com.paradisiac.actorder.model.ActOrderDAO_interface;
import com.paradisiac.actorder.model.ActOrderJDBCDAO;
import com.paradisiac.actorder.model.ActOrderVO;

public class ActOrderService {

	private ActOrderDAO_interface dao;

	public ActOrderService() {
		dao = new ActOrderJDBCDAO();
	}

	public ActOrderVO insert(Integer memno,Integer schdno,Integer empno,
			Timestamp ordertime,Integer aatnnum,boolean orderstatus,Integer paymethod,
			boolean paystatus,Timestamp paytime,Integer orderamount) {
		
		ActOrderVO ActOrderVO=new ActOrderVO();
		ActOrderVO.setMemno(memno);
		ActOrderVO.setSchdno(schdno);		
		ActOrderVO.setOrdertime(ordertime);
		ActOrderVO.setPaystatus(orderstatus);
		ActOrderVO.setAatnnum(aatnnum);
		ActOrderVO.setPaymethod(paymethod);
		ActOrderVO.setPaystatus(paystatus);
		ActOrderVO.setPaytime(paytime);
		ActOrderVO.setOrderamount(orderamount);		
		dao.insert(ActOrderVO);
		return ActOrderVO;
	}

	public ActOrderVO update_Back_Status(Integer empno,boolean orderstatus,boolean paystatus,
			Timestamp paytime) {
		ActOrderVO ActOrderVO=new ActOrderVO();
		ActOrderVO.setEmpno(empno);
		ActOrderVO.setOrderstatus(orderstatus);
		ActOrderVO.setPaystatus(paystatus);
		ActOrderVO.setPaytime(paytime);	
		dao.update_Back_Status(ActOrderVO);
		return ActOrderVO;
	}

	public ActOrderVO get_one_byactoderno(Integer ActOderNo) {
		return dao.get_one_byactoderno(ActOderNo);
	}

	public List<ActOrderVO> get_all_bymemno(Integer MemNo) {
		return dao.get_all_bymemno(MemNo);
	}

	public List<ActOrderVO> getAll() {
		return dao.getAll();
	}

	public void insertWithOrder_actAttendees(ActOrderVO ActOderVO, List<ActAttendeesVO> list) {
		dao.insertWithOrder_actAttendees(ActOderVO, list);
	}

	public List<ActOrderVO> getactnoByMemNo(Integer MemNo) {
		return dao.getactnoByMemNo(MemNo);
	}

}
