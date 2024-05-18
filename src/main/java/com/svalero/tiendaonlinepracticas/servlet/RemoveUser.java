package com.svalero.tiendaonlinepracticas.servlet;

import com.svalero.tiendaonlinepracticas.dao.Database;
import com.svalero.tiendaonlinepracticas.dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import static com.svalero.tiendaonlinepracticas.util.ErrorUtils.sendError;
import static com.svalero.tiendaonlinepracticas.util.ErrorUtils.sendMessage;

@WebServlet("/remove-user")
public class RemoveUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id_user = Integer.parseInt(request.getParameter("id_user"));

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(UserDao.class,
                    dao -> dao.removeUser(id_user));
            sendMessage("User deleted successfully", response);
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(400);
            sendError("Error when deleting user", response);
        }
    }

}
