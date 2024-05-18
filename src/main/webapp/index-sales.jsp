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

<head>
    <link href="style.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
</head>
        <main>
            <%
                if (request.getSession().getAttribute("id_user") == null) {
                    response.sendRedirect("index.jsp");
                }
                        //Si no eres un usuario registrado no puedes entrar a esta pagina
            %>
            <br/>
            <div class="container bg-dark">
                <h2 class="text-danger">List of Products Ordered By <%=username_init%></h2>

                <br/>

            </div>

            <div class="container my-6 bg-dark">

                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Order Id</th>
                        <th>Order Date</th>
                        <th>Product Id</th>
                        <th>Product Name</th>
                        <th>Total Price</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        final int finaluser_id = user_id;
                        List<Order_product_user> orders_dones = Database.jdbi.withExtension(Orders_doneDao.class, dao -> dao.getOrders_doneByUser(finaluser_id));

                    %>
                    <%
                        for (Order_product_user orders_done : orders_dones) {

                    %>
                    <tr>
                        <td><%=orders_done.getId_order()%></td>
                        <td><%=DateUtils.formatOrder(orders_done.getOrder_date())%></td>
                        <td><%=orders_done.getId_product()%></td>
                        <td><%=orders_done.getProduct_name()%></td>
                        <td><%= CurrencyUtils.format(orders_done.getTotal_price()) %></td>

                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <br/>
                <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
            </div>

        </main>

        <%@include file="includes/footer.jsp"%>

