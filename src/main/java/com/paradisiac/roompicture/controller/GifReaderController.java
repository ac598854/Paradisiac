package com.paradisiac.roompicture.controller;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DBGifReader2")
public class GifReaderController extends HttpServlet{
	Connection con;
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();

		try {
			Statement stmt = con.createStatement();
			String picno = req.getParameter("picno");
			ResultSet rs = stmt.executeQuery(
				"select pic from cha103g2.room_picture where picture_no ='"+picno+"'");

			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("pic"));
				//BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream(1));  //寫(1)也可以
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);   //404錯誤 --> P324 --> P134
 			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}

	public void init() throws ServletException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cha103g2?serverTimezone=Asia/Taipei", "root", "cha103");
		} catch (ClassNotFoundException e) {
			throw new UnavailableException("Couldn't load JdbcOdbcDriver");
		} catch (SQLException e) {
			throw new UnavailableException("Couldn't get db connection");
		}
	}

	public void destroy() {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
	}
	
}
