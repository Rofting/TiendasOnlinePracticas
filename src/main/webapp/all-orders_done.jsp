<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.ProductsDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.UserDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Products" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Orders_done" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.Orders_doneDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.util.CurrencyUtils" %>
<%@ page import="com.svalero.tiendaonlinepracticas.util.DateUtils" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Order_product_user" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>

    <main>
            <br/>
            <div class="container bg-dark">
                <h2 class="text-danger">List of Orders Made by Users</h2>

                <br/>
                <form class="row g-2" id="search-form" method="GET">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Search in orders" name="search" id="search-input">
                        <button type="submit" class="btn btn-outline-danger"  id="search-button">Search</button>
                    </div>
                </form>
            </div>

            <div class="container my-6 bg-dark">

                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Order Id</th>
                        <th>Order date</th>
                        <th>Product ID</th>
                        <th>Name Product</th>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Total Price</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%
                        if (!role.equals("admin")){
                            response.sendRedirect("/tiendaonlinepracticas");
                        }
                        //Si no eres el administrador no puedes entrar a esta pagina
                        String search = "";
                        if (request.getParameter("search") != null)
                            search = request.getParameter("search");
                        float total_sale=0;
                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        List<Order_product_user> orders_dones = null;
                        if (search.isEmpty()) {
                            orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getAllOrdersUserProduct());
                        } else {
                            final String searchTerm = search;
                            orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getOrders(searchTerm));
                        }

                        for (Order_product_user orders_done : orders_dones) {
                          total_sale=total_sale+orders_done.getTotal_price();
                    %>

                    <tr>
                        <td><%=orders_done.getId_order()%></td>
                        <td><%=DateUtils.formatOrder(orders_done.getOrder_date())%></td>
                        <td><%=orders_done.getId_product()%></td>
                        <td><%=orders_done.getProduct_name()%></td>
                        <td><%=orders_done.getId_user()%></td>
                        <td><%=orders_done.getUsername()%></td>
                        <td><%= CurrencyUtils.format(orders_done.getTotal_price()) %></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th>Total Orders:&nbsp<%= CurrencyUtils.format(total_sale) %></th>
                    </tr>
                    </tbody>
                </table>

                <br/>
                <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
            </div>

        </main>

        <%@include file="includes/footer.jsp"%>

