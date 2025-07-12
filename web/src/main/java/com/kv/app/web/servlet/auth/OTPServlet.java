package com.kv.app.web.servlet.auth;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kv.app.core.entity.User;
import com.kv.app.core.entity.UserType;
import com.kv.app.core.service.OTPService;
import com.kv.app.core.service.user.UserService;
import jakarta.ejb.EJB;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/verifyOTP")
public class OTPServlet extends HttpServlet {

    @EJB
    private OTPService otpService;

    @EJB
    UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        resp.setContentType("application/json");
        JsonObject reqObj = gson.fromJson(req.getReader(), JsonObject.class);

        String otpCode = reqObj.get("code").getAsString();

        CredentialValidationResult result = (CredentialValidationResult) req.getSession().getAttribute("pendingValidateResult");

        Map<String,Object> verifiedData = otpService.verifyOTP(otpCode,result.getCallerPrincipal().getName());
        boolean isValid = (boolean) verifiedData.get("isValid");
        UserType userType = (UserType) verifiedData.get("role");

        String endpoint = userType.equals(UserType.ADMIN) ?  "/admin" : "/user";

        if(isValid) {
            req.getSession().setAttribute("verifiedUser",result);
             User user = userService.findByUsername(result.getCallerPrincipal().getName());
             req.getSession().setAttribute("user", user);
            resp.getWriter().write(gson.toJson(Map.of(
                    "success", true,
                    "redirect", req.getContextPath() + endpoint
            )));
        }else{
            resp.getWriter().write(gson.toJson(Map.of(
                    "success", false
            )));
        }




    }
}
