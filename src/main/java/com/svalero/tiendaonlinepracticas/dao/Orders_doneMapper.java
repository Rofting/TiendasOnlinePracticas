package com.svalero.tiendaonlinepracticas.dao;

import com.svalero.tiendaonlinepracticas.domain.Orders_done;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Orders_doneMapper implements RowMapper<Orders_done> {
    @Override
    public Orders_done map(ResultSet rs, StatementContext ctx) throws SQLException {


        return new Orders_done(rs.getInt("id_order"),
                rs.getDate("order_date"),
                rs.getFloat("total_price"),
                rs.getInt("id_product"),
                rs.getString("product_name"),
                rs.getString("supplier_name"),
                rs.getInt("id_user"),
                rs.getString("username"));

    }
}
