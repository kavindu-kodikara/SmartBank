package com.kv.app.web.servlet.admin;

import com.google.gson.Gson;
import com.kv.app.core.dto.UserDto;
import com.kv.app.core.service.user.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/user-register")
public class UserRegister extends HttpServlet {

    @EJB
    UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        Map<String,Object> respMap;

        UserDto userDto = gson.fromJson(req.getReader(), UserDto.class);

        if(userDto.getFirstName() != null
                && userDto.getLastName() != null
                && userDto.getEmail() != null
                && userDto.getMobile() != null
                && userDto.getNic() != null) {

            respMap = userService.registerUser(userDto);

        }else{
            respMap = Map.of("success", false, "message", "Invalid credentials");
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(respMap));

    }
}
