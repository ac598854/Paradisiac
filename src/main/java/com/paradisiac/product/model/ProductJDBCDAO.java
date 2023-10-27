package com.paradisiac.product.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductJDBCDAO implements ProductDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/cha103_g2?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "811158tall";

	private static final String INSERT_STMT = "INSERT INTO product(product_category_no, product_name, product_price, product_quantity, product_status, product_total_review_count, product_total_review_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE = "UPDATE product set product_category_no=?, product_name=?, product_price=?, product_quantity=?, product_status=?, product_total_review_count=?, product_total_review_status=? where product_no = ?";
	private static final String DELETE = "DELETE FROM product where product_no = ?";
	private static final String GET_ONE_STMT = "SELECT product_no,product_category_no,product_name,product_price,product_quantity,product_status,product_total_review_count,product_total_review_status FROM product where product_no = ?";
	private static final String GET_ALL_STMT = "SELECT product_no,product_category_no,product_name,product_price,product_quantity,product_status,product_total_review_count,product_total_review_status FROM product order by product_no";

	@Override
	public void insert(ProductVO productVO) {
		// TODO Auto-generated method stub
		// ?��增�?��??
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, productVO.getProductcategoryno());
			pstmt.setString(2, productVO.getProductname());
			pstmt.setInt(3, productVO.getProductprice());
			pstmt.setInt(4, productVO.getProductquantity());
			pstmt.setInt(5, productVO.getProductstatus());
			pstmt.setInt(6, productVO.getProducttotalreviewcount());
			pstmt.setInt(7, productVO.getProducttotalreviewstatus());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void update(ProductVO productVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, productVO.getProductcategoryno());
			pstmt.setString(2, productVO.getProductname());
			pstmt.setInt(3, productVO.getProductprice());
			pstmt.setInt(4, productVO.getProductquantity());
			pstmt.setInt(5, productVO.getProductstatus());
			pstmt.setInt(6, productVO.getProducttotalreviewcount());
			pstmt.setInt(7, productVO.getProducttotalreviewstatus());
			pstmt.setInt(8, productVO.getProductno());

			pstmt.executeUpdate();
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
	public void delete(Integer productno) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, productno);

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
	public ProductVO findByPrimaryKey(Integer productno) {
		// TODO Auto-generated method stub
		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, productno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// productVo 也稱?�� Domain objects
				productVO = new ProductVO();
				productVO.setProductno(rs.getInt("product_no"));
				productVO.setProductcategoryno(rs.getInt("product_category_no"));
				productVO.setProductname(rs.getString("product_name"));
				productVO.setProductprice(rs.getInt("product_price"));
				productVO.setProductquantity(rs.getInt("product_quantity"));
				productVO.setProductstatus(rs.getInt("product_status"));
				productVO.setProducttotalreviewcount(rs.getInt("product_total_review_count"));
				productVO.setProducttotalreviewstatus(rs.getInt("product_total_review_status"));
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			// TODO Auto-generated catch block
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
		return productVO;
	}

	@Override
	public List<ProductVO> getAll() {
		// TODO Auto-generated method stub
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// productVo 也稱?�� Domain objects
				productVO = new ProductVO();
				productVO.setProductno(rs.getInt("product_no"));
				productVO.setProductcategoryno(rs.getInt("product_category_no"));
				productVO.setProductname(rs.getString("product_name"));
				productVO.setProductprice(rs.getInt("product_price"));
				productVO.setProductquantity(rs.getInt("product_quantity"));
				productVO.setProductstatus(rs.getInt("product_status"));
				productVO.setProducttotalreviewcount(rs.getInt("product_total_review_count"));
				productVO.setProducttotalreviewstatus(rs.getInt("product_total_review_status"));
				list.add(productVO); // Store the row in the list
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		}

		catch (SQLException se) {
			// TODO Auto-generated catch block
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

	public static void main(String[] args) {
		ProductJDBCDAO dao = new ProductJDBCDAO();

//				//單一搜尋
				ProductVO productVO3 = dao.findByPrimaryKey(314);
				System.out.print("商品編號" + productVO3.getProductno() + ",\n");
				System.out.print("商品名稱" + productVO3.getProductname() + ",\n");
				System.out.print("商品價格" + productVO3.getProductprice() + ",\n");
				System.out.print("商品庫存" + productVO3.getProductquantity() + ",\n");
				System.out.print("商品狀態" + productVO3.getProductstatus() + ",\n");
				System.out.print("商品總評價" + productVO3.getProducttotalreviewcount() + ",\n");
				System.out.print("商品評價人數" + productVO3.getProducttotalreviewstatus() + ",\n");
				System.out.println("商品類別編號" + productVO3.getProductcategoryno());
				System.out.println("---------------------");
//				//全部搜尋
//				List<ProductVO> list = dao.getAll();
//				for (ProductVO aProduct : list) {
//					System.out.print(aProduct.getProductno() + ",");
//					System.out.print(aProduct.getProductname() + ",");
//					System.out.print(aProduct.getProductprice() + ",");
//					System.out.print(aProduct.getProductquantity() + ",");
//					System.out.print(aProduct.getProductstatus() + ",");
//					System.out.print(aProduct.getProducttotalreviewcount() + ",");
//					System.out.print(aProduct.getProducttotalreviewstatus() + ",\t");
//					
//					System.out.print(aProduct.getProductcategoryno());
//					System.out.println();
//				}

		// ?���?
				ProductVO productVO1 = new ProductVO();
				
				productVO1.setProductname("巴離");
				productVO1.setProductprice(1000);
				productVO1.setProductquantity(10);
				productVO1.setProductstatus(1);
				productVO1.setProducttotalreviewcount(1);
				productVO1.setProducttotalreviewstatus(1);
				productVO1.setProductcategoryno(6);
				dao.insert(productVO1);

		// 修改
//				ProductVO productVO2 = new ProductVO();
//				productVO2.setProductno(301);
//				productVO2.setProductname("celine");
//				productVO2.setProductprice(14000);
//				productVO2.setProductquantity(100);
//				productVO2.setProductstatus(1);
//				productVO2.setProducttotalreviewcount(1);
//				productVO2.setProducttotalreviewstatus(1);
//				productVO2.setProductcategoryno(7);
//				dao.update(productVO2);

		// ?��?��
//				dao.delete(311);

	}
}
