//package com.paradisiac.product.model;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.*;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.naming.NamingException;
//import javax.sql.DataSource;
//
//public class ProductDAO implements ProductDAO_interface{
//	private static DataSource ds = null;
//
//	static {
//		try {
//			Context ctx = new InitialContext();
//			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB3");
//		} catch (NamingException e) {
//			e.printStackTrace();
//		}
//	}
//
//	private static final String INSERT_STMT = "INSERT INTO product(product_category_no, product_name, product_price, product_quantity, product_status, product_total_review_count, product_total_review_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
//	private static final String UPDATE = "UPDATE product set product_category_no=?, product_name=?, product_price=?, product_quantity=?, product_status=?, product_total_review_count=?, product_total_review_status=? where product_no = ?";
//	private static final String DELETE = "DELETE FROM product where product_no = ?";
//	private static final String GET_ONE_STMT = "SELECT product_no,product_category_no,product_name,product_price,product_quantity,product_status,product_total_review_count,product_total_review_status FROM product where product_no = ?";
//	private static final String GET_ALL_STMT = "SELECT product_no,product_category_no,product_name,product_price,product_quantity,product_status,product_total_review_count,product_total_review_status FROM product order by product_no";
//
//	@Override
//	public void insert(ProductVO productVO) {
//		// TODO Auto-generated method stub
//		//?��增�?��??
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(INSERT_STMT);
//
//			pstmt.setInt(1, productVO.getProductcategoryno());
//			pstmt.setString(2, productVO.getProductname());
//			pstmt.setInt(3, productVO.getProductprice());
//			pstmt.setInt(4, productVO.getProductquantity());
//			pstmt.setInt(5, productVO.getProductstatus());
//			pstmt.setInt(6, productVO.getProducttotalreviewcount());
//			pstmt.setInt(7, productVO.getProducttotalreviewstatus());
//
//			pstmt.executeUpdate();
//
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally {
//			if(pstmt != null) {
//				try {
//					pstmt.close();
//				}catch(SQLException se){
//					se.printStackTrace(System.err);
//				}
//			}
//			if(con != null) {
//				try {
//					con.close();
//				}catch(Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//
//	}
//
//	@Override
//	public void update(ProductVO productVO) {
//		// TODO Auto-generated method stub
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(UPDATE);
//
//			pstmt.setInt(1, productVO.getProductcategoryno());
//			pstmt.setString(2, productVO.getProductname());
//			pstmt.setInt(3, productVO.getProductprice());
//			pstmt.setInt(4, productVO.getProductquantity());
//			pstmt.setInt(5, productVO.getProductstatus());
//			pstmt.setInt(6, productVO.getProducttotalreviewcount());
//			pstmt.setInt(7, productVO.getProducttotalreviewstatus());
//			pstmt.setInt(8, productVO.getProductno());
//
//
//			pstmt.executeUpdate();
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		}finally {
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
//
//	@Override
//	public void delete(Integer productno) {
//		// TODO Auto-generated method stub
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setInt(1, productno);
//
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
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
//
//	@Override
//	public ProductVO findByPrimaryKey(Integer productno) {
//		// TODO Auto-generated method stub
//		ProductVO productVO = null;
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ONE_STMT);
//
//			pstmt.setInt(1, productno);
//
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// productVo 也稱?�� Domain objects
//				productVO = new ProductVO();
//				productVO.setProductno(rs.getInt("product_no"));
//				productVO.setProductcategoryno(rs.getInt("product_category_no"));
//				productVO.setProductname(rs.getString("product_name"));
//				productVO.setProductprice(rs.getInt("product_price"));
//				productVO.setProductquantity(rs.getInt("product_quantity"));
//				productVO.setProductstatus(rs.getInt("product_status"));
//				productVO.setProducttotalreviewcount(rs.getInt("product_total_review_count"));
//				productVO.setProducttotalreviewstatus(rs.getInt("product_total_review_status"));
//			}
//
//		} catch (SQLException se) {
//			// TODO Auto-generated catch block
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		}finally {
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
//		}return productVO;
//	}
//
//	@Override
//	public List<ProductVO> getAll() {
//		// TODO Auto-generated method stub
//		List<ProductVO> list = new ArrayList<ProductVO>();
//		ProductVO productVO = null;
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_ALL_STMT);
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) {
//				// productVo 也稱?�� Domain objects
//				productVO = new ProductVO();
//				productVO.setProductno(rs.getInt("product_no"));
//				productVO.setProductcategoryno(rs.getInt("product_category_no"));
//				productVO.setProductname(rs.getString("product_name"));
//				productVO.setProductprice(rs.getInt("product_price"));
//				productVO.setProductquantity(rs.getInt("product_quantity"));
//				productVO.setProductstatus(rs.getInt("product_status"));
//				productVO.setProducttotalreviewcount(rs.getInt("product_total_review_count"));
//				productVO.setProducttotalreviewstatus(rs.getInt("product_total_review_status"));
//				list.add(productVO); // Store the row in the list
//			}
//
//		} catch (SQLException se) {
//			// TODO Auto-generated catch block
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		}finally {
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
//		}return list;
//	}
//
//}
