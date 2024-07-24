package com.uvic.controller;

import com.uvic.entity.Customers;
import com.uvic.mapper.CustomersMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customers")
public class CustomersController {

    @Resource
    private CustomersMapper customersMapper;

    @RequestMapping(value = "/getAllCustomers", method = RequestMethod.GET)
    @ResponseBody
    public Object list() {
        List<Customers> customers = customersMapper.selectList(null);
        return CommonResult.success(customers, "Get all customers successfully");
    }

    @RequestMapping(value= "/getCustomerById", method = RequestMethod.POST)
    @ResponseBody
    public Object getCustomerById(Integer id) {
        Customers customers = customersMapper.selectById(id);
        return CommonResult.success(customers, "Get customer by id successfully");
    }

    @RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object addCustomer(Customers customers) {
        int insert = customersMapper.insert(customers);
        return CommonResult.success(insert, "Add customer successfully");
    }
}
