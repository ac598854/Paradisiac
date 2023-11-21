package com.paradisiac.util.jedispool;

import redis.clients.jedis.BasicCommands;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;


public class JedisUtil {
	// Singleton單例模式
	private static JedisPool pool = null;

	private JedisUtil() {
	}

	public static JedisPool getJedisPool() {
		// double lock
		if (pool == null) {
			synchronized(JedisUtil.class) {
				if (pool == null) {
					JedisPoolConfig config = new JedisPoolConfig();
					config.setMaxTotal(8);
					config.setMaxIdle(8);
					config.setMaxWaitMillis(10000);
					pool = new JedisPool(config, "localhost", 6379);
				
				}
			}
		}
		return pool;
	}

	public static void shutdownJedisPool() {
		if (pool != null)
			pool.destroy();
	}


	public static void set(String key, String value) {//同樣key會覆蓋原資料// 會員註冊驗證信
	    JedisPool pool = getJedisPool();	  
	    try (Jedis jedis = pool.getResource()) {
	    	jedis.select(2);
	    	jedis.set(key, value);
	        
	    }
	}
	
	public static String get(String key) {//取信箱
		String result="";
		JedisPool pool = getJedisPool();	
	    try (Jedis jedis = pool.getResource()) {
	    	jedis.select(2);
	    	result=jedis.get(key);
	    }
	    return result;
	}
	
	
	public static void RestPwdset(String key, String value) {//忘記密碼
	    JedisPool pool = getJedisPool();	  
	    try (Jedis jedis = pool.getResource()) {
	    	jedis.select(1);
	    	jedis.set(key, value);
	        
	    }
	}
	
	public static String RestPwdget(String key) {//忘記密碼//取回帳號
		String result="";
		JedisPool pool = getJedisPool();	
	    try (Jedis jedis = pool.getResource()) {
	    	jedis.select(1);
	    	result=jedis.get(key);
	    }
	    return result;
	}
	
	
	
	public static void expire(String key) {
	    JedisPool pool = getJedisPool();
	    try (Jedis jedis = pool.getResource()) {	
	    	jedis.expire(key, 30);//10秒
	    }
	}




}
