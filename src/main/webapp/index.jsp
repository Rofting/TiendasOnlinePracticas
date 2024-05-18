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

    function deleteProduct(productId) {
        // Deshabilitar solo el botón clicado
        $("#deleteproduct").prop("disabled", true);

        $.ajax({
            type: "GET",
            url: "remove-products?id_product=" + productId,
            success: function (data) {
                $("#result").html("data");
                $("#deleteproduct").prop("disabled", false);
                window.location.href = "index.jsp";
            },
            error: function (error) {
                $("#result").html("Error: " + error.responseText);
                $("#deleteproduct").prop("disabled", false);
            }
        });
    }
</script>

<head>
    <link href="style.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
</head>
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
           <h4 class="text_inicio"><%= username_init%></h4>
           <p><a href="register-user.jsp?id_user=<%=user_id%>" class="text_inicio">&nbsp;&nbsp;Modify My Username&nbsp;&nbsp;</a></p>
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
                    <h3 class="text-dark">---Administrator Mode---</h3>
                    <br/>
                        <a href="register-product.jsp" class="btn btn-success rounded-pill px-3" type="button">New product</a>
                        <a href="index-user.jsp" class="btn btn-info rounded-pill px-3" type="button">Admin Users</a>
                        <a href="index-suppliers.jsp" class="btn btn btn-dark rounded-pill px-3" type="button">Admin Suppliers</a>
                        <a href="all-orders_done.jsp" class="btn btn-primary rounded-pill px3" type="button">Orders Done</a>
                <%
                } else {
                %>
                     <h3 class="text-dark">---Star Products---</h3>
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
                        <button id="search-button" type="button" class="btn btn-primary">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3" >
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
                                        <button id="deleteproduct" onclick="deleteProduct(<%=products.getId_product()%>)" type="button" class="btn btn-sm btn-outline-danger">Delete</button>
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
                <div id="result"></div>
            </div>
        </div>

</main>

<%@include file="includes/footer.jsp"%>


