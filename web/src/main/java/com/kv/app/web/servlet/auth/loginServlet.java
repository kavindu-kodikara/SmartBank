package com.kv.app.web.servlet.auth;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.inject.Inject;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        boolean isValid = false;
        JsonObject reqObj = gson.fromJson(req.getReader(), JsonObject.class);

        String username = reqObj.get("username").getAsString();
        String password = reqObj.get("password").getAsString();

        System.out.println(username + " " + password);

        if(!username.isEmpty() && !password.isEmpty()) {
            AuthenticationParameters parameters = AuthenticationParameters
                    .withParams()
                    .credential(new UsernamePasswordCredential(username, password));

            AuthenticationStatus status = securityContext.authenticate(req,resp,parameters);

            System.out.println(status);

            if(status == AuthenticationStatus.SUCCESS) {
                isValid = true;
            }

        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(isValid));
    }
}
