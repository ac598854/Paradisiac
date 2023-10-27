package com.paradisiac.productphoto.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;

@WebServlet("/uploadServlet3.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class Photo extends HttpServlet{

		private static final long serialVersionUID = 1L;
		String saveDirectory = "/images_uploaded"; // 上傳檔案的目的地目錄;
												   // 將由底下的第26~30行用 java.io.File 於 ContextPath 之下, 自動建立目地目錄

		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("Big5"); // 處理中文檔名
			res.setContentType("text/html; charset=Big5");
			PrintWriter out = res.getWriter();

			String realPath = getServletContext().getRealPath(saveDirectory);
			File fsaveDirectory = new File(realPath);
			if (!fsaveDirectory.exists())
				 fsaveDirectory.mkdirs(); // 於 ContextPath 之下,自動建立目地目錄

			Collection<Part> parts = req.getParts(); // Servlet3.0新增了Part介面，讓我們方便的進行檔案上傳處理

			for (Part part : parts) {
				String filename = part.getSubmittedFileName();
				if (filename!= null && filename.length()!=0 && part.getContentType()!=null) {
					File f = new File(fsaveDirectory, filename);

					// 利用File物件,寫入目地目錄,上傳成功
					part.write(f.toString());

					// 額外測試 InputStream 與 byte[] (幫將來model的VO預作準備)
//					InputStream in = part.getInputStream();
//					byte[] buf = new byte[in.available()];   // byte[] buf = in.readAllBytes();  // Java 9 的新方法
//					in.read(buf);
//					in.close();
//					out.println("buffer length: " + buf.length);
					
					out.println("<br><img src=\""+req.getContextPath()+saveDirectory+"/"+filename+"\">");

				}
			}
		}
	}

