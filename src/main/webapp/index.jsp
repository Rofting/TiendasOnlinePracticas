<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Products" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.ProductsDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.util.CurrencyUtils" %>
<%@ page import="com.svalero.tiendaonlinepracticas.util.DateUtils" %>
<%@include file="includes/header.jsp"%>
<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
</script>


<main>

   <div class="py-5 container">
       <div class="d-grid gap-2 d-md-flex justify-content-md-end ">
           <%
               if (role.equals("anonymous")) {
           %>
           <a href="login.jsp" title="Iniciar sesión"><img src="icons/user1.png" height="50" width="50"/></a>
           <%
           } else {
           %>
           <h4 class="text-danger"><%= username_init%></h4>
           <p><a href="register-user.jsp?id_user=<%=user_id%>" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">&nbsp;&nbsp;Modificar mi Usuario&nbsp;&nbsp;</a></p>
           <a href="logout" title="Cerrar sesión"><img src="icons/exit.png" height="50" width="50"/></a>
           <%
               }
           %>
       </div>
   </div>

    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="text-white"><strong>Vintage Bytes Emporium</strong></h1>

                <%
                    if (role.equals("admin")){
                %>
                    <h3 class="text-white">---Administrator Mode---</h3>
                    <br/>
                        <a href="register-product.jsp" class="btn btn-sm btn-outline-primary" type="button">New product</a>
                        <a href="index-user.jsp" class="btn btn-sm btn-outline-danger" type="button">Admin Users</a>
                        <a href="index-suppliers.jsp" class="btn btn-sm btn-outline-primary" type="button">Admin Suppliers</a>
                        <a href="all-orders_done.jsp" class="btn btn-sm btn-outline-danger" type="button">Orders Done</a>
                <%
                } else {
                %>
                     <h3 class="text-white">---Star Products---</h3>
                <br/>
                <%
                    if (role.equals("user")){
                %>
                    <a href="index-sales.jsp" class="btn btn-sm btn-outline-primary" type="button">See my orders</a>
                <%
                        }
                %>
                <%
                    }
                %>
            </div>
        </div>
    </section>

        <div class="album py-5 bg-body-tertiary bg-image2">
            <div class="container">
                <form class="row g-2" id="search-form" method="GET">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Search in products " name="search" id="search-input">
                        <button type="submit" class="btn btn-outline-danger"  id="search-button">Search</button>
                    </div>
                </form>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                    <%
                        String search = "";
                        if (request.getParameter("search") != null)
                            search = request.getParameter("search");

                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        List<Products> listaproductos = null;
                        if (search.isEmpty()) {
                            listaproductos = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getAllProducts());
                        } else {
                            final String searchTerm = search;
                            listaproductos = Database.jdbi.withExtension(ProductsDao.class, dao -> dao.getProducts(searchTerm));
                        }
                        for (Products products : listaproductos) {
                    %>
                    <div class="col">
                        <div class="card shadow-sm">

                            <img src="../practicas_pictures/<%=products.getImage()%>" style="max-width: 480px;max-height: 360px;"/>
                            <div class="card-body">
                                <p class="card-text"><strong><%= products.getProduct_name() %></strong>&nbsp;&nbsp;&nbsp;Lanzamiento:&nbsp;<strong><%=DateUtils.formatUser(products.getRelease_date())%></strong></p>
                                <p class="card-text"><%= products.getDescription() %> </p>

                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <a href="view-product.jsp?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-primary">View</a>
                                        <%
                                            if (role.equals("admin")){
                                        %>
                                        <a href="register-product.jsp?id_product=<%=products.getId_product()%>"  type="button" class="btn btn-sm btn-outline-primary">Edit</a>
                                        <a href="remove-products?id_product=<%= products.getId_product()%>" type="button" class="btn btn-sm btn-outline-danger">Delete</a>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <small class="text-body-secondary">Price: <%= CurrencyUtils.format(products.getSale_price()) %> </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>

            </div>
        </div>

</main>

<%@include file="includes/footer.jsp"%>


