package com.svalero.tiendaonlinepracticas.servlet;

import com.svalero.tiendaonlinepracticas.dao.Database;
import com.svalero.tiendaonlinepracticas.dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import static com.svalero.tiendaonlinepracticas.util.ErrorUtils.sendError;


@WebServlet("/edit-user")

public class EditUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");


        try {
            // Si el id es = 0 sera crear uno nuevo sino es modificacion
            int id =0;
            if (request.getParameter("id_user") != null){
              id = Integer.parseInt(request.getParameter("id_user"));
            }
            //Validaciones de los campos del formulario register-user
            if (hasValidationErrors(request, response, id))
                return;
            //Si ha ido bien, pasamos los valores para que se puedan grabar en la BD
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String password="";
            if (request.getParameter("password") != null) {
                password = request.getParameter("password");
            }
            String tel = request.getParameter("tel");
            String address = request.getParameter("address");
            String zip_code = request.getParameter("zip_code");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String role = "user";
            //solo el administrador es capaz de cambiarse el role
            HttpSession currentSession = request.getSession();
            if (currentSession.getAttribute("role") != null) {
                if (currentSession.getAttribute("role").equals("admin")) {
                    if (!request.getParameter("role").isBlank()) {
                        role = request.getParameter("role");
                    }
                }
            }

            Database.connect();
            final String finalrole = role;
            final String finalpassword=password;
            if (id ==0) {
                int affectedRows = Database.jdbi.withExtension(UserDao.class,
                        dao -> dao.addUser(name, username, finalpassword, finalrole, tel, address,
                                zip_code, city, country));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Welcome¡¡¡, you are already a registered user</div>");
            } else {
                final int finalid = id;
                int affectedRows = Database.jdbi.withExtension(UserDao.class,
                        dao -> dao.updateUser(name, username, finalpassword, finalrole, tel, address,
                                zip_code, city, country, finalid));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Correctly modified user</div>");

            }

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            response.getWriter().println("<div class='alert alert-danger' role='alert'>" +
                    "Internal Server Error</div>");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            response.getWriter().println("<div class='alert alert-danger' role='alert'>" +
                    "Error conecting to the data base</div>");

        }
    }
    private boolean hasValidationErrors(HttpServletRequest request, HttpServletResponse response,int id) throws IOException {
        boolean hasErrors = false;
        if (request.getParameter("name").isBlank()) {
            sendError("Name is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("username").isBlank()) {
            sendError("Username is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("password").isBlank()) {
                sendError("Password is a required field", response);
                hasErrors = true;
        }
        if (request.getParameter("tel").isBlank()) {
            sendError("Phone is a required field", response);
            hasErrors = true;
        }
        if (request.getParameter("address").isBlank()) {
            sendError("Addreess is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("zip_code").isBlank()) {
            sendError("Zip code is a required field", response);
            hasErrors = true;
        }
        if (request.getParameter("city").isBlank()) {
            sendError("City is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("country").isBlank()) {
            sendError("Country", response);
            hasErrors = true;
        }

        return hasErrors;
    }
}

