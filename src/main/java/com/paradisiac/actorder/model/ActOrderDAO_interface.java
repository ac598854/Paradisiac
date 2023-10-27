package com.paradisiac.actorder.model;

import java.util.List;

import com.paradisiac.actattendees.model.ActAttendeesVO;

public interface ActOrderDAO_interface {
	public void insert(ActOrderVO ActOderVO);
	public void update_status(ActOrderVO ActOderVO);
	public ActOrderVO get_one_byactoderno(Integer ActOderNo);
	public List<ActOrderVO> get_all_bymemno(Integer MemNo);//會員編號查明細用
	public List<ActOrderVO> getAll();

    //同時新增訂單主檔與訂單明細
	public void insertWithOrder_actAttendees(ActOrderVO ActOderVO , List<ActAttendeesVO> list);
	//訂單明細(參加人)-訂單主檔-會員//可以用會員編號查到明細
	public List<ActOrderVO> getactnoByMemNo(Integer MemNo);
	
}
