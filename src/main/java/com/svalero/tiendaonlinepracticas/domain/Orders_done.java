package com.svalero.tiendaonlinepracticas.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Orders_done {
    private int id_order;
    private Date order_date;
    private float total_price;
    private int id_product;
    private int id_user;

}


