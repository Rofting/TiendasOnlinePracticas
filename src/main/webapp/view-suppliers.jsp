<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.User" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.UserDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.Suppliers" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.SuppliersDao" %>
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
        if (!role.equals("admin")){
            response.sendRedirect("/tiendaonlinepracticas");
        }
        //Si no eres el administrador no puedes entrar a esta pagina
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        int id_supplier = Integer.parseInt(request.getParameter("id_supplier"));
        Suppliers suppliers = Database.jdbi.withExtension(SuppliersDao.class, dao -> dao.getOneSuppliers(id_supplier));
    %>

    <div class="container my-3">

        <div class="row">
            <div class="col-sm-12  col-md-8 col-lg-8 col-xl-8 py-4 bg-dark">
                <table class="table table-dark table-striped">
                    <tr>
                        <td class="centrado"><h2 class="text-danger">View Supplier</h2></td>
                        <td class="centrado"></td>
                    </tr>
                    <tr>
                        <td class="centrado">Name</td>
                        <td class="centrado"><%=suppliers.getName()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Phone</td>
                        <td class="centrado"><%=suppliers.getTel()%></td>
                    </tr>
                    <tr>
                        <td class="centrado">Address</td>
                        <td class="centrado"><%=suppliers.getAddress()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Zip Code</th>
                        <td class="centrado"><%=suppliers.getZip_code()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">City</th>
                        <td class="centrado"><%=suppliers.getCity()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Country</th>
                        <td class="centrado"><%=suppliers.getCountry()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Website</th>
                        <td class="centrado"><%=suppliers.getWebsite()%></td>
                    </tr>
                    <tr>
                        <th class="centrado">Email</th>
                        <td class="centrado"><%=suppliers.getEmail()%></td>
                    </tr>
                </table>

            </div>
        </div>
        <br/>
        <p><a href="index-suppliers.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to Suppliers</a></p>
    </div>
</main>

<%@include file="includes/footer.jsp"%>

