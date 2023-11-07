package com.paradisiac.members.model;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class MembersJDBCDAO implements MembersDAO_interface {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "Cha103_11";


	private static final String INSERT = "INSERT INTO members(mem_status,mem_name,mem_mail,mem_account,mem_pass,mem_gender,mem_id,mem_bir, mem_phone,mem_address,mem_captcha,mem_picture) VALUES (true, ?, ?, ?, ?, ? ,?, ?, ?,?,?,?)";
	private static final String UPDATE_ALL = "UPDATE members SET mem_status = ?, mem_name = ?, mem_mail = ?, mem_account = ?, mem_pass = ?, mem_gender = ?, mem_id = ?, mem_bir = ? , mem_phone = ?,mem_address = ?,mem_picture = ? WHERE mem_no = ?";
	private static final String UPDATE_BACK_STATUS = "UPDATE members SET mem_status = ? WHERE mem_no = ?";
	private static final String UPDATE_FRONT = "UPDATE members SET mem_name = ?, mem_mail = ?, mem_pass = ?,mem_gender = ?, mem_id = ?, mem_bir = ? , mem_phone = ?,mem_address = ?,mem_picture = ? WHERE mem_no = ?";
	private static final String UPDATE_PASS = "UPDATE members SET mem_pass = ? WHERE mem_no = ?";
//	private static final String UPDATE_MEMCAPTCHA = "UPDATE members SET mem_captcha = ? WHERE mem_no = ?";
	private static final String GET_ALL = "SELECT * FROM members ORDER BY mem_no";
	private static final String GET_ALL_BYSTATUS = "SELECT * FROM members WHERE mem_status = ? ORDER BY mem_no";
	private static final String GET_ONE_BYMEMNO = "SELECT * FROM members WHERE mem_no = ?";
	private static final String GET_ONE_BYMEMACCOUNT = "SELECT * FROM members WHERE mem_account = ?";
	private static final String DELETE = "DELETE FROM members WHERE mem_no = ?"; // 之後刪掉(沒有此功能)

	@Override
	public void insert(MembersVO mVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT);//下面set順序跟sql問號一致
	
			pstmt.setString(1, mVO.getMemname());
			pstmt.setString(2, mVO.getMemmail());
			pstmt.setString(3, mVO.getMemaccount());
			pstmt.setString(4, mVO.getMempass());
			pstmt.setInt(5, mVO.getMemgender());
			pstmt.setString(6, mVO.getMemid());
			pstmt.setDate(7, mVO.getMembir());
			pstmt.setString(8, mVO.getMemphone());
			pstmt.setString(9, mVO.getMemaddress());
			pstmt.setString(10, mVO.getMemcaptcha());
			pstmt.setBytes(11, mVO.getMempicture());

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
	public void updateAll(MembersVO mVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_ALL);

			pstmt.setBoolean(1, mVO.getMemstatus());
			pstmt.setString(2, mVO.getMemname());
			pstmt.setString(3, mVO.getMemmail());
			pstmt.setString(4, mVO.getMemaccount());
			pstmt.setString(5, mVO.getMempass());
			pstmt.setInt(6, mVO.getMemgender());
			pstmt.setString(7, mVO.getMemid());
			pstmt.setDate(8, mVO.getMembir());
			pstmt.setString(9, mVO.getMemphone());
			pstmt.setString(10, mVO.getMemaddress());
			pstmt.setBytes(11, mVO.getMempicture());// 預刪功能

			pstmt.setInt(12, mVO.getMemno());

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
	public void updateBackStatus(MembersVO mVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_BACK_STATUS);

			pstmt.setBoolean(1, mVO.getMemstatus());
			pstmt.setInt(2, mVO.getMemno());

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
	public void updateFront(MembersVO mVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_FRONT);
					
			pstmt.setString(1, mVO.getMemname());
			pstmt.setString(2, mVO.getMemmail());
			pstmt.setString(3, mVO.getMempass());
			pstmt.setInt(4, mVO.getMemgender());
			pstmt.setString(5, mVO.getMemid());
			pstmt.setDate(6, mVO.getMembir());
			pstmt.setString(7, mVO.getMemphone());
			pstmt.setString(8, mVO.getMemaddress());
			pstmt.setBytes(9, mVO.getMempicture());
			pstmt.setInt(10, mVO.getMemno());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			se.printStackTrace();
			throw new RuntimeException("A database error occured(發生資料庫錯誤。). " + se.getMessage());
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
	public void updatePass(MembersVO mVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_PASS);
			pstmt.setString(1, mVO.getMempass());
			pstmt.setInt(2, mVO.getMemno());

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

//不需要
//	@Override
//	public void update_mem_captcha(MembersVO mVO) {
//		Connection con = null;// 連線宣告在方法內(為區域變數)，避免共用連線的問題(講義P40上)
//		PreparedStatement pstmt = null;// 一個使用者一個連線
//
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, passwd);
//			pstmt = con.prepareStatement(UPDATE_MEMCAPTCHA);
//
//			pstmt.setString(1, mVO.getMemcaptcha());
//			pstmt.setInt(2, mVO.getMemno()); 
//
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
//			// Handle any SQL errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. " + se.getMessage());
//			// Clean up JDBC resources
//		} finally {
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
//		
//	}

	@Override
	public List<MembersVO> getAll() {
		List<MembersVO> list = new ArrayList<MembersVO>();
		MembersVO mVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mVO = new MembersVO();
				mVO.setMemno(rs.getInt("mem_no"));
				mVO.setMemstatus(rs.getBoolean("mem_status"));
				mVO.setMemname(rs.getString("mem_name"));
				mVO.setMemmail(rs.getString("mem_mail"));
				mVO.setMemaccount(rs.getString("mem_account"));
				mVO.setMempass(rs.getString("mem_pass"));
				mVO.setMemgender(rs.getInt("mem_gender"));
				mVO.setMemid(rs.getString("mem_id"));
				mVO.setMembir(rs.getDate("mem_bir"));
				mVO.setMemphone(rs.getString("mem_phone"));
				mVO.setMemaddress(rs.getString("mem_address"));
				mVO.setMemdate(rs.getTimestamp("mem_date"));
				mVO.setMemcaptcha(rs.getString("mem_captcha"));
				mVO.setMempicture(rs.getBytes("mem_picture"));
				list.add(mVO);
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
	public List<MembersVO> getAllBystatus(Boolean memstatus) {
		List<MembersVO> list = new ArrayList<MembersVO>();
		MembersVO mVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_BYSTATUS);
			pstmt.setInt(1, memstatus ? 1 : 0);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mVO = new MembersVO();
				mVO.setMemno(rs.getInt("mem_no"));
				mVO.setMemstatus(rs.getBoolean("mem_status"));
				mVO.setMemname(rs.getString("mem_name"));
				mVO.setMemmail(rs.getString("mem_mail"));
				mVO.setMemaccount(rs.getString("mem_account"));
				mVO.setMempass(rs.getString("mem_pass"));
				mVO.setMemgender(rs.getInt("mem_gender"));
				mVO.setMemid(rs.getString("mem_id"));
				mVO.setMembir(rs.getDate("mem_bir"));
				mVO.setMemphone(rs.getString("mem_phone"));
				mVO.setMemaddress(rs.getString("mem_address"));
				mVO.setMemdate(rs.getTimestamp("mem_date"));
				mVO.setMemcaptcha(rs.getString("mem_captcha"));// mem_captcha
				mVO.setMempicture(rs.getBytes("mem_picture"));
				list.add(mVO);
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
	public MembersVO getOneBymemno(Integer memno) {
		MembersVO mVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_BYMEMNO);
			pstmt.setInt(1, memno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mVO = new MembersVO();
				mVO.setMemno(rs.getInt("mem_no"));
				mVO.setMemstatus(rs.getBoolean("mem_status"));
				mVO.setMemname(rs.getString("mem_name"));
				mVO.setMemmail(rs.getString("mem_mail"));
				mVO.setMemaccount(rs.getString("mem_account"));
				mVO.setMempass(rs.getString("mem_pass"));
				mVO.setMemgender(rs.getInt("mem_gender"));
				mVO.setMemid(rs.getString("mem_id"));
				mVO.setMembir(rs.getDate("mem_bir"));
				mVO.setMemphone(rs.getString("mem_phone"));
				mVO.setMemaddress(rs.getString("mem_address"));
				mVO.setMemdate(rs.getTimestamp("mem_date"));
				mVO.setMemcaptcha(rs.getString("mem_captcha"));
				mVO.setMempicture(rs.getBytes("mem_picture"));

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
		return mVO;
	}

	@Override
	public MembersVO getOneBymemaccount(String memaccount) {
		MembersVO mVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_BYMEMACCOUNT);
			pstmt.setString(1, memaccount);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				mVO = new MembersVO();
				mVO.setMemno(rs.getInt("mem_no"));
				mVO.setMemstatus(rs.getBoolean("mem_status"));
				mVO.setMemname(rs.getString("mem_name"));
				mVO.setMemmail(rs.getString("mem_mail"));
				mVO.setMemaccount(rs.getString("mem_account"));
				mVO.setMempass(rs.getString("mem_pass"));
				mVO.setMemgender(rs.getInt("mem_gender"));
				mVO.setMemid(rs.getString("mem_id"));
				mVO.setMembir(rs.getDate("mem_bir"));
				mVO.setMemphone(rs.getString("mem_phone"));
				mVO.setMemaddress(rs.getString("mem_address"));
				mVO.setMemdate(rs.getTimestamp("mem_date"));
				mVO.setMemcaptcha(rs.getString("mem_captcha"));
				mVO.setMempicture(rs.getBytes("mem_picture"));
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
		return mVO;
	}

	@Override
	public void delete(Integer memno) {
		int updateCount_MEM = 0;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);

			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, memno);

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
