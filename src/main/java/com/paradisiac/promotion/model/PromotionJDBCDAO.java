package com.paradisiac.promotion.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PromotionJDBCDAO implements PromotionDAO_interface{
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/paradisiac?serverTimezone=Asia/Taipei";
		String userid = "root";
		String passwd = "1234567";
		
		private static final String INSERT_STMT = 
				"INSERT INTO  promotion(promotion_name,promotion_describition,promotion_start_date,promotion_end_date,promotion_discount,promotion_status)VALUES (?, ?, ?, ?, ?, ?)";
			private static final String GET_ALL_STMT = 
				"SELECT promotion_no,promotion_name,promotion_describition,promotion_start_date,promotion_end_date,promotion_discount,promotion_status FROM promotion order by promotion_no";
			private static final String GET_ONE_STMT = 
				"SELECT promotion_no,promotion_name,promotion_describition,promotion_start_date,promotion_end_date,promotion_discount,promotion_status FROM promotion where promotion_no = ?";
			private static final String DELETE = 
				"DELETE FROM promotion where promotion_no = ?";
			private static final String UPDATE = 
				"UPDATE promotion set  promotion_name=?, promotion_describition=?, promotion_start_date=?, promotion_end_date=?, promotion_discount=?,promotion_status=?  where promotion_no = ?";
			@Override
			public void insert(PromotionVO proVO) {
				Connection con = null;
				PreparedStatement pstmt = null;

				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(INSERT_STMT);

					
					pstmt.setString(1, proVO.getProname());
					pstmt.setString(2, proVO.getProdes());
					pstmt.setDate(3, proVO.getStartdate());
					pstmt.setDate(4, proVO.getEnddate());
					pstmt.setDouble(5, proVO.getDiscount());
					pstmt.setInt(6, proVO.getStatus());

					pstmt.executeUpdate();

					// Handle any SQL errors
				}  catch (ClassNotFoundException e) {
					throw new RuntimeException("Couldn't load database driver. "
							+ e.getMessage());
					// Handle any SQL errors
				} catch (SQLException se) {
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
			public void update(PromotionVO proVO) {
				Connection con = null;
				PreparedStatement pstmt = null;

				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(UPDATE);

					
					pstmt.setString(1, proVO.getProname());
					pstmt.setString(2, proVO.getProdes());
					pstmt.setDate(3, proVO.getStartdate());
					pstmt.setDate(4, proVO.getEnddate());
					pstmt.setDouble(5, proVO.getDiscount());
					pstmt.setInt(6, proVO.getStatus());
					pstmt.setInt(7, proVO.getProno());
					
					pstmt.executeUpdate();

					// Handle any driver errors
				} catch (ClassNotFoundException e) {
					throw new RuntimeException("Couldn't load database driver. "
							+ e.getMessage());
					// Handle any SQL errors
				}catch (SQLException se) {
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
			public void delete(Integer prono) {
				Connection con = null;
				PreparedStatement pstmt = null;

				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(DELETE);

					pstmt.setInt(1, prono);

					pstmt.executeUpdate();

					// Handle any driver errors
				} catch (ClassNotFoundException e) {
					throw new RuntimeException("Couldn't load database driver. "
							+ e.getMessage());
					// Handle any SQL errors
				}catch (SQLException se) {
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
			public PromotionVO findByPrimaryKey(Integer prono) {
				PromotionVO proVO = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(GET_ONE_STMT);

					pstmt.setInt(1, prono);

					rs = pstmt.executeQuery();

					while (rs.next()) {
						proVO = new PromotionVO();
						proVO.setProno(rs.getInt("promotion_no"));
						proVO.setProname(rs.getString("promotion_name"));
						proVO.setProdes(rs.getString("promotion_describition"));
						proVO.setStartdate(rs.getDate("promotion_start_date"));
						proVO.setEnddate(rs.getDate("promotion_end_date"));
						proVO.setDiscount(rs.getDouble("promotion_discount"));
						proVO.setStatus(rs.getInt("promotion_status"));
						
					}

					// Handle any driver errors
				} catch (ClassNotFoundException e) {
					throw new RuntimeException("Couldn't load database driver. "
							+ e.getMessage());
					// Handle any SQL errors
				}catch (SQLException se) {
					throw new RuntimeException("A database error occured. "
							+ se.getMessage());
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
				return proVO;
			}
				
			
			@Override
			public List<PromotionVO> getAll() {
				List<PromotionVO> list = new ArrayList<PromotionVO>();
				PromotionVO proVO = null;

				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(GET_ALL_STMT);
					rs = pstmt.executeQuery();

					while (rs.next()) {
						proVO = new PromotionVO();
						proVO.setProno(rs.getInt("promotion_no"));
						proVO.setProname(rs.getString("promotion_name"));
						proVO.setProdes(rs.getString("promotion_describition"));
						proVO.setStartdate(rs.getDate("promotion_start_date"));
						proVO.setEnddate(rs.getDate("promotion_end_date"));
						proVO.setDiscount(rs.getDouble("promotion_discount"));
						proVO.setStatus(rs.getInt("promotion_status"));
						list.add(proVO); // Store the row in the list
					}

					// Handle any driver errors
				} catch (ClassNotFoundException e) {
					throw new RuntimeException("Couldn't load database driver. "
							+ e.getMessage());
					// Handle any SQL errors
				}catch (SQLException se) {
					throw new RuntimeException("A database error occured. "
							+ se.getMessage());
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