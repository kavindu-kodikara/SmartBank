package com.kv.app.transaction;

import com.kv.app.core.dto.TransactionDataDto;
import com.kv.app.core.entity.Account;
import com.kv.app.core.entity.ScheduledTransfer;
import com.kv.app.core.entity.Status;
import com.kv.app.core.interceptor.AuditLogInterceptor;
import com.kv.app.core.service.ScheduleTransactionService;
import com.kv.app.core.service.TransactionService;
import jakarta.annotation.Resource;
import jakarta.ejb.*;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Singleton
@Startup
@Interceptors({AuditLogInterceptor.class})
public class ScheduleTransactionTimer implements ScheduleTransactionService {

    @EJB
    TransactionService transactionService;

    @PersistenceContext
    private EntityManager em;

    @Resource
    private TimerService timerService;

    @Override
    public void scheduleTransaction(TransactionDataDto transactionData) {
        try {
            Account fromAccount = em.find(Account.class, transactionData.getFromAccount());
            Account toAccount = em.find(Account.class, transactionData.getToAccount());

            ScheduledTransfer transfer = new ScheduledTransfer();

            transfer.setAmount(transactionData.getAmount());
            transfer.setStatus(Status.PENDING);
            transfer.setFromAccount(fromAccount);
            transfer.setToAccount(toAccount);
            transfer.setDescription(transactionData.getDescription());

            LocalDateTime localDateTime = LocalDateTime.parse(transactionData.getTransferDate() + "T" + transactionData.getTransferTime());
            transfer.setScheduledDateTime(Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant()));

            em.persist(transfer);
            em.flush();

            TimerConfig config = new TimerConfig();
            config.setInfo(transfer.getId());
            config.setPersistent(true);

            timerService.createSingleActionTimer(transfer.getScheduledDateTime(), config);
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }

    @Timeout
    public void processTransfer(Timer timer) {
        Long transferId = (Long) timer.getInfo();
        ScheduledTransfer transfer = em.find(ScheduledTransfer.class, transferId);

        if (transfer == null || transfer.getStatus() != Status.PENDING) return;

        try {

            TransactionDataDto transactionDataDto = new TransactionDataDto();
            transactionDataDto.setAmount(transfer.getAmount());
            transactionDataDto.setDescription(transfer.getDescription());
            transactionDataDto.setFromAccount(transfer.getFromAccount().getAccountNumber());
            transactionDataDto.setToAccount(transfer.getToAccount().getAccountNumber());

            transactionService.externalTransaction(transactionDataDto);

            transfer.setStatus(Status.SUCCEEDED);

        } catch (Exception e) {
            transfer.setStatus(Status.FAILED);
        }

        em.merge(transfer);
    }


}
