package com.paradisiac.util.jedispool;
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


	public static void set(String key, String value) {//同樣key會覆蓋原資料
	    JedisPool pool = getJedisPool();
	    try (Jedis jedis = pool.getResource()) {
	        jedis.set(key, value);
	    }
	}
	
	public static String get(String key) {
		String result="";
	    JedisPool pool = getJedisPool();
	    try (Jedis jedis = pool.getResource()) {
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
