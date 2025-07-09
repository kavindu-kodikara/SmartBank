package com.kv.app.web.servlet;

import com.kv.app.core.encryption.HashPassword;
import com.kv.app.core.entity.User;
import com.kv.app.core.service.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/test")
public class Test extends HttpServlet {

    @EJB
    UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String pw = req.getParameter("pw");

        User user = userService.findById(4L);
        user.setPassword(HashPassword.hashPassword(pw));

        userService.update(user);

    }
}
