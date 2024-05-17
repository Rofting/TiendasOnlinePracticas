package com.svalero.tiendaonlinepracticas.servlet;

import com.svalero.tiendaonlinepracticas.dao.Database;
import com.svalero.tiendaonlinepracticas.dao.ProductsDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/remove-all-selects-products")
public class RemoveALLSelectProducts extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //solo puede Borrar Productos el Administrador
        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("role") != null) {
            if (!currentSession.getAttribute("role").equals("admin")) {
                response.sendRedirect("/tiendaonlinepracticas");
            }
        }
        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(ProductsDao.class,
                    dao -> dao.removeAllSelectProducts());
            response.sendRedirect("index-suppliers.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}