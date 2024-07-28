package com.uvic.controller;

import com.uvic.entity.VipCustomers;
import com.uvic.mapper.VipCustomersMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/vipCustomers")
public class VipCustomersController {

    @Resource
    private VipCustomersMapper vipCustomersMapper;

    @RequestMapping("/all")
    @ResponseBody
    public CommonResult getAllVipCustomers() {
        List<VipCustomers> vipCustomers = vipCustomersMapper.selectList(null);
        if (vipCustomers.size() > 0) {
            return CommonResult.success(vipCustomers, "The VIP customers have been retrieved successfully");
        } else {
            return CommonResult.failed();
        }
    }

    @RequestMapping("/add")
    @ResponseBody
    public CommonResult addVipCustomer(@RequestBody VipCustomers vipCustomers) {
        int insert = vipCustomersMapper.insert(vipCustomers);
        if (insert > 0) {
            return CommonResult.success(insert, "The VIP customer has been added successfully");
        } else {
            return CommonResult.failed();
        }
    }

    @RequestMapping("/update")
    @ResponseBody
    public CommonResult updateVipCustomer(@RequestBody VipCustomers vipCustomers) {
        int update = vipCustomersMapper.updateById(vipCustomers);
        if (update > 0) {
            return CommonResult.success(update, "The VIP customer has been updated successfully");
        } else {
            return CommonResult.failed();
        }
    }
}
