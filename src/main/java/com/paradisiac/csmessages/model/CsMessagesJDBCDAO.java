package com.paradisiac.csmessages.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CsMessagesJDBCDAO implements CsMessagesDAO_interface{

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "Cha103_11";
	
	private static final String INSERT = "INSERT INTO cs_messages(cs_msg_no,mem_no,emp_no,cs_content,cs_ask_date,cs_reply,cs_re_date) VALUES (?, ?, ?, ?, ?, ?, ? )";
	private static final String GET_ALL = "SELECT * FROM cs_messages ORDER BY cs_msg_no";
	private static final String GET_ONE_BYCSMSGNO = "SELECT * FROM cs_messages WHERE cs_msg_no = ?";
	
	@Override
	public void insert(CsMessagesVO CsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);

			pstmt.setInt(1, CsVO.getCsmsgno());
			pstmt.setInt(2, CsVO.getMemno());
			pstmt.setInt(3, CsVO.getEmpno());
			pstmt.setString(4, CsVO.getCscontent());
			pstmt.setTimestamp(5, CsVO.getCsaskdate());
			pstmt.setString(6, CsVO.getCsreply());
			pstmt.setTimestamp(7, CsVO.getCsredate());

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
	public CsMessagesVO get_one_bycamsgno(Integer csmsgno) {
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
	
}
