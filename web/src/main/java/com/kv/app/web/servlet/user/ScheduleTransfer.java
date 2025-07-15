package com.kv.app.web.servlet.user;

import com.google.gson.Gson;
import com.kv.app.core.dto.TransactionDataDto;
import com.kv.app.core.exception.InsufficientBalanceException;
import com.kv.app.core.exception.InvalidAccountException;
import com.kv.app.core.service.ScheduleTransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/scheduled/externalTransfer")
public class ScheduleTransfer extends HttpServlet {

    @EJB
    ScheduleTransactionService scheduleTransactionService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Gson gson = new Gson();
        String message = "success";
        boolean success = false;
        TransactionDataDto transactionData = gson.fromJson(req.getReader(), TransactionDataDto.class);

        if(transactionData.getFromAccount() != null
                && transactionData.getToAccount() != null
                && transactionData.getRecipientName() != null
                && transactionData.getAmount() > 10
                && !transactionData.getDescription().isEmpty()
                && transactionData.getTransferDate() != null
                && transactionData.getTransferTime() != null
        ) {

            try {

                scheduleTransactionService.scheduleTransaction(transactionData);

                success = true;
            }catch (IllegalArgumentException | InsufficientBalanceException | InvalidAccountException e){
                message = e.getMessage();
            }

        }else{
            message = "Invalid transaction data";
        }

        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(
                Map.of(
                        "success", success,
                        "message", message
                )
        ));

    }
}
