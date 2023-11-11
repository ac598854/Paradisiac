package com.paradisiac.product.rowmapper;

import com.paradisiac.product.model.Order;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderRowMapper implements RowMapper<Order> {

    @Override
    public Order mapRow(ResultSet rs, int i) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setMemNo(rs.getInt("mem_no"));
        order.setTotalAmount(rs.getInt("total_amount"));
        order.setOrderName(rs.getString("order_name"));
        order.setOrderPhone(rs.getInt("order_phone"));
        order.setAddress(rs.getString("address"));
        order.setCreatedDate(rs.getTimestamp("created_date"));
        order.setLastModifiedDate(rs.getTimestamp("last_modified_date"));

        return order;
    }
}
