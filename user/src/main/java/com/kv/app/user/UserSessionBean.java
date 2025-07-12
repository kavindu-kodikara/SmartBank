package com.kv.app.user;

import com.kv.app.core.dto.UserDto;
import com.kv.app.core.encryption.HashPassword;
import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.Transaction;
import com.kv.app.core.entity.TransactionType;
import com.kv.app.core.entity.User;
import com.kv.app.core.mail.MailServiceProvider;
import com.kv.app.core.mail.emails.AccountSetupEmail;
import com.kv.app.core.service.user.UserService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Stateless
public class UserSessionBean implements UserService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public List<User> findAll() {
        return List.of();
    }

    @Override
    public User findByUsername(String username) {
        try {
            return em.createNamedQuery("User.findByUserName", User.class).setParameter("username", username).getSingleResult();
        }catch (NoResultException e){
            System.err.println(e.getMessage());
            return null;
        }
    }

    @Override
    public Map<String, Object> registerUser(UserDto userDto) {

            if (!em.createNamedQuery("User.findByNic").setParameter("nic", userDto.getNic()).getResultList().isEmpty()) {
                return Map.of("success", false, "message", "NIC already exists");
            }

            if (!em.createNamedQuery("User.findByEmail").setParameter("email", userDto.getEmail()).getResultList().isEmpty()) {
                return Map.of("success", false, "message", "Email already exists");
            }

            em.persist(new User(
                    userDto.getFirstName(),
                    userDto.getLastName(),
                    userDto.getEmail(),
                    userDto.getMobile(),
                    userDto.getNic()
            ));

            try {

                User user = em.createNamedQuery("User.findByNic", User.class).setParameter("nic", userDto.getNic()).getSingleResult();

                Random random = new Random();
                int accNumber = 10000000 + random.nextInt(90000000);

                em.persist(new Account(String.valueOf(accNumber), Double.parseDouble(userDto.getInitialDeposit()), user));

                Account account = em.find(Account.class, String.valueOf(accNumber));

                em.persist(new Transaction(new Date(), Double.parseDouble(userDto.getInitialDeposit()), TransactionType.DEPOSIT, account));

                AccountSetupEmail mail = new AccountSetupEmail(user.getEmail(), String.valueOf(user.getId()));
                MailServiceProvider.getInstance().sendMail(mail);

                return Map.of("success", true, "message", "Account created successfully");

            } catch (NoResultException e) {
                System.err.println(e.getMessage());
                return Map.of("success", false, "message", "Something went wrong");
            }


    }

    @Override
    public boolean createUsername(String username, String password, String userId) {

            User user = em.find(User.class, Long.parseLong(userId));
            if (user != null) {
                user.setUsername(username);
                user.setPassword(HashPassword.hashPassword(password));
                em.persist(user);
                return true;
            }

        return false;
    }

}
