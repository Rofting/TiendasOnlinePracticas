<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.domain.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.ProductsDao" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script>
    $(document).ready(function () {
        $("#search-input").focus();
    });
    function deleteUser(userId) {
        // Deshabilitar solo el botón clicado
        $("#deleteuser").prop("disabled", true);

        $.ajax({
            type: "GET",
            url: "remove-user?id_user=" + userId,
            success: function (data) {
                $("#result").html("data");
                $("#deleteuser").prop("disabled", false);
                window.location.href = "index-user.jsp";
            },
            error: function (error) {
                $("#result").html("Error: " + error.responseText);
                $("#deleteuser").prop("disabled", false);
            }
        });
    }


</script>

<main>
    <br/>
    <div class="container bg-dark">
        <h2 class="text-danger">User List</h2>
        <br/>
        <form class="row g-2" id="search-form" method="GET">
            <div class="input-group mb-3">
                <input type="text" class="form-control" placeholder="Search in Users" name="search" id="search-input">
                <button type="submit" class="btn btn-outline-danger"  id="search-button">Search</button>
            </div>
        </form>
    </div>

    <div class="container my-6 bg-dark">

                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Role</th>
                        <th>City</th>
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
                        List<User> listuser = null;
                        if (search.isEmpty()) {
                            listuser = Database.jdbi.withExtension(UserDao.class, dao -> dao.getAllUsers());
                        } else {
                            final String searchTerm = search;
                            listuser = Database.jdbi.withExtension(UserDao.class, dao -> dao.getUsers(searchTerm));
                        }

                        for (User user : listuser) {
                    %>
                    <tr>
                        <td><%=user.getName()%></td>
                        <td><%=user.getUsername()%></td>
                        <td><%=user.getRole()%></td>
                        <td><%=user.getCity()%></td>
                        <th><a href="view-user.jsp?id_user=<%= user.getId_user()%>" type="button" class="btn btn-sm btn-outline-success">View User</a></th>
                        <th><button onclick="deleteUser(<%= user.getId_user()%>)" id=deleteuser" type="button" class="btn btn-sm btn-outline-danger">Delete User</button></th>

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
