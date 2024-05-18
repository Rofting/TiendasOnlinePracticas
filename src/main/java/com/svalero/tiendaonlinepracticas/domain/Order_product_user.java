package com.svalero.tiendaonlinepracticas.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order_product_user {
    private int id_order;
    private Date order_date;
    private float total_price;
    private int id_product;
    private String product_name;
    private int id_user;
    private String username;

}
