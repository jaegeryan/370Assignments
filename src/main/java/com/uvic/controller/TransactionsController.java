package com.uvic.controller;

import com.uvic.mapper.TransactionsMapper;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/transactions")
public class TransactionsController {

    @Resource
    private TransactionsMapper transactionsMapper;
}
