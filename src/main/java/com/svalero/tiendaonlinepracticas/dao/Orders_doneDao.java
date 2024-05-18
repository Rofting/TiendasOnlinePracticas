package com.svalero.tiendaonlinepracticas.dao;

import com.svalero.tiendaonlinepracticas.domain.Order_product_user;
import com.svalero.tiendaonlinepracticas.domain.Orders_done;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface Orders_doneDao {

    @SqlQuery("SELECT id_order, order_date, total_price, p.id_product,  p.product_name, u.id_user, u.username from orders_done od join   products p on od.id_product = p.id_product join users u on u.id_user = od.id_user WHERE od.id_user = ? order by id_order,order_date")
    @UseRowMapper(Order_product_userMapper.class)
    List<Order_product_user> getOrders_doneByUser(int id_user);

    @SqlQuery("SELECT * FROM orders_done order by order_date, total_price")
    @UseRowMapper(Orders_doneMapper.class)
    List<Orders_done> getAllOrders();

    @SqlQuery("SELECT id_order, order_date, total_price, p.id_product,  p.product_name, u.id_user, u.username from orders_done od join   products p on od.id_product = p.id_product join users u on u.id_user = od.id_user")
    @UseRowMapper(Order_product_userMapper.class)
    List<Order_product_user> getAllOrdersUserProduct();

    @SqlQuery("SELECT * FROM orders_done WHERE id_order = ?")
    @UseRowMapper(Orders_doneMapper.class)
    Orders_done getOrders_done(int id_order);

    @SqlQuery("SELECT id_order, order_date, total_price, p.id_product,  p.product_name, u.id_user, u.username from orders_done od join \n" +
            "    products p on od.id_product = p.id_product join" +
            "    users u on u.id_user = od.id_user WHERE product_name LIKE '%'||:searchTerm||'%'" +
            "OR username LIKE '%'||:searchTerm||'%'" +
            "OR TO_CHAR(order_date, 'DD-MM-YYYY') LIKE '%'||:searchTerm||'%' order by order_date, total_price")
    @UseRowMapper(Order_product_userMapper.class)
    List<Order_product_user> getOrders(@Bind("searchTerm") String searchTerm);

    @SqlUpdate("INSERT INTO orders_done (order_date, total_price, id_product," +
            "id_user) VALUES (?, ?, ?, ?)")
    int addOrders_done(Date order_date,float total_price, int id_product,int id_user);

}

