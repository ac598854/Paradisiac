package com.paradisiac.members.service;


import java.util.List;

import com.paradisiac.members.model.MembersDAO_interface;
import com.paradisiac.members.model.MembersJDBCDAO;
import com.paradisiac.members.model.MembersVO;

public class MembersService {

	private MembersDAO_interface dao;

	public MembersService() {
		dao = new MembersJDBCDAO();
	}

	public MembersVO Insertmember(String memname, String memmail, String memaccount, String mempass,
			Integer memgender, String memid, java.sql.Date membir,String memphone ,String memaddress,String memcaptcha,byte[] mempicture) {//這裡接收的是符合檢測的「值」

		MembersVO MembersVO = new MembersVO();//service要傳給DAO的格式須為「物件」
	
		MembersVO.setMemname(memname);
		MembersVO.setMemmail(memmail);
		MembersVO.setMemaccount(memaccount);
		MembersVO.setMempass(mempass);
		MembersVO.setMemgender(memgender);
		MembersVO.setMemid(memid);
		MembersVO.setMembir(membir);
		MembersVO.setMemphone(memphone);
		MembersVO.setMemaddress(memaddress);
		MembersVO.setMemcaptcha(memcaptcha);
		MembersVO.setMempicture(mempicture);//待刪
		dao.insert(MembersVO);//故用新建empVO(物件)，將值以物件形式呼叫傳給DAO
		return MembersVO;
	}

	public MembersVO updateAll(boolean memstatus, String memname, String memmail, String memaccount, String mempass,
			Integer memgender, String memid, java.sql.Date membir,String memphone ,String memaddress,byte[] mempicture) {

		MembersVO MembersVO = new MembersVO();
		MembersVO.setMemstatus(memstatus);
		MembersVO.setMemname(memname);
		MembersVO.setMemmail(memmail);
		MembersVO.setMemaccount(memaccount);
		MembersVO.setMempass(mempass);
		MembersVO.setMemgender(memgender);
		MembersVO.setMemid(memid);
		MembersVO.setMembir(membir);
		MembersVO.setMemphone(memphone);
		MembersVO.setMemaddress(memaddress);
		MembersVO.setMempicture(mempicture);
		dao.updateAll(MembersVO);

		return MembersVO;
	}
	
	public MembersVO updateBackStatus(Integer memno, boolean memstatus) {

		MembersVO MembersVO = new MembersVO();
		
		MembersVO.setMemstatus(memstatus);
		MembersVO.setMemno(memno);
		dao.updateBackStatus(MembersVO);

		return MembersVO;
	}

	public void updateFront(String memname, String memmail,String mempass,
			Integer memgender, String memid, java.sql.Date membir,String memphone ,String memaddress,byte[] mempicture,Integer memno) {
		MembersVO MembersVO = new MembersVO();
		MembersVO.setMemname(memname);
		MembersVO.setMemmail(memmail);
		MembersVO.setMempass(mempass);
		MembersVO.setMemgender(memgender);
		MembersVO.setMemid(memid);
		MembersVO.setMembir(membir);
		MembersVO.setMemphone(memphone);
		MembersVO.setMemaddress(memaddress);
		MembersVO.setMempicture(mempicture);
		MembersVO.setMemno(memno);
		dao.updateFront(MembersVO);

	}
	
	public MembersVO updatePass(String mempass, Integer memno) {
		
		MembersVO MembersVO = new MembersVO();
		MembersVO.setMempass(mempass);
		MembersVO.setMemno(memno);
		
		dao.updatePass(MembersVO);
		return MembersVO;
	}
	

	public List<MembersVO> getAll() {
		return dao.getAll();
	}
	public List<MembersVO> getAllBystatus(Boolean memstatus) {
		return dao.getAllBystatus(memstatus);
	}

	public MembersVO getOneBymemno(Integer memno) {
		return dao.getOneBymemno(memno);
	}
	public MembersVO getOneBymemaccount(String memaccount) {
		return dao.getOneBymemaccount(memaccount);
	}

	public void deleteMember(Integer memno) {
		dao.delete(memno);
	}


	

}
