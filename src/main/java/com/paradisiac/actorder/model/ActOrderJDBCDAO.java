package com.paradisiac.actorder.model;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.paradisiac.actattendees.model.ActAttendeesJDBCDAO;
import com.paradisiac.actattendees.model.ActAttendeesVO;

import java.sql.Statement;


public class ActOrderJDBCDAO implements ActOrderDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123456";

	private static final String INSERT = "INSERT INTO act_order(mem_no,schd_no,order_time,a_atn_num,order_status,pay_method,pay_status,pay_time,order_amount) values (?, ?, NOW(),true, ?, true, ?, ?, ?)";
	private static final String UPDATE_BACK_STATUS = "UPDATE act_order SET emp_no=? order_status=?, pay_status=?, pay_time=? WHERE act_order_no = ?";
	private static final String UPDATE_FRONT_STATUS = "UPDATE act_order SET order_status=? WHERE act_order_no = ?";
	private static final String GET_ONE_BYACTODERNO = "SELECT * FROM act_order WHERE act_order_no = ?";
	private static final String GET_ALL_BYMEMNO= "SELECT * FROM act_order WHERE mem_no = ?";
	private static final String GET_ALL = "SELECT * FROM act_order";
	private static final String GET_ACTODERNO_BYMEMNO = "SELECT act_order_no FROM act_order WHERE mem_no = ? ORDER BY act_order_no";


	@Override
	public void insert(ActOrderVO ActOderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);

		
			pstmt.setInt(1, ActOderVO.getMemno());
			pstmt.setInt(2, ActOderVO.getSchdno());
			pstmt.setTimestamp(3, ActOderVO.getOrdertime());
			pstmt.setInt(4, ActOderVO.getAatnnum());
			pstmt.setBoolean(5, ActOderVO.getOrderstatus());
			pstmt.setInt(6, ActOderVO.getPaymethod());
			pstmt.setBoolean(7, ActOderVO.getPaystatus());
			pstmt.setTimestamp(8, ActOderVO.getPaytime());
			pstmt.setInt(9, ActOderVO.getOrderamount());
		
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
	public void update_Back_Status(ActOrderVO ActOderVO) {
		Connection con = null;// 連線宣告在方法內(為區域變數)，避免共用連線的問題(講義P40上)
		PreparedStatement pstmt = null;// 一個使用者一個連線

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_BACK_STATUS );
			
			pstmt.setInt(1, ActOderVO.getEmpno());
			pstmt.setBoolean(2, ActOderVO.getOrderstatus());
			pstmt.setBoolean(3, ActOderVO.getPaystatus()); 
			pstmt.setTimestamp(4, ActOderVO.getPaytime()); 
			pstmt.setInt(5, ActOderVO.getActorderno()); 
			
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
	public void update_Front_Status(ActOrderVO ActOderVO) {
		Connection con = null;// 連線宣告在方法內(為區域變數)，避免共用連線的問題(講義P40上)
		PreparedStatement pstmt = null;// 一個使用者一個連線

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_FRONT_STATUS );
			

			pstmt.setBoolean(1, ActOderVO.getOrderstatus());
			pstmt.setInt(2, ActOderVO.getActorderno()); 
			
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
	public ActOrderVO get_one_byactoderno(Integer ActOderNo) {
		ActOrderVO ActOderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_BYACTODERNO);
			pstmt.setInt(1, ActOderNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActOderVO = new ActOrderVO();
				ActOderVO.setActorderno(rs.getInt("act_order_no"));
				ActOderVO.setMemno(rs.getInt("mem_no"));
				ActOderVO.setSchdno(rs.getInt("schd_no"));
				ActOderVO.setEmpno(rs.getInt("emp_no"));
				ActOderVO.setOrdertime(rs.getTimestamp("order_time"));
				ActOderVO.setAatnnum(rs.getInt("a_atn_num"));
				ActOderVO.setOrderstatus(rs.getBoolean("order_status"));
				ActOderVO.setPaymethod(rs.getInt("pay_method"));
				ActOderVO.setPaystatus(rs.getBoolean("pay_status"));
				ActOderVO.setPaytime(rs.getTimestamp("pay_time"));
				ActOderVO.setOrderamount(rs.getInt("order_amount"));
				
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
		return ActOderVO;
	}

	@Override
	public List<ActOrderVO> get_all_bymemno(Integer MemNo) {
		List<ActOrderVO> list = new ArrayList<ActOrderVO>();
		ActOrderVO ActOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BYMEMNO);
			pstmt.setInt(1, MemNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActOrderVO = new ActOrderVO();
				ActOrderVO.setActorderno(rs.getInt("act_order_no"));
				ActOrderVO.setMemno(rs.getInt("mem_no"));
				ActOrderVO.setSchdno(rs.getInt("schd_no"));
				ActOrderVO.setEmpno(rs.getInt("emp_no"));
				ActOrderVO.setOrdertime(rs.getTimestamp("order_time"));
				ActOrderVO.setAatnnum(rs.getInt("a_atn_num"));
				ActOrderVO.setOrderstatus(rs.getBoolean("order_status"));
				ActOrderVO.setPaymethod(rs.getInt("pay_method"));
				ActOrderVO.setPaystatus(rs.getBoolean("pay_status"));
				ActOrderVO.setPaytime(rs.getTimestamp("pay_time"));
				ActOrderVO.setOrderamount(rs.getInt("order_amount"));
				list.add(ActOrderVO);
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
	public List<ActOrderVO> getAll() {
		List<ActOrderVO> list = new ArrayList<ActOrderVO>();
		ActOrderVO ActOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActOrderVO = new ActOrderVO();
				ActOrderVO.setActorderno(rs.getInt("act_order_no"));
				ActOrderVO.setMemno(rs.getInt("mem_no"));
				ActOrderVO.setSchdno(rs.getInt("schd_no"));
				ActOrderVO.setEmpno(rs.getInt("emp_no"));
				ActOrderVO.setOrdertime(rs.getTimestamp("order_time"));
				ActOrderVO.setAatnnum(rs.getInt("a_atn_num"));
				ActOrderVO.setOrderstatus(rs.getBoolean("order_status"));
				ActOrderVO.setPaymethod(rs.getInt("pay_method"));
				ActOrderVO.setPaystatus(rs.getBoolean("pay_status"));
				ActOrderVO.setPaytime(rs.getTimestamp("pay_time"));
				ActOrderVO.setOrderamount(rs.getInt("order_amount"));
				list.add(ActOrderVO);
			
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
	public void insertWithOrder_actAttendees(ActOrderVO ActOderVO, List<ActAttendeesVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;

			try {

				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ALL);

				// 1●設定於 pstm.executeUpdate()之前
	    			con.setAutoCommit(false);
				
	    		// 先新增訂單主檔
				pstmt = con.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1, ActOderVO.getMemno());
				pstmt.setInt(2, ActOderVO.getSchdno());
				pstmt.setTimestamp(3, ActOderVO.getOrdertime());
				pstmt.setInt(4, ActOderVO.getAatnnum());
				pstmt.setBoolean(5, ActOderVO.getOrderstatus());
				pstmt.setInt(6, ActOderVO.getPaymethod());
				pstmt.setBoolean(7, ActOderVO.getPaystatus());
				pstmt.setTimestamp(8, ActOderVO.getPaytime());
				pstmt.setInt(9, ActOderVO.getOrderamount());
				pstmt.executeUpdate();


				//掘取對應的自增主鍵值
				Integer next_act_order_no=null;
				ResultSet rs1 = pstmt.getGeneratedKeys();
				if (rs1.next()) {
					next_act_order_no = rs1.getInt(1);
	    				System.out.println("自增主鍵值= " + next_act_order_no);
						} else {
	    				System.out.println("未取得自增主鍵值");
					}
				rs1.close();

				// 再同時新增訂單明細
				ActAttendeesJDBCDAO dao = new ActAttendeesJDBCDAO();
				System.out.println("list.size()(執行前)="+list.size());
				for (ActAttendeesVO newActAttendees : list) {
					newActAttendees.setActorderno(next_act_order_no);
					dao.insertWhenOrder_ActOrderInsert(newActAttendees,con);
				}

				// 2●設定於 pstm.executeUpdate()之後
				con.commit();
				con.setAutoCommit(true);
				System.out.println("新增訂單主檔編號" + next_act_order_no + " ,共有訂單明細" + list.size()
						+ "同時被新增");
				// Handle any driver errors
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
				// Handle any SQL errors
			} catch (SQLException se) {
				if (con != null) {
					try {
						// 3●設定於當有exception發生時之catch區塊內
						System.err.print("Transaction is being ");
						System.err.println("訂單主檔錯誤，rolled back");
						con.rollback();
					} catch (SQLException excep) {
						throw new RuntimeException("rollback error occured. "
								+ excep.getMessage());
					}
				}
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
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
	public List<ActOrderVO> getactnoByMemNo(Integer MemNo){
		List<ActOrderVO> list = new ArrayList<ActOrderVO>();
		ActOrderVO ActOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ACTODERNO_BYMEMNO);
			pstmt.setInt(1, MemNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ActOrderVO = new ActOrderVO();
				ActOrderVO.setActorderno(rs.getInt("act_order_no"));
				ActOrderVO.setMemno(rs.getInt("mem_no"));
				ActOrderVO.setSchdno(rs.getInt("schd_no"));
				ActOrderVO.setEmpno(rs.getInt("emp_no"));
				ActOrderVO.setOrdertime(rs.getTimestamp("order_time"));
				ActOrderVO.setAatnnum(rs.getInt("a_atn_num"));
				ActOrderVO.setOrderstatus(rs.getBoolean("order_status"));
				ActOrderVO.setPaymethod(rs.getInt("pay_method"));
				ActOrderVO.setPaystatus(rs.getBoolean("pay_status"));
				ActOrderVO.setPaytime(rs.getTimestamp("pay_time"));
				ActOrderVO.setOrderamount(rs.getInt("order_amount"));
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
