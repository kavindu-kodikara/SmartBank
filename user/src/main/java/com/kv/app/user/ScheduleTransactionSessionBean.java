package com.kv.app.user;

import com.kv.app.core.entity.ScheduledTransfer;
import com.kv.app.core.entity.Status;
import com.kv.app.core.entity.User;
import com.kv.app.core.service.user.UserSchedulTransactionService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
public class ScheduleTransactionSessionBean implements UserSchedulTransactionService {

    @PersistenceContext
    EntityManager em;

    @Override
    public List<ScheduledTransfer> getPendingScheduledTransfers(Long userId) {

        User user = em.find(User.class, userId);

        return em.createQuery("SELECT s FROM ScheduledTransfer s WHERE s.status =:status AND s.fromAccount.user =:user", ScheduledTransfer.class)
                .setParameter("status", Status.PENDING)
                .setParameter("user", user)
                .getResultList();

    }

    @Override
    public List<ScheduledTransfer> getPastScheduledTransfers(Long userId) {
        User user = em.find(User.class, userId);

        return em.createQuery("SELECT s FROM ScheduledTransfer s WHERE s.status !=:status AND s.fromAccount.user =:user", ScheduledTransfer.class)
                .setParameter("status", Status.PENDING)
                .setParameter("user", user)
                .getResultList();
    }
}
