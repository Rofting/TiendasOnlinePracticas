<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Products" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.ProductsDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Products" %>
<%@ page import="com.svalero.tiendaonlinepracticas.util.CurrencyUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.tiendaonlinepracticas.util.DateUtils" %>
<%@include file="includes/header.jsp"%>
<head>
    <link href="style.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
</head>
<main>
    <%
        try {
            Database.connect();
            } catch (ClassNotFoundException e) {
                throw new RuntimeException(e);
            } catch (SQLException e) {
                throw new RuntimeException(e);
         }
        int id_product = Integer.parseInt(request.getParameter("id_product"));
        Products products = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getOneProducts(id_product));
    %>
    <div class="py-5 container">
        <div class="d-grid gap-2 d-md-flex justify-content-md-end ">
            <%
                if (!role.equals("anonymous")) {
            %>
                <p class="text-danger"><%= username_init%></p>
            <%
                }
            %>
        </div>
    </div>

    <div class="container my-3">
        <div class="row">
            <div class="col-sm-12  col-md-4 col-lg-4 col-xl-4 py-4 bg-image2">
                <h3 class="text-danger">Foto del producto</h3>
                <div class="card shadow-sm">
                    <img src="../practicas_pictures/<%=products.getImage()%>"  alt="<%= products.getDescription() %>"/>
                    <div class="btn-group">
                        <%if (products.getStock_units() == 0) { %>
                            <div class="btn btn-sm btn-outline-danger">Out of stock</div>
                        <%} else {%>
                            <%
                                if (role.equals("anonymous")) {
                            %>
                                <a href="login.jsp"  type="button" class="btn btn-sm btn-outline-danger">Log In to Buy</a>
                            <% } else {%>
                                <%
                                    if (!role.equals("admin")) {
                                %>
<%--                        solo daremos la opcion de compra si no eres administrador y estas registrado, es decir un usuario normal--%>
<%--                                    <a href="#"  type="button" class="btn btn-sm btn-outline-danger">Comprar</a>--%>
                                    <a href="place-an-order?id_product=<%= products.getId_product()%>"  type="button" class="btn btn-sm btn-outline-danger">Comprar</a>
                                <%
                                    }
                                %>
                            <%
                                }
                            %>

                        <%}%>
                    </div>
                </div>
            </div>
            <div class="col-sm-12  col-md-8 col-lg-8 col-xl-8 py-4 bg-image2">
                <h3 class="text-danger">Product Data</h3>
                <table class="table table-dark table-striped">
                    <tr>
                        <td class="centrado">Name</td>
                        <td class="centrado"><%=products.getProduct_name()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Description</td>
                        <td class="centrado"><%=products.getDescription()%></td>
                    </tr>

                    <tr>
                        <td class="centrado">Release Date</td>
                        <td class="centrado"><%=DateUtils.formatUser(products.getRelease_date())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Product Status</th>
                        <td class="centrado"><%=products.getProduct_status()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Price</td>
                        <td class="centrado"><%=CurrencyUtils.format(products.getSale_price())%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Stocks Units</th>
                        <%
                            String mensaje_stock_units;
                            if (products.getStock_units() == 0) {
                                mensaje_stock_units = "Out of stock";
                            } else {
                                mensaje_stock_units = String.valueOf(products.getStock_units());
                            }
                        %>
                        <td class="centrado"><%=mensaje_stock_units%></td>
                    </tr>
                </table>

            </div>
        </div>
        <br/>
        <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
    </div>
</main>

<%@include file="includes/footer.jsp"%>


