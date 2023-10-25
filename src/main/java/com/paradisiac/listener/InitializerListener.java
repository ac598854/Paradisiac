package com.paradisiac.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.paradisiac.util.HibernateUtil;



public class InitializerListener implements ServletContextListener{
	
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("context started");
		HibernateUtil.getSessionFactory();
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("context ended");
		HibernateUtil.shutdown();
	}
}