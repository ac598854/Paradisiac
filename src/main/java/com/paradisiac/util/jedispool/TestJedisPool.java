package com.paradisiac.util.jedispool;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class TestJedisPool {
	private static JedisPool pool = null;

	public static void main(String[] args) {
		pool = JedisUtil.getJedisPool();
		Jedis jedis = pool.getResource();
		System.out.println(jedis.ping());

		jedis.close();
		JedisUtil.shutdownJedisPool();
	}

}
