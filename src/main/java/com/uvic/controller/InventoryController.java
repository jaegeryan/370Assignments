package com.uvic.controller;

import com.uvic.entity.Inventory;
import com.uvic.mapper.InventoryMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/inventory")
public class InventoryController {

    @Resource
    private InventoryMapper inventoryMapper;

    @RequestMapping("/getAllInventory")
    public CommonResult getAllInventory() {
        List<Inventory> inventory = inventoryMapper.selectList(null);
        if (inventory.size() > 0) {
            return CommonResult.success(inventory);
        } else {
            return CommonResult.failed();
        }
    }

    @RequestMapping("/getInventoryById")
    public CommonResult getInventoryById(Integer id) {
        Inventory inventory = inventoryMapper.selectById(id);
        if (inventory != null) {
            return CommonResult.success(inventory);
        } else {
            return CommonResult.failed();
        }
    }
}
