package com.kv.app.web.servlet.admin;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kv.app.core.dto.UserDto;
import com.kv.app.core.service.admin.AdminDashboardService;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/deposit")
@RolesAllowed("ADMIN")
public class Deposit extends HttpServlet {

    @EJB
    AdminDashboardService adminDashboardService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        boolean success = false;
        JsonObject jsonObject = gson.fromJson(req.getReader(), JsonObject.class);
        String accountNumber = jsonObject.get("accountNumber").getAsString();
        String amount = jsonObject.get("depositAmount").getAsString();

        if(!accountNumber.isEmpty() && !amount.isEmpty()) {
            success = adminDashboardService.deposit(accountNumber, Double.parseDouble(amount));
        }
        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(success));

    }
}
