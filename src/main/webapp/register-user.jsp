<%@ page import="com.svalero.tiendaonlinepracticas.domain.User" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.Database" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.svalero.tiendaonlinepracticas.dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            var formValue = $(this).serialize();
            $.post("edit-user", formValue, function(data) {
                $("#result").html(data);
            });
        });
    });
</script>

<%

    User user=null;
    int id;
    //El id = 0 no es nunca un numero valido para un id, por eso ponemos 0, eso quiere decir que no existe
    //Asi ya tenemos una doble funcionalidad para este id
    if (request.getParameter("id_user") == null){
        // Se accede al formulario para crear un nuevo usuario
        id = 0;
    } else {
        // Se accede al formulario para editar un usuario ya existente
        id=Integer.parseInt(request.getParameter("id_user"));
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        user = Database.jdbi.withExtension(UserDao.class, dao -> dao.getOneUser(id));
    }
%>
<head>
    <link href="style.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
</head>
<main>

    <section class="py-5 container">
        <% if (id==0) {%>
        <h3 class="text-white">New User</h3>
        <% } else { %>
        <h3 class="text-white">Modify User</h3>
        <% } %>
        <br/>

        <form class="row g-3 needs-validation bg-dark border-dark" method="post" enctype="multipart/form-data" id="edit-form">
            <div class="col-md-6 text-white bg-dark">
                <label for="name" class="form-label">Name</label>
                <input type="text" name="name" class="form-control" id="name" placeholder=".."
                <% if (id !=0) {%> value="<%=user.getName()%>"<% }%>>
            </div>
            <div class="col-md-6 text-white bg-dark">
                <label for="username" class="form-label">Username</label>
                <input type="text" name="username" class="form-control" id="username" placeholder=".."
                <% if (id !=0) {%> value="<%=user.getUsername()%>"<% }%>>
            </div>

                <div class="mb-3 text-dark">
                    <label for="password" class="form-label">Password</label>
                     <input type="text" name ="password" class="form-control" id="password" placeholder="Example Labcdef1B">
                </div>
<%--                <% if (id !=0) {%> value="<%=user.getUsername()%>"<% }%>>--%>
            <div class="mb-3 text-white bg-dark">
                <label for="address" class="form-label">Address</label>
                <input type="text" name ="address" class="form-control" id="address" placeholder=".."
                <% if (id !=0) {%> value="<%=user.getAddress()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="tel" class="form-label">Phone</label>
                <input type="text" name ="tel" class="form-control" id="tel" placeholder="+34605888888"
                <% if (id !=0) {%> value="<%=user.getTel()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="zip_code" class="form-label">Zip Code</label>
                <input type="text" name ="zip_code" class="form-control" id="zip_code" placeholder="50500"
                <% if (id !=0) {%> value="<%=user.getZip_code()%>"<% }%>>
            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="city" class="form-label">City</label>
                <input type="text" name="city" class="form-control" id="city" placeholder="Zaragoza"
                <% if (id !=0) {%> value="<%=user.getCity()%>"<% }%>>

            </div>
            <div class="col-md-2 text-white bg-dark">
                <label for="country" class="form-label">Country</label>
                <input type="text" name ="country" class="form-control" id="country" placeholder="Spain"
                <% if (id !=0) {%> value="<%=user.getCountry()%>"<% }%>>

            </div>

            <%
                if (role.equals("admin")) {
            %>
            <div class="col-md-2 text-white bg-dark">
                <label for="role" class="form-label">Role</label>
                <input type="text" name ="role" class="form-control" id="role" placeholder="user"
                <% if (id !=0) {%> value="<%=user.getRole()%>"<% }%>>
            </div>
            <%
                }
            %>
            <div class="col-12">
                <button class="btn btn-danger" type="submit">Send User</button>
            </div>
            <input type="hidden" name="id_user" value="<%=id%>"/>
        </form>
        <br/>
        <div id="result"></div>
        <br/>
        <%if (role.equals("admin")) {%>
            <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
        <% } else { %>
            <% if (id ==0) {%>
                <p><a href="logout" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
            <% } else { %>
                <p><a href="index.jsp" class="link-danger link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">Back to initial menu</a></p>
            <%}%>
        <%}%>

    </section>
</main>

<%@include file="includes/footer.jsp"%>