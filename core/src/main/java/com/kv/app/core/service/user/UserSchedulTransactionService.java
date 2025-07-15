package com.kv.app.core.service.user;

import com.kv.app.core.entity.ScheduledTransfer;

import java.util.List;

public interface UserSchedulTransactionService {
    public List<ScheduledTransfer> getPendingScheduledTransfers(Long userId);
    public List<ScheduledTransfer> getPastScheduledTransfers(Long userId);
}
