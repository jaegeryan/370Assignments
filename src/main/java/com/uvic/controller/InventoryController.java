package com.uvic.controller;

import com.uvic.entity.Inventory;
import com.uvic.mapper.InventoryMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

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

    @RequestMapping(value = "/updateInventoryByInventoryId/{id}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateInventoryByInventoryId(@PathVariable Integer id, @RequestBody Inventory inventory) {
        int update = inventoryMapper.updateById(Inventory.builder().inventoryId(id).status(inventory.getStatus()).build());
        if (update > 0) {
            return CommonResult.success(update, "Update inventory successfully");
        } else {
            return CommonResult.failed();
        }
    }

    @RequestMapping(value = "/addInventory", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult addInventory(@RequestBody Inventory inventory) {
        int insert = inventoryMapper.insert(inventory);
        if (insert > 0) {
            return CommonResult.success(insert, "Add inventory successfully");
        } else {
            return CommonResult.failed();
        }
    }
}
