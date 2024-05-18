package com.svalero.tiendaonlinepracticas.dao;

import com.svalero.tiendaonlinepracticas.domain.Order_product_user;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Order_product_userMapper implements RowMapper<Order_product_user> {
    @Override
    public Order_product_user map(ResultSet rs, StatementContext ctx) throws SQLException {


        return new Order_product_user(rs.getInt("id_order"),
                rs.getDate("order_date"),
                rs.getFloat("total_price"),
                rs.getInt("id_product"),
                rs.getString("product_name"),
                rs.getInt("id_user"),
                rs.getString("username"));

    }
}
