package com.uvic.controller;

import com.uvic.entity.Customers;
import com.uvic.mapper.CustomersMapper;
import com.uvic.service.CustomersService;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/customers")
public class CustomersController {

    @Resource
    private CustomersMapper customersMapper;
    @Resource
    private CustomersService customersService;

    @RequestMapping(value = "/getAllCustomers", method = RequestMethod.GET)
    @ResponseBody
    public Object list() {
        List<Customers> customers = customersMapper.selectList(null);
        return CommonResult.success(customers, "Get all customers successfully");
    }

    @RequestMapping(value= "/getCustomerById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object getCustomerById( @PathVariable Integer id) {
        Customers customers = customersMapper.selectById(id);
        return CommonResult.success(customers, "Get customer by id successfully");
    }

    @RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
    @ResponseBody
    public Object addCustomer(@RequestBody Customers customers) {
        int insert = customersMapper.insert(customers);
        return CommonResult.success(insert, "Add customer successfully");
    }

    @RequestMapping(value = "/updateCustomer/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateCustomer(@PathVariable Integer id, @RequestBody Customers customers) {
        int count = customersService.update(id, customers);
        if (count > 0) {
            return CommonResult.success(count);
        }
        return CommonResult.failed();
    }

    @RequestMapping(value = "/deleteCustomer/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object deleteCustomer(@PathVariable Integer id) {
        int delete = customersMapper.deleteById(id);
        return CommonResult.success(delete, "Delete customer successfully");
    }
}
