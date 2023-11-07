package com.paradisiac.csmessages.service;

import java.sql.Timestamp;
import java.util.List;

import com.paradisiac.csmessages.model.CsMessagesDAO_interface;
import com.paradisiac.csmessages.model.CsMessagesJDBCDAO;
import com.paradisiac.csmessages.model.CsMessagesVO;
import com.paradisiac.members.model.MembersVO;

public class CsMessagesService {
	private CsMessagesDAO_interface dao;



	public CsMessagesService() {
		dao=new CsMessagesJDBCDAO();
	}

	public CsMessagesVO insertFront(Integer memno,String cscontent) {
		
		CsMessagesVO CsVO = new CsMessagesVO();
	
		CsVO.setMemno(memno);
		CsVO.setCscontent(cscontent);
		
		dao.insertFront(CsVO);
		
		return CsVO;
	}
	
	public CsMessagesVO updateBack(Integer empno,String csreply,Integer csmsgno) {
		CsMessagesVO CsVO = new CsMessagesVO();
		
		CsVO.setEmpno(empno);
		CsVO.setCsreply(csreply);
		CsVO.setCsmsgno(csmsgno);
		dao.updateBack(CsVO);
		return CsVO;
	}

	public CsMessagesVO getOneByCsmsgno(Integer csmsgno) {
		return dao.getOneByCsmsgno(csmsgno);
	}

	public List<CsMessagesVO> getAll() {
		return dao.getAll();
	}

	public List<CsMessagesVO> getAllByEmpno(Integer empno) {
		return dao.getAllByEmpno(empno);
	}

	public List<CsMessagesVO> getAllBystatus(StringBuffer whereCondition,String keyword) {
		return dao.getAllBystatus(whereCondition,keyword);
	}

	public List<CsMessagesVO> getAllBycscontent(String keyword,Integer whereMemno) {
		return dao.getAllBycscontent(keyword,whereMemno);
	}


	
}

