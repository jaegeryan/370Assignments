package com.uvic.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.entity.Customers;
import com.uvic.service.CustomersService;
import com.uvic.mapper.CustomersMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

/**
* @author Jaegeryan
* @description 针对表【customers】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class CustomersServiceImpl extends ServiceImpl<CustomersMapper, Customers>
    implements CustomersService{

    @Resource
    private CustomersMapper customersMapper;

    @Override
    public int update(Integer id, Customers customers) {
        customers.setCustomerId(id);
        customers.setPhoneNumber(customers.getPhoneNumber());
        customers.setAddress(customers.getAddress());
        customers.setEmail(customers.getEmail());
        customers.setFirstName(customers.getFirstName());
        customers.setLastName(customers.getLastName());
        int count = customersMapper.updateById(customers);
        if (count > 0) {
            return count;
        } else {
            return 0;
        }
    }
}




