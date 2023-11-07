package com.paradisiac.csmessages.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class CsMessagesJDBCDAO implements CsMessagesDAO_interface{

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "Cha103_11";
	
	private static final String INSERT_FRONT = "INSERT INTO cs_messages(mem_no,cs_content,cs_ask_date) VALUES ( ?, ?,NOW())";
	private static final String GET_ONE_BYCSMSGNO = "SELECT * FROM cs_messages WHERE cs_msg_no = ?";
	private static final String GET_ALL = "SELECT * FROM cs_messages ORDER BY cs_msg_no";
	private static final String GET_ALL_BYEMPNO = "SELECT * FROM cs_messages WHERE empno = ? ORDER BY cs_msg_no";
	
//	private static final String GET_ALL_BYSTATUS = "SELECT * FROM cs_messages WHERE empno = ? ORDER BY cs_msg_no";
	private static final String GET_ALL_BYCSCONTENT = "SELECT * FROM cs_messages WHERE cs_content LIKE ? ORDER BY cs_msg_no";
	
	private static final String UPDATE_BACK = "UPDATE cs_messages SET emp_no=?,cs_reply=?,cs_re_date=NOW() WHERE cs_msg_no = ?";
	
	@Override
	public void insertFront(CsMessagesVO CsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_FRONT);
			
			pstmt.setInt(1, CsVO.getMemno());
			pstmt.setString(2, CsVO.getCscontent());
	
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
	public List<CsMessagesVO> getAll() {
		List<CsMessagesVO> list = new ArrayList<CsMessagesVO>();
		CsMessagesVO CsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				CsVO = new CsMessagesVO();
				CsVO.setCsmsgno(rs.getInt("cs_msg_no"));
				CsVO.setMemno(rs.getInt("mem_no"));
				CsVO.setEmpno(rs.getInt("emp_no"));
				CsVO.setCscontent(rs.getString("cs_content"));
				CsVO.setCsaskdate(rs.getTimestamp("cs_ask_date"));
				CsVO.setCsreply(rs.getString("cs_reply"));
				CsVO.setCsredate(rs.getTimestamp("cs_re_date"));
				
				list.add(CsVO);
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
	public List<CsMessagesVO> getAllByEmpno(Integer empno) {
		List<CsMessagesVO> list = new ArrayList<CsMessagesVO>();
		CsMessagesVO CsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BYEMPNO);
			pstmt.setInt(1, empno);
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				CsVO = new CsMessagesVO();
				CsVO.setCsmsgno(rs.getInt("cs_msg_no"));
				CsVO.setMemno(rs.getInt("mem_no"));
				CsVO.setEmpno(rs.getInt("emp_no"));
				CsVO.setCscontent(rs.getString("cs_content"));
				CsVO.setCsaskdate(rs.getTimestamp("cs_ask_date"));
				CsVO.setCsreply(rs.getString("cs_reply"));
				CsVO.setCsredate(rs.getTimestamp("cs_re_date"));
				
				list.add(CsVO);
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
	public List<CsMessagesVO> getAllBystatus(StringBuffer whereCodition,String keyword) {
		List<CsMessagesVO> list = new ArrayList<CsMessagesVO>();
		CsMessagesVO CsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql="SELECT * FROM cs_messages "+whereCodition.toString()+ " ORDER BY cs_msg_no";
		System.out.println("203="+sql);
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(sql);
			if(keyword.trim().length()>0) {
				pstmt.setString(1, "%"+keyword+"%");
			}
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				CsVO = new CsMessagesVO();
				CsVO.setCsmsgno(rs.getInt("cs_msg_no"));
				CsVO.setMemno(rs.getInt("mem_no"));
				CsVO.setEmpno(rs.getInt("emp_no"));
				CsVO.setCscontent(rs.getString("cs_content"));
				CsVO.setCsaskdate(rs.getTimestamp("cs_ask_date"));
				CsVO.setCsreply(rs.getString("cs_reply"));
				CsVO.setCsredate(rs.getTimestamp("cs_re_date"));
				
				list.add(CsVO);
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
	public List<CsMessagesVO> getAllBycscontent(String keyword,Integer whereMemno) {
		List<CsMessagesVO> list = new ArrayList<CsMessagesVO>();
		CsMessagesVO CsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql="SELECT * FROM cs_messages  where cs_content LIKE ? and mem_no=?   ORDER BY cs_msg_no";
		System.out.println("203="+sql);
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setInt(2, whereMemno);
			

			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				CsVO = new CsMessagesVO();
				CsVO.setCsmsgno(rs.getInt("cs_msg_no"));
				CsVO.setMemno(rs.getInt("mem_no"));
//				CsVO.setEmpno(rs.getInt("emp_no"));
				CsVO.setCscontent(rs.getString("cs_content"));
				CsVO.setCsaskdate(rs.getTimestamp("cs_ask_date"));
				CsVO.setCsreply(rs.getString("cs_reply"));
				CsVO.setCsredate(rs.getTimestamp("cs_re_date"));
				
				list.add(CsVO);
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
	

//	@Override
//	public List<CsMessagesVO> getAllBycscontent(String cscontent) {
//		List<CsMessagesVO> list = new ArrayList<CsMessagesVO>();
//		CsMessagesVO CsVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(GET_ALL_BYCSCONTENT);
//			pstmt.setString(1,cscontent);
//			rs = pstmt.executeQuery();
//		
//			while (rs.next()) {
//				CsVO = new CsMessagesVO();
//				CsVO.setCsmsgno(rs.getInt("cs_msg_no"));
//				CsVO.setMemno(rs.getInt("mem_no"));
//				CsVO.setEmpno(rs.getInt("emp_no"));
//				CsVO.setCscontent(rs.getString("cs_content"));
//				CsVO.setCsaskdate(rs.getTimestamp("cs_ask_date"));
//				CsVO.setCsreply(rs.getString("cs_reply"));
//				CsVO.setCsredate(rs.getTimestamp("cs_re_date"));
//				
//				list.add(CsVO);
//			}
//			// Handle any driver errors
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return list;
//	}



	@Override
	public CsMessagesVO getOneByCsmsgno(Integer csmsgno) {
		CsMessagesVO CsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_BYCSMSGNO);
			pstmt.setInt(1, csmsgno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CsVO = new CsMessagesVO();
				CsVO.setCsmsgno(rs.getInt("cs_msg_no"));
				CsVO.setMemno(rs.getInt("mem_no"));
				CsVO.setEmpno(rs.getInt("emp_no"));
				CsVO.setCscontent(rs.getString("cs_content"));
				CsVO.setCsaskdate(rs.getTimestamp("cs_ask_date"));
				CsVO.setCsreply(rs.getString("cs_reply"));
				CsVO.setCsredate(rs.getTimestamp("cs_re_date"));
				
		
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
		return CsVO;
	}
	
	@Override
	public void  updateBack(CsMessagesVO CsVO) {
		Connection con = null;// 連線宣告在方法內(為區域變數)，避免共用連線的問題(講義P40上)
		PreparedStatement pstmt = null;// 一個使用者一個連線

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_BACK);

			
			pstmt.setInt(1, CsVO.getEmpno());
			pstmt.setString(2, CsVO.getCsreply());
			pstmt.setInt(3, CsVO.getCsmsgno());
			
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

	
}
