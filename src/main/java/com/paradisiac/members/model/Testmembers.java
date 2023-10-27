package com.paradisiac.members.model;

import java.sql.Date;
import java.util.List;

public class Testmembers {

	public static void main(String[] args) {
		MembersJDBCDAO dao = new MembersJDBCDAO();
//getAll
		System.out.println("==========查全部========");
		List<MembersVO> list = dao.getAll();
		for (MembersVO mVO : list) {
			System.out.println("會員編號：" + mVO.getMemno() + ",");
			System.out.println("帳號狀態：" + mVO.getMemstatus() + ",");
			System.out.println("會員姓名：" + mVO.getMemname() + ",");
			System.out.println("會員信箱：" + mVO.getMemmail() + ",");
			System.out.println("會員帳號：" + mVO.getMemaccount() + ",");
			System.out.println("會員密碼：" + mVO.getMempass() + ",");
			System.out.println("會員性別：" + mVO.getMemgender() + ",");
			System.out.println("會員身分證字號：" + mVO.getMemid() + ",");
			System.out.println("會員生日：" + mVO.getMembir() + ",");
			System.out.println("會員電話：" + mVO.getMemphone() + ",");
			System.out.println("會員地址：" + mVO.getMemaddress() + ",");
			System.out.println("會員註冊日：" + mVO.getMemdate() + ",");
			System.out.println("會員註冊碼：" + mVO.getMemcaptcha() + ",");
			System.out.println("=====================");
	}

// 新增	
//		MembersVO testAdd = new MembersVO();
//		testAdd.setMemno(2);
//		testAdd.setMemstatus(false);
//		testAdd.setMemname("王一明");
//		testAdd.setMemmail("123@gmail.com");
//		testAdd.setMemaccount("QQ123");
//		testAdd.setMempass("1111");
//		testAdd.setMemgender(2);
//		testAdd.setMemid("S123456789");
//		testAdd.setMembir(Date.valueOf("2023-10-16"));
//		testAdd.setMemaddress("桃園市龜山區楓樹一街31號");
//		testAdd.setMemphone("+886972111111");
//		testAdd.setMemdate(new java.sql.Timestamp(System.currentTimeMillis()));
//		testAdd.setMemcaptcha("123");
//		testAdd.setMempicture();
//		dao.insert(testAdd);
//		System.out.println("新增成功");
//	}



// UPDATE_BACK_STATUS
//	MembersVO testUpdateBack = new MembersVO();
//	testUpdateBack.setMemstatus(true);//true(未凍結)
//	testUpdateBack.setMemno(112);
//    dao.update_back_status(testUpdateBack);
//    System.out.println("更新成功");
//}

// UPDATE_FRONT
//		MembersVO testUpdateFront = new MembersVO();
//		testUpdateFront.setMemname("王美");
//		testUpdateFront.setMemmail("1234@gmail.com");
//		testUpdateFront.setMemgender(2);
//		testUpdateFront.setMemid("S223456789");
//		testUpdateFront.setMembir(Date.valueOf("2023-10-16"));
//		testUpdateFront.setMemphone("+886972111111");
//		testUpdateFront.setMemaddress("桃園市龜山區楓樹一街31號");
//		testUpdateFront.setMemno(119);
//	    dao.update_front(testUpdateFront);
//	    System.out.println("更新成功");
//	}
// update_pass

//			MembersVO testUpdatePass = new MembersVO();
//			testUpdatePass.setMempass("222");
//			testUpdatePass.setMemno(119);
//			dao.update_pass(testUpdatePass);
//			System.out.println("更新成功");
//	}

// GET_ALL_BYSTATUS 

//		List<MembersVO> list = dao.getAllBystatus(false);
//		
//		for (MembersVO mVO : list) {
//			System.out.println("會員編號：" + mVO.getMemno() + ",");
//			System.out.println("帳號狀態：" + mVO.getMemstatus() + ",");
//			System.out.println("會員姓名：" + mVO.getMemname() + ",");
//			System.out.println("會員信箱：" + mVO.getMemmail() + ",");
//			System.out.println("會員帳號：" + mVO.getMemaccount() + ",");
//			System.out.println("會員密碼：" + mVO.getMempass() + ",");
//			System.out.println("會員性別：" + mVO.getMemgender() + ",");
//			System.out.println("會員身分證字號：" + mVO.getMemid() + ",");
//			System.out.println("會員生日：" + mVO.getMembir() + ",");
//			System.out.println("會員電話：" + mVO.getMemphone() + ",");
//			System.out.println("會員地址：" + mVO.getMemaddress() + ",");
//			System.out.println("會員註冊日：" + mVO.getMemdate() + ",");
//			System.out.println("==================");
//		}
		

 // GET_One_BYMEMNO
//		MembersVO testOneByMemno = dao.getOneBymemno(112);
//		System.out.println("會員編號：" + testOneByMemno.getMemno() );
//		System.out.println("帳號狀態：" + testOneByMemno.getMemstatus() );
//		System.out.println("會員姓名：" + testOneByMemno.getMemname() );
//		System.out.println("會員信箱：" + testOneByMemno.getMemmail());
//		System.out.println("會員帳號：" + testOneByMemno.getMemaccount() );
//		System.out.println("會員密碼：" + testOneByMemno.getMempass() );
//		System.out.println("會員性別：" + testOneByMemno.getMemgender() );
//		System.out.println("會員身分證字號：" + testOneByMemno.getMemid());
//		System.out.println("會員生日：" + testOneByMemno.getMembir() );
//		System.out.println("會員電話：" + testOneByMemno.getMemphone());
//		System.out.println("會員地址：" + testOneByMemno.getMemaddress() );
//		System.out.println("會員註冊日：" + testOneByMemno.getMemdate() );
//		System.out.println("==================");


		
// get_one_bymemaccount
//		MembersVO testOneByMemaccount = dao.getOneBymemaccount("lisi@example.com");
//
//		System.out.println("會員編號：" + testOneByMemaccount.getMemno() );
//		System.out.println("帳號狀態：" + testOneByMemaccount.getMemstatus() );
//		System.out.println("會員姓名：" + testOneByMemaccount.getMemname() );
//		System.out.println("會員信箱：" + testOneByMemaccount.getMemmail());
//		System.out.println("會員帳號：" + testOneByMemaccount.getMemaccount() );
//		System.out.println("會員密碼：" + testOneByMemaccount.getMempass() );
//		System.out.println("會員性別：" + testOneByMemaccount.getMemgender() );
//		System.out.println("會員身分證字號：" + testOneByMemaccount.getMemid());
//		System.out.println("會員生日：" + testOneByMemaccount.getMembir() );
//		System.out.println("會員電話：" + testOneByMemaccount.getMemphone());
//		System.out.println("會員地址：" + testOneByMemaccount.getMemaddress() );
//		System.out.println("會員註冊日：" + testOneByMemaccount.getMemdate() );
//		System.out.println("==================");
		
		
//==============預刪功能測試
		// 刪除
//		dao.delete(120);
//		System.out.println("刪除成功");
//=======
		//新增有照片
//		MembersVO testAdd = new MembersVO();
//		testAdd.setMemno(120);
//		testAdd.setMemstatus(false);
//		testAdd.setMemname("王一明");
//		testAdd.setMemmail("123@gmail.com");
//		testAdd.setMemaccount("QQ123");
//		testAdd.setMempass("1111");
//		testAdd.setMemgender(2);
//		testAdd.setMemid("S123456789");
//		testAdd.setMembir(Date.valueOf("2023-10-16"));
//		testAdd.setMemaddress("桃園市龜山區楓樹一街31號");
//		testAdd.setMemphone("+886972111111");
//		testAdd.setMemdate(new java.sql.Timestamp(System.currentTimeMillis()));
//		testAdd.setMemcaptcha("SSSS235");
//		testAdd.setMempicture(null);
//		
//		dao.insert(testAdd);
//		System.out.println("新增成功");


//更新全部
		//update_all
		MembersVO testUpdateAll = new MembersVO();
		testUpdateAll.setMemstatus(false);
		testUpdateAll.setMemname("王二明");
		testUpdateAll.setMemmail("1234@gmail.com");
		testUpdateAll.setMemaccount("QQ123");
		testUpdateAll.setMempass("1111");
		testUpdateAll.setMemgender(2);
		testUpdateAll.setMemid("S123456789");
		testUpdateAll.setMembir(Date.valueOf("2023-10-16"));
		testUpdateAll.setMemphone("+886972111111");
		testUpdateAll.setMemaddress("桃園市龜山區楓樹一街31號");
		testUpdateAll.setMemdate(new java.sql.Timestamp(System.currentTimeMillis()));
		testUpdateAll.setMemcaptcha("NEW134");
		testUpdateAll.setMempicture(null);
		testUpdateAll.setMemno(120);
		dao.updateAll(testUpdateAll);
		System.out.println("更新成功");
//}
	}
}
