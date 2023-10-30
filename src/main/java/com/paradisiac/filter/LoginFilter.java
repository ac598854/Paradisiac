package com.paradisiac.filter;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import com.paradisiac.members.model.*;

public class LoginFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws ServletException, IOException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		// 【取得 session】
		HttpSession session = req.getSession();
		// 【從 session 取得memno屬性】
		Object memno = session.getAttribute("memno");
		
		if (memno == null) {//如果memno是null，表示使用者未登入
			session.setAttribute("location", req.getRequestURI());//將當前請求的URI存入Session中，以便稍後重定向後能夠知道用戶原來要訪問的頁面。
			System.out.println(req.getRequestURI());
			res.sendRedirect(req.getContextPath() + "/front-end/members/Login.jsp");
			return;//return表示不再執行過濾器鏈，即結束過濾器的執行。
		} else {
			chain.doFilter(request, response);
			
		}
	}
}