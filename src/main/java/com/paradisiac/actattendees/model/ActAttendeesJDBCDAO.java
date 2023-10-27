package com.paradisiac.actattendees.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.paradisiac.actorder.model.*;



public class ActAttendeesJDBCDAO implements ActAttendeesDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "Cha103_11";

	private static final String INSERT = "INSERT INTO act_attendees(atn_no,act_order_no,atn_name,atn_id_number,atn_tel) VALUES(?,?,?,?,?,?)";
	private static final String UPDATE = "UPDATE act_attendees SET atn_no=?,act_order_no=?,atn_name=?,atn_id_number=?,atn_tel=? ";
	private static final String GET_ONE_BYACTORDERNO_ATNNO = "SELECT * FROM act_attendees WHERE act_order_no=? AND atn_no=? ";
	private static final String GET_ALL = "SELECT * FROM act_attendees";
	private static final String GET_ACTATTENDEES_BY_ACTORDERNO = "SELECT * FROMact_attendees WHERE act_order_no=? AND atn_no=? ";

	@Override
	public void insert(ActAttendeesVO ActAttendeesVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);

			pstmt.setInt(1, ActAttendeesVO.getAtnno());
			pstmt.setInt(2, ActAttendeesVO.getActorderno());
			pstmt.setString(3, ActAttendeesVO.getAtnname());
			pstmt.setString(4, ActAttendeesVO.getAtnidnumber());
			pstmt.setString(5, ActAttendeesVO.getAtntel());

			pstmt.executeUpdate();
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void update(ActAttendeesVO ActAttendeesVO) {
		Connection con = null;// 連線宣告在方法內(為區域變數)，避免共用連線的問題(講義P40上)
		PreparedStatement pstmt = null;// 一個使用者一個連線

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, ActAttendeesVO.getAtnno());
			pstmt.setInt(2, ActAttendeesVO.getActorderno());
			pstmt.setString(3, ActAttendeesVO.getAtnname());
			pstmt.setString(4, ActAttendeesVO.getAtnidnumber());
			pstmt.setString(5, ActAttendeesVO.getAtntel());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public ActAttendeesVO get_one_byactorderno_atnno(Integer ActOderNo, Integer AtnNo) {
		ActAttendeesVO ActAttendeesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_BYACTORDERNO_ATNNO);
			pstmt.setInt(1, ActOderNo);
			pstmt.setInt(1, AtnNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActAttendeesVO = new ActAttendeesVO();

				ActAttendeesVO.setAtnno(rs.getInt("atn_no"));
				ActAttendeesVO.setActorderno(rs.getInt("act_order_no"));
				ActAttendeesVO.setAtnname(rs.getString("atn_name"));
				ActAttendeesVO.setAtnidnumber(rs.getString("atn_id_number"));
				ActAttendeesVO.setAtntel(rs.getString("atn_tel"));

			}
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return ActAttendeesVO;
	}

	@Override
	public List<ActAttendeesVO> getAll() {
		List<ActAttendeesVO> list = new ArrayList<ActAttendeesVO>();
		ActAttendeesVO ActAttendeesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActAttendeesVO = new ActAttendeesVO();

				ActAttendeesVO.setAtnno(rs.getInt("atn_no"));
				ActAttendeesVO.setActorderno(rs.getInt("act_order_no"));
				ActAttendeesVO.setAtnname(rs.getString("atn_name"));
				ActAttendeesVO.setAtnidnumber(rs.getString("atn_id_number"));
				ActAttendeesVO.setAtntel(rs.getString("atn_tel"));
				list.add(ActAttendeesVO);
			}
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public void insertWhenOrder_ActOrderInsert(ActAttendeesVO ActAttendeesVO, Connection con) throws ClassNotFoundException {
		Connection con1 = null;//
		PreparedStatement pstmt = null;//
		ActOrderVO ActOrderVO = null;// X
		ResultSet rs = null;// X

		try {
			Class.forName(driver);
			con1 = DriverManager.getConnection(url, userid, passwd);
			pstmt = con1.prepareStatement(INSERT);

			pstmt.setInt(1, ActAttendeesVO.getAtnno());
			pstmt.setInt(2, ActAttendeesVO.getActorderno());
			pstmt.setString(3, ActAttendeesVO.getAtnname());
			pstmt.setString(4, ActAttendeesVO.getAtnidnumber());
			pstmt.setString(5, ActAttendeesVO.getAtntel());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			if (con1 != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("訂單明細錯誤，rolled back");
					con1.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public Set<ActAttendeesVO> get_ActAttendees_ByActOderNo_inSet(Integer ActOderNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ActAttendeesVO> get_ActAttendees_ByActOderNo(Integer ActOderNo) {
		List<ActAttendeesVO> list = new ArrayList<ActAttendeesVO>();
		ActAttendeesVO ActAttendeesVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ACTATTENDEES_BY_ACTORDERNO);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActAttendeesVO = new ActAttendeesVO();

				ActAttendeesVO.setAtnno(rs.getInt("atn_no"));
				ActAttendeesVO.setActorderno(rs.getInt("act_order_no"));
				ActAttendeesVO.setAtnname(rs.getString("atn_name"));
				ActAttendeesVO.setAtnidnumber(rs.getString("atn_id_number"));
				ActAttendeesVO.setAtntel(rs.getString("atn_tel"));
				list.add(ActAttendeesVO);
			}
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;

	}
}
