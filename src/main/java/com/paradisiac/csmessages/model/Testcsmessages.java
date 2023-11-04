package com.paradisiac.csmessages.model;

import java.util.List;

public class Testcsmessages {

	public static void main(String[] args) {
		CsMessagesJDBCDAO dao = new CsMessagesJDBCDAO();

		// getAll
//	System.out.println("==========查全部========");
//	List<CsMessagesVO> list = dao.getAll();
//	for (CsMessagesVO CsVO : list) {
//		System.out.println("訊息編號：" + CsVO.getCsmsgno() + ",");
//		System.out.println("會員編號：" + CsVO.getMemno() + ",");
//		System.out.println("處理員工編號：" + CsVO.getEmpno() + ",");
//		System.out.println("客戶訊息：" + CsVO.getCscontent() + ",");
//		System.out.println("客戶訊息時間：" + CsVO.getCsaskdate() + ",");
//		System.out.println("回復訊息：" + CsVO.getCsreply() + ",");
//		System.out.println("回復訊息時間：" + CsVO.getCsredate() + ",");
//		
//		System.out.println("=====================");
//}

//新增	
		CsMessagesVO testAdd = new CsMessagesVO();
		testAdd.setCsmsgno(11);
		testAdd.setMemno(111);
		testAdd.setEmpno(101);
		testAdd.setCscontent("客訴");
		testAdd.setCsaskdate(new java.sql.Timestamp(System.currentTimeMillis()));
		testAdd.setCsreply("回覆");
		testAdd.setCsredate(new java.sql.Timestamp(System.currentTimeMillis()));
		dao.insert(testAdd);
		System.out.println("新增成功");
		
		// GET_One_BYMEMNO
//	CsMessagesVO testOneByCsmagno = dao.get_one_bycamsgno(20);
//	System.out.println("訊息編號：" + testOneByCsmagno.getCsmsgno() + ",");
//	System.out.println("會員編號：" + testOneByCsmagno.getMemno() + ",");
//	System.out.println("處理員工編號：" + testOneByCsmagno.getEmpno() + ",");
//	System.out.println("客戶訊息：" + testOneByCsmagno.getCscontent() + ",");
//	System.out.println("客戶訊息時間：" + testOneByCsmagno.getCsaskdate() + ",");
//	System.out.println("回復訊息：" + testOneByCsmagno.getCsreply() + ",");
//	System.out.println("回復訊息時間：" + testOneByCsmagno.getCsredate() + ",");
//	System.out.println("==================");

	}
}
