package com.uvic.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.uvic.entity.Customers;

/**
* @author Jaegeryan
* @description 针对表【customers】的数据库操作Mapper
* @createDate 2024-07-20 06:31:20
* @Entity com.uvic.entity.Customers
*/
public interface CustomersMapper extends BaseMapper<Customers> {

    int updateByCustomerId(Customers customers);
}




