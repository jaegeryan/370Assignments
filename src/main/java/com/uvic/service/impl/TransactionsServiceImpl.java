package com.uvic.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.service.TransactionsService;
import com.uvic.entity.Transactions;
import com.uvic.mapper.TransactionsMapper;
import org.springframework.stereotype.Service;

/**
* @author Jaegeryan
* @description 针对表【transactions】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class TransactionsServiceImpl extends ServiceImpl<TransactionsMapper, Transactions>
    implements TransactionsService {

}




