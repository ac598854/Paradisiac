package com.paradisiac.department.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.paradisiac.department.model.DeptVO;
import com.paradisiac.employee.model.EmpVO;


public class DeptJDBCDAO implements DeptDAO_interface{
	private static final String INSERT_STMT = "INSERT INTO department(dept_no, dept_name) VALUES (?, ?)";
	private static final String UPDATE_STMT = "UPDATE department SET dept_name = ? WHERE dept_no = ?";
	private static final String DELETE_STMT = "DELETE FROM department WHERE dept_no = ?";
	private static final String FIND_BY_PK = "SELECT * FROM department WHERE dept_no = ?";
	private static final String GET_ALL = "SELECT * FROM department";
	
	static String driver = "com.mysql.cj.jdbc.Driver";
	static String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	static String userid = "root";
	static String passwd = "cha10312";
	
	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		}
	}
	//新增==========================================================
	@Override
	public Integer insert(DeptVO deptVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, deptVO.getDeptNo());
			pstmt.setString(2, deptVO.getDeptName());
			
			pstmt.executeUpdate();
			return 1;
		} catch (SQLException se) {
			se.printStackTrace();
			
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, null);
		}
		return -1;
		
	}
	//修改==========================================================
	@Override
	public DeptVO update(DeptVO deptVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, deptVO.getDeptName());
			pstmt.setInt(2, deptVO.getDeptNo());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			se.printStackTrace();
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, null);
		}
		return deptVO;
		
	}
	//刪除==========================================================
	@Override
	public Integer delete(Integer deptNo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE_STMT);
			
			pstmt.setInt(1, deptNo);

			pstmt.executeUpdate();
			return 1;
		} catch (SQLException se) {
			se.printStackTrace();
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, null);
		}
		return -1;
	}
	//查單筆==========================================================
	@Override
	public DeptVO findByPrimaryKey(Integer deptNo) {
		DeptVO deptvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(FIND_BY_PK);
			
			pstmt.setInt(1, deptNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				deptvo = new DeptVO();
				deptvo.setDeptNo(rs.getInt("dept_no"));
				deptvo.setDeptName(rs.getString("dept_name"));
			}
		} catch (SQLException se) {
			se.printStackTrace();
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, null);
		}
		return deptvo;

	}
	//查多筆==========================================================
	@Override
	public List<DeptVO> getAll() {
		List<DeptVO> deptList = new ArrayList<>();
		DeptVO deptVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				deptVO = new DeptVO(); //new一個DeptVO物件
				deptVO.setDeptNo(rs.getInt("dept_no")); //把查詢結果rs的deptNo塞給deptVO物件(型別是DeptVO)
				deptVO.setDeptName(rs.getString("dept_name")); //塞deptName
				deptList.add(deptVO); //塞完值的deptVO放進deptList集合中, 這個集合只能放DeptVO物件
			}

		} catch (SQLException se) {
			se.printStackTrace();
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, rs);
		}
		return deptList;
	}
	
	//關閉連線方法==========================================================
	private void closeResources(Connection con, PreparedStatement pstmt, ResultSet rs) {
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
	
	//===============main方法===============================
	public static void main(String[] args) {
		DeptDAO_interface dao = new DeptJDBCDAO();

		//新增
//		DeptVO deptVO1 = new DeptVO();
//		deptVO1.setDeptNo(105);
//		deptVO1.setDeptName("採購部");
//
//		dao.insert(deptVO1);
		
		//修改
//		DeptVO deptVO2 = new DeptVO();
//		deptVO2.setDeptNo(106);
//		deptVO2.setDeptName("生管部");
//
//		dao.update(deptVO2);
		
		//刪除
//		dao.delete(106);
		
		//查單筆
//		DeptVO deptVO3 = dao.findByPrimaryKey(101);
//		System.out.print(deptVO3.getDeptNo() + ",");
//		System.out.print(deptVO3.getDeptName());
		
		//查多筆
//		List<DeptVO> list = dao.getAll();
//		for (DeptVO deptVO : list) { //把list中的DeptVO物件印出
//			System.out.print(deptVO.getDeptNo() + ","); //印DeptNo
//			System.out.print(deptVO.getDeptName()); //印DeptName
//			System.out.println();
//		}
		
	}
	@Override
	public List<DeptVO> getAll(int currentPage) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public long getTotal() {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<DeptVO> getDeptsList() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Set<EmpVO> findByPrimaryKeyE(Integer deptNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
