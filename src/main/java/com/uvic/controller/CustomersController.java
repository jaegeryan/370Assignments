package com.uvic.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.uvic.entity.Customers;
import com.uvic.mapper.CustomersMapper;
import com.uvic.service.CustomersService;
import com.uvic.util.CommonResult;
import com.uvic.util.Result;
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

    /**
     * Get all customers
     * @return CommonResult
     */
    @RequestMapping(value = "/getAllCustomers", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult list() {
        List<Customers> customers = customersMapper.selectList(null);
        return CommonResult.success(customers, "Get all customers successfully");
    }

    @RequestMapping(value= "/getCustomerById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult getCustomerById( @PathVariable Integer id) {
        //Use mybatis-plus to get customer by id
        Customers customers = customersMapper.selectById(id);
        return CommonResult.success(customers, "Get customer by id successfully");
    }

    @RequestMapping(value = "/getCustomerByEmailAddress/{emailAddress}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult getCustomerByEmailAddress(@PathVariable String emailAddress) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("email", emailAddress);
        Customers customers = customersMapper.selectOne(queryWrapper);
        if (customers == null) {
            return CommonResult.failed("No customer found");
        } else {
            return CommonResult.success(customers, "Get customer by email address successfully");
        }
    }

    @RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult addCustomer(@RequestBody Customers customers) {
        int insert = customersMapper.insert(customers);
        return CommonResult.success(insert, "Add customer successfully");
    }

    @RequestMapping(value = "/updateCustomer/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Result updateCustomer(@PathVariable Integer id, @RequestBody Customers customers) {
        int count = customersService.update(id, customers);
        if (count > 0) {
            return Result.success(count);
        }
        return Result.failed();
    }

    @RequestMapping(value = "/deleteCustomer/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public CommonResult deleteCustomer(@PathVariable Integer id) {
        int delete = customersMapper.deleteById(id);
        return CommonResult.success(delete, "Delete customer successfully");
    }

}
