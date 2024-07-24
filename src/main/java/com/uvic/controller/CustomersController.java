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

    @GetMapping("/getAllCustomers")
    public Object list() {
        List<Customers> customers = customersMapper.selectList(null);
        return customers;
    }

    @RequestMapping(value= "/getCustomerById", method = RequestMethod.POST)
    @ResponseBody
    public Object getCustomerById(Integer id) {
        Customers customers = customersMapper.selectById(id);
        return customers;
    }

    @RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object addCustomer(Customers customers) {
        int insert = customersMapper.insert(customers);
        return CommonResult.success(insert, "Add customer successfully");
    }
}
