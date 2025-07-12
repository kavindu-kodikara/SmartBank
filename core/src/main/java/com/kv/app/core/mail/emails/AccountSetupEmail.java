package com.kv.app.core.mail.emails;

import com.kv.app.core.mail.Mailable;
import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMultipart;

public class AccountSetupEmail extends Mailable {
    private final String to;
    private final String id;

    public AccountSetupEmail(String to, String id) {
        this.to = to;
        this.id = id;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Setup your Smart Bank Account");

        // HTML email body
        String html =
                "<div style=\"font-family: 'Rajdhani', sans-serif; max-width: 400px; margin: 0 auto; background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(10px); border-radius: 16px; border: 1px solid rgba(0, 0, 0, 0.08); padding: 30px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); text-align: center;\">\n" +
                        "    <div style=\"margin-bottom: 20px;\">\n" +
                        "        <h2>SMART BANK</h2>\n" +
                        "        <h2 style=\"color: #3a0ca3; margin: 0; font-weight: 700;\">Complete Your Account Setup</h2>\n" +
                        "        <p style=\"color: #6c757d; margin: 10px 0 0;\">Click the button below to activate your Smart Bank account</p>\n" +
                        "    </div>\n" +
                        "    \n" +
                        "    <a href=http://localhost:8080/SmartBank/setupAccount.jsp?token="+id+
                        "       style=\"display: inline-block; background: #4361ee; color: white; text-decoration: none; padding: 12px 30px; border-radius: 12px; font-weight: 600; margin: 20px 0; transition: all 0.3s;\">\n" +
                        "       Set Up Your Account\n" +
                        "    </a>\n" +
                        "    \n" +
                        "    <p style=\"color: #6c757d; margin: 0 0 15px; font-size: 14px; line-height: 1.5;\">\n" +
                        "        For security reasons, this link will expire in <strong style=\"color: #ef233c;\">24 hours</strong>.\n" +
                        "        If you didn't request this, please contact our support team immediately.\n" +
                        "    </p>\n" +
                        "    \n" +
                        "    <div style=\"border-top: 1px solid rgba(0, 0, 0, 0.08); padding-top: 20px;\">\n" +
                        "        <p style=\"color: #6c757d; font-size: 12px; margin: 5px 0;\">\n" +
                        "            Can't click the button? Copy this link:<br>\n" +
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
