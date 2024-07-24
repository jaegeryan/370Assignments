package com.uvic.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.uvic.entity.Customers;

/**
* @author Jaegeryan
* @description 针对表【customers】的数据库操作Service
* @createDate 2024-07-20 06:31:20
*/
public interface CustomersService extends IService<Customers> {

    int update(Integer id, Customers customers);
}
