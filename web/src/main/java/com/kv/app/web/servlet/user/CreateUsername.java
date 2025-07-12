package com.kv.app.web.servlet.user;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kv.app.core.service.user.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/createUsername")
public class CreateUsername extends HttpServlet {

    @EJB
    UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        JsonObject json = gson.fromJson(req.getReader(), JsonObject.class);
        boolean isSuccess = false;

        String username = json.get("username").getAsString();
        String password = json.get("password").getAsString();
        String userId = json.get("id").getAsString();

        if(username != null && password != null && userId != null) {

            isSuccess = userService.createUsername(username, password, userId);

        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(isSuccess));

    }
}
