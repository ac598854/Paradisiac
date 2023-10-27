package com.paradisiac.promotion.service;

import java.sql.Date;
import java.util.List;

import com.paradisiac.promotion.model.PromotionDAO_interface;
import com.paradisiac.promotion.model.PromotionJDBCDAO;
import com.paradisiac.promotion.model.PromotionVO;



public class PromotionService {
 
		private PromotionDAO_interface pro;

		public PromotionService() {
			 pro = new  PromotionJDBCDAO();
		}

		public PromotionVO addPro(String proname,String prodes,Date startdate,
				Date enddate,Double discount,Integer status) 
		{

			PromotionVO proVO = new PromotionVO();

			
			proVO.setProname(proname);
			proVO.setProdes(prodes);
			proVO.setStartdate(startdate);
			proVO.setEnddate(enddate);
			proVO.setDiscount(discount);
			proVO.setStatus(status);
			pro.insert(proVO);
			

			return proVO;
		}

		public PromotionVO updatePro(Integer prono,String proname,String prodes,Date startdate,
				Date enddate,Double discount,Integer status) {

			PromotionVO proVO = new PromotionVO();

			proVO.setProno(prono);
			proVO.setProname(proname);
			proVO.setProdes(prodes);
			proVO.setStartdate(startdate);
			proVO.setEnddate(enddate);
			proVO.setDiscount(discount);
			proVO.setStatus(status);
			pro.update(proVO);
			

			return proVO;
		}

		public void deletePro(Integer prono) {
			pro.delete(prono);
		}

		public PromotionVO getOnePro(Integer prono) {
			return pro.findByPrimaryKey(prono);
		}
		

		public List<PromotionVO> getAll() {
			return  pro.getAll();
		}
	}


