package com.paradisiac.employee.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.paradisiac.employee.model.EmpDAO_interface;
import com.paradisiac.employee.model.EmpVO;
import com.paradisiac.department.model.DeptVO;
import com.paradisiac.department.service.*;


public class EmpJDBCDAO implements EmpDAO_interface{
	static String driver = "com.mysql.cj.jdbc.Driver";
	static String url = "jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei";
	static String userid = "root";
	static String passwd = "123456";

	private static final String INSERT_STMT = 
		"INSERT INTO employee (emp_no,dept_no,emp_status,emp_name,emp_mail,emp_account,emp_pass,emp_gender,emp_phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM employee order by emp_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM employee where emp_no = ?";
	private static final String DELETE = 
		"DELETE FROM employee where emp_no = ?";
	private static final String UPDATE = 
		"UPDATE employee set dept_no=? ,emp_status=? ,emp_name=? ,emp_mail=? ,emp_account=? ,emp_pass=? ,emp_gender=? ,emp_phone=? where emp_no = ?";
	//載入驅動==========================================================
	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		}
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
	//===新增==================================================================	
	@Override
	public void insert(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, empVO.getEmpno());
			pstmt.setInt(2,empVO.getDept().getDeptNo());
			//pstmt.setInt(2,empVO.getDeptno());
			pstmt.setInt(3,empVO.getEmpStatus());
			pstmt.setString(4,empVO.getEmpName());
			pstmt.setString(5,empVO.getEmpMail());
			pstmt.setString(6,empVO.getEmpAccount());
			pstmt.setString(7,empVO.getEmpPass());
			pstmt.setInt(8,empVO.getEmpGender());
			pstmt.setString(9,empVO.getEmpPhone());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, rs);
		}
		
	}
	//===修改==================================================================	
	@Override
	public void update(EmpVO empVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(9,empVO.getEmpno());
			pstmt.setInt(1,empVO.getDept().getDeptNo());
			pstmt.setInt(2,empVO.getEmpStatus());
			pstmt.setString(3,empVO.getEmpName());
			pstmt.setString(4,empVO.getEmpMail());
			pstmt.setString(5,empVO.getEmpAccount());
			pstmt.setString(6,empVO.getEmpPass());
			pstmt.setInt(7,empVO.getEmpGender());
			pstmt.setString(8,empVO.getEmpPhone());	

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, rs);
		}
		
	}
	//===刪除==================================================================	
	@Override
	public void delete(Integer empno) {
		// TODO Auto-generated method stub
		
	}
	//===查單筆==================================================================	
	@Override
	public EmpVO findByPrimaryKey(Integer empno) {
		EmpVO empVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DeptService deptSvc = new DeptServiceImpl();

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, empno); //一個?代表PK

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects, 拿"table欄位"的value
				empVO = new EmpVO();				
				empVO.setEmpno(rs.getInt("emp_no"));

				DeptVO deptVO = deptSvc.getDeptByDeptno(rs.getInt("dept_no"));
				empVO.setDeptVO(deptVO);

				empVO.setEmpStatus(rs.getInt("emp_status"));
				empVO.setEmpName(rs.getString("emp_name"));
				empVO.setEmpMail(rs.getString("emp_mail"));
				empVO.setEmpAccount(rs.getString("emp_account"));
				empVO.setEmpPass(rs.getString("emp_pass"));
				empVO.setEmpGender(rs.getInt("emp_gender"));
				empVO.setEmpPhone(rs.getString("emp_phone"));

			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, rs);
		}
		
		return empVO; //把屬性打包好回傳一個"員工物件"
	}
	//===查全部==================================================================	
	@Override
	//將查詢所有員工視為與資料庫連線寫在dao中, 由addList.jsp建立的dao來取得
	public List<EmpVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<EmpVO> list = new ArrayList<EmpVO>();
		EmpVO empVO = null;
		DeptService deptSvc = new DeptServiceImpl();
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				empVO = new EmpVO();				
				empVO.setEmpno(rs.getInt("emp_no"));
				
				DeptVO deptVO = deptSvc.getDeptByDeptno(rs.getInt("dept_no"));
				//deptVO.setDeptNo(rs.getInt("dept_no"));
				empVO.setDeptVO(deptVO);
				
				//empVO.setDeptno(rs.getInt("dept_no"));
				empVO.setEmpStatus(rs.getInt("emp_status"));
				empVO.setEmpName(rs.getString("emp_name"));
				empVO.setEmpMail(rs.getString("emp_mail"));
				empVO.setEmpAccount(rs.getString("emp_account"));
				empVO.setEmpPass(rs.getString("emp_pass"));
				empVO.setEmpGender(rs.getInt("emp_gender"));
				empVO.setEmpPhone(rs.getString("emp_phone"));
				
				list.add(empVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			closeResources(con, pstmt, rs);
		}
		return list;
	}

	



}
