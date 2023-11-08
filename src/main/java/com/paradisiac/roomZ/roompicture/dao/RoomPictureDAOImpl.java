package com.paradisiac.roomZ.roompicture.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.paradisiac.roomZ.roompicture.entity.RoomPictureVO;
import com.paradisiac.util.HibernateUtil;
public class RoomPictureDAOImpl implements RoomPictureDAO{
	// SessionFactory 為 thread-safe，可宣告為屬性讓請求執行緒們共用
		private SessionFactory factory;

		public RoomPictureDAOImpl(SessionFactory factory) {
			this.factory = factory;
		}

		// Session 為 not thread-safe，所以此方法在各個增刪改查方法裡呼叫
		// 以避免請求執行緒共用了同個 Session
		private Session getSession() {
			return factory.getCurrentSession();
		}
		
		@Override
		public int insert(RoomPictureVO roomPictureVO) {
			Session session = HibernateUtil.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				session.save(roomPictureVO);
				session.getTransaction().commit();
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			} finally {
				if (session != null && session.isOpen()) {
					session.close();
				}
			}
			return -1;
		}

		@Override
		public int update(RoomPictureVO roomPictureVO) {
			Session session = HibernateUtil.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				session.update(roomPictureVO);
				session.getTransaction().commit();
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			} finally {
				if (session != null && session.isOpen()) {
					session.close();
				}
			}
			return -1;
		}
		@Override
		public RoomPictureVO findByPrimaryKey(Integer roomPicrureNo) {
			Session session = HibernateUtil.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				RoomPictureVO roomPictureVO = session.get(RoomPictureVO.class, roomPicrureNo);
				session.getTransaction().commit();
				return roomPictureVO;
			}catch (Exception e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			} finally {
				if (session != null && session.isOpen()) {
					session.close();
				}
			}
			return null;
		}

		@Override
		public List<RoomPictureVO> getAll() {
			Session session = HibernateUtil.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				List<RoomPictureVO> list = session.createQuery("from RoomPictureVO", RoomPictureVO.class).list();
				session.getTransaction().commit();
				return list;
			} catch (Exception e) {
				e.printStackTrace();
				session.getTransaction().rollback();
			}
			return null;
		}

	}
