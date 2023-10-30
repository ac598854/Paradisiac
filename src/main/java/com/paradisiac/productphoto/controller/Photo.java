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

		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("Big5"); // 處理中文檔名
			res.setContentType("text/html; charset=Big5");
			Collection<Part> parts = req.getParts(); // Servlet3.0新增了Part介面，讓我們方便的進行檔案上傳處理

			for (Part part : parts) {
				String filename = part.getSubmittedFileName();
				if (filename!= null && filename.length()!=0 && part.getContentType()!=null) {
					InputStream in = part.getInputStream();
					byte[] buf = new byte[in.available()];   // byte[] buf = in.readAllBytes();  // Java 9 的新方法
					in.read(buf);
					in.close();

				}
			}
		}
	}

