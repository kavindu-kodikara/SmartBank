package com.kv.app.core.interceptor;

import com.kv.app.core.entity.User;
import jakarta.annotation.Resource;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.ejb.SessionContext;
import jakarta.inject.Inject;

@Interceptor
public class AuditLogInterceptor {

    private static final String LOG_FILE = "logs/audit-log.txt";

    @Inject
    private HttpServletRequest request;

    @Resource
    private SessionContext context;

    @AroundInvoke
    public Object logMethod(InvocationContext ctx) throws Exception {
        String methodName = ctx.getMethod().getName();
        String params = Arrays.toString(ctx.getParameters());
        String username = getCurrentUsername();

        String logEntry = String.format("[%s] User: %-10s | Method: %-30s | Params: %s",
                LocalDateTime.now(), username, methodName, params);

        writeToLog(logEntry);

        try {
            Object result = ctx.proceed();
            return result;
        } catch (Exception e) {
            writeToLog(String.format("[%s] EXCEPTION in %s: %s",
                    LocalDateTime.now(), methodName, getStackTrace(e)));
            throw e;
        }
    }

    private String getCurrentUsername() {
        try {

            if (context != null && context.getCallerPrincipal() != null) {
                return context.getCallerPrincipal().getName();
            }


            if (request != null) {
                HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("user") != null) {
                    User user = (User) session.getAttribute("user");
                    return user.getUsername();
                }
            }
        } catch (Exception ignored) {}
        return "Unknown";
    }

    private void writeToLog(String entry) {
        File logFile = new File(LOG_FILE);
        File parentDir = logFile.getParentFile();

        try {
            if (parentDir != null && !parentDir.exists()) {
                parentDir.mkdirs();
            }

            if (!logFile.exists()) {
                logFile.createNewFile();
            }

            System.out.println("Logfile path : "+ logFile.getAbsolutePath());

            try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(logFile, true)))) {
                out.println(entry);
            }
        } catch (IOException e) {
            Logger.getLogger(AuditLogInterceptor.class.getName())
                    .log(Level.SEVERE, "Audit log write failed", e);
        }
    }


    private String getStackTrace(Throwable throwable) {
        StringWriter sw = new StringWriter();
        throwable.printStackTrace(new PrintWriter(sw));
        return sw.toString();
    }
}

