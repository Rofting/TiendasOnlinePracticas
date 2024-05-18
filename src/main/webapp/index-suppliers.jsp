<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.ProductsDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.UserDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Suppliers" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.SuppliersDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });

    function deleteSupplier(supplierId) {
        // Deshabilitar solo el botón clicado
        $("#deletesupplier").prop("disabled", true);

        $.ajax({
            type: "GET",
            url: "remove-suppliers?id_supplier=" + supplierId,
            success: function (data) {
                $("#result").html("data");
                $("#deletesupplier").prop("disabled", false);
                window.location.href = "index-suppliers.jsp";
            },
            error: function (error) {
                $("#result").html("Error: " + error.responseText);
                $("#deletesupplier").prop("disabled", false);
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
    <br/>
    <div class="container bg-dark">
        <h2 class="text-danger">Supplier List</h2>
        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <a href="register-suppliers.jsp" type="button" class="btn btn-outline-danger">New Supplier</a>
            <a href="list-out-stock.jsp" type="button" class="btn btn-outline-danger">List of products out of stock</a>
        </div>
        <br/>
        <br/>
        <form class="row g-2" id="search-form" method="GET">
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="Search in Suppliers" name="search" id="search-input">
                <button type="submit" class="btn btn-outline-danger"  id="search-button">Buscar</button>
            </div>
        </form>
    </div>

    <div class="container my-6 bg-dark">


        <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Supplier Id</th>
                        <th>Name</th>
                        <th>City</th>
                        <th>Email</th>
                        <th></th>
                        <th></th>
                        <th></th>
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

                        try {
                            Database.connect();
                        } catch (ClassNotFoundException e) {
                            throw new RuntimeException(e);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }
                        List<Suppliers> listsuppliers = null;
                        if (search.isEmpty()) {
                            listsuppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getAllSuppliers());
                        } else {
                            final String searchTerm = search;
                            listsuppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getSuppliers(searchTerm));
                        }

                        for (Suppliers suppliers : listsuppliers) {
                    %>
                    <tr>
                        <td><%=suppliers.getId_supplier()%></td>
                        <td><%=suppliers.getName()%></td>
                        <td><%=suppliers.getCity()%></td>
                        <td><%=suppliers.getEmail()%></td>
                        <th><a href="view-suppliers.jsp?id_supplier=<%= suppliers.getId_supplier()%>" type="button" class="btn btn-sm btn-outline-success">Ver Proveedor</a></th>
                        <th><a href="register-suppliers.jsp?id_supplier=<%= suppliers.getId_supplier()%>" type="button" class="btn btn-sm btn-outline-primary">Editar Proveedor</a></th>
                        <th> <button id="deletesupplier" onclick="deleteSupplier(<%= suppliers.getId_supplier()%>)" type="button" class="btn btn-sm btn-outline-danger">Eliminar Proveedor</button></th>

                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

        <br/>
        <div id="result"></div>
        <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
    </div>

</main>

<%@include file="includes/footer.jsp"%>
