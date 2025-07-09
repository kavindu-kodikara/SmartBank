package com.kv.app.user;

import com.kv.app.core.entity.User;
import com.kv.app.core.service.UserService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

import java.util.List;

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
    public void save(User user) {
        em.persist(user);
    }

    @Override
    public User findById(Long id) {
        return em.find(User.class, id);
    }

    @Override
    public void update(User user) {
        em.merge(user);
    }
}
