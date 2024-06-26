package com.svalero.tiendaonlinepracticas.servlet;

import com.svalero.tiendaonlinepracticas.dao.Database;
import com.svalero.tiendaonlinepracticas.dao.SuppliersDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import static com.svalero.tiendaonlinepracticas.util.ErrorUtils.sendError;


@WebServlet("/edit-suppliers")

public class EditSuppliers extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        try {
            // Si el id es = 0 sera crear uno nuevo sino es modificacion
            int id =0;
            if (request.getParameter("id_supplier") != null){
              id = Integer.parseInt(request.getParameter("id_supplier"));
            }

            //Validaciones de los campos del formulario register-product
            if (hasValidationErrors(request, response))
                return;
            //Si ha ido bien, pasamos los valores para que se puedan grabar en la BD
            String name = request.getParameter("name");
            String tel = request.getParameter("tel");
            String address = request.getParameter("address");
            String zip_code = request.getParameter("zip_code");
            String city = request.getParameter("city");
            String country = request.getParameter("country");
            String website = request.getParameter("website");
            String email = request.getParameter("email");

            Database.connect();

            if (id ==0) {
                int affectedRows = Database.jdbi.withExtension(SuppliersDao.class,
                        dao -> dao.addSupliers(name, tel, address, zip_code, city, country,
                        website,email));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Correctly registered supplier</div>");
            } else {
                final int finalid = id;
                int affectedRows = Database.jdbi.withExtension(SuppliersDao.class,
                        dao -> dao.updateSuppliers(name, tel, address,
                                zip_code, city, country,website,email, finalid));
                response.getWriter().println("<div class='alert alert-success' role='alert'>" +
                        "Correctly modified supplier</div>");
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
    private boolean hasValidationErrors(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean hasErrors = false;
        if (request.getParameter("name").isBlank()) {
            sendError("Supplier name is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("tel").isBlank()) {
            sendError("Phone is a required field", response);
            hasErrors = true;
        }
        if (request.getParameter("address").isBlank()) {
            sendError("Address is a required field", response);
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

        if (request.getParameter("zip_code").isBlank()) {
            sendError("Country is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("website").isBlank()) {
            sendError("Website is a required field", response);
            hasErrors = true;
        }

        if (request.getParameter("email").isBlank()) {
            sendError("Email is a required field", response);
            hasErrors = true;
        }

        return hasErrors;
    }
}

