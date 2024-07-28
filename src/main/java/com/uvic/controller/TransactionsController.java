package com.uvic.controller;

import com.uvic.entity.Transactions;
import com.uvic.mapper.TransactionsMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/transactions")
public class TransactionsController {

    @Resource
    private TransactionsMapper transactionsMapper;

    @RequestMapping("/getAllTransactions")
    @ResponseBody
    public CommonResult getAllTransactions() {
        List<Transactions> transactions = transactionsMapper.selectList(null);
        if (transactions.size() > 0) {
            return CommonResult.success(transactions);
        } else {
            return CommonResult.failed();
        }
    }


}
