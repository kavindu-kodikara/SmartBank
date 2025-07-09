package com.kv.app.core.mail.emails;

import com.kv.app.core.mail.Mailable;
import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;

public class OTPEmail extends Mailable {
    private final String to;
    private final String code;

    public OTPEmail(String to, String code) {
        this.to = to;
        this.code = code;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Your Smart Bank Account OTP code");

        // HTML email body
        String html =
                "<div style=\"font-family: 'Rajdhani', sans-serif; max-width: 400px; margin: 0 auto; background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(10px); border-radius: 16px; border: 1px solid rgba(0, 0, 0, 0.08); padding: 30px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); text-align: center;\">\n" +
                        "    <div style=\"margin-bottom: 20px;\">\n" +
                        "        <h2>SMART BANK</h2>\n" +
                        "        <h2 style=\"color: #3a0ca3; margin: 0; font-weight: 700;\">Your Verification Code</h2>\n" +
                        "        <p style=\"color: #6c757d; margin: 10px 0 0;\">Please use this code to verify your identity</p>\n" +
                        "    </div>\n" +
                        "    \n" +
                        "    <div style=\"background: rgba(67, 97, 238, 0.1); padding: 15px; border-radius: 12px; margin: 25px 0; display: inline-block;\">\n" +
                        "        <div style=\"font-size: 32px; letter-spacing: 8px; color: #3a0ca3; font-weight: 700; padding: 5px 15px;\">"+code+"</div>\n" +
                        "    </div>\n" +
                        "    \n" +
                        "    <p style=\"color: #6c757d; margin: 0 0 25px; font-size: 14px;\">\n" +
                        "        This code will expire in <strong style=\"color: #ef233c;\">10 minutes</strong>.\n" +
                        "        <br>If you didn't request this, please ignore this email.\n" +
                        "    </p>\n" +
                        "    \n" +
                        "    <div style=\"border-top: 1px solid rgba(0, 0, 0, 0.08); padding-top: 20px;\">\n" +
                        "        <p style=\"color: #6c757d; font-size: 12px; margin: 0;\">\n" +
                        "            For your security, never share this code with anyone.\n" +
                        "            <br>© 2025 Smart Bank. All rights reserved.\n" +
                        "        </p>\n" +
                        "    </div>\n" +
                        "</div>";

        MimeBodyPart mimeBodyPart = new MimeBodyPart();
        mimeBodyPart.setContent(html, "text/html; charset=utf-8");

        MimeMultipart multipart = new MimeMultipart();
        multipart.addBodyPart(mimeBodyPart);

        message.setContent(multipart);
    }
}