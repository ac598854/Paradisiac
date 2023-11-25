package com.paradisiac.product.rowmapper;

import com.paradisiac.product.model.Members;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberRowMapper implements RowMapper<Members> {
	
	@Override
    public Members mapRow(ResultSet rs, int rowNum) throws SQLException {
        Members member = new Members();
        member.setMemno(rs.getInt("mem_no"));
        member.setMemName(rs.getString("mem_name"));
        member.setMemPhone(rs.getString("mem_phone"));
        member.setMemAddress(rs.getString("mem_address"));
        return member;
    }
}

