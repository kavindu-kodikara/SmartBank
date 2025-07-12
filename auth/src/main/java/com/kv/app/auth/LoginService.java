package com.kv.app.auth;

import com.kv.app.core.encryption.HashPassword;
import com.kv.app.core.entity.User;
import com.kv.app.core.mail.MailServiceProvider;
import com.kv.app.core.mail.emails.OTPEmail;
import jakarta.enterprise.context.RequestScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.security.SecureRandom;
import java.util.Set;

@RequestScoped
public class LoginService {
    @PersistenceContext
    private EntityManager em;

    public User getUser(String username) {
        try {
            return em.createNamedQuery("User.findByUserName", User.class).setParameter("username", username).getSingleResult();
        }catch(NoResultException e) {
            System.err.println("No user found");
            return null;
        }
    }

    public boolean validate(String username, String password) {
        User user = getUser(username);
        return user != null && HashPassword.verifyPassword(password, user.getPassword());
    }

    public Set<String> getRoles(String username) {
        User user = getUser(username);
        return user != null ? Set.of(user.getUserType().name()) : null;
    }

    @Transactional
    public void sendVerificationCode(String username) {

        SecureRandom random = new SecureRandom();
        int code = 100000 + random.nextInt(900000);

        User user = getUser(username);
        System.out.println(username+" "+user.getUsername());
        System.out.println(code);
        user.setVerificationCode(String.valueOf(code));
        em.persist(user);

//        OTPEmail mail = new OTPEmail(user.getEmail(), String.valueOf(code));
//        MailServiceProvider.getInstance().sendMail(mail);
    }
}
