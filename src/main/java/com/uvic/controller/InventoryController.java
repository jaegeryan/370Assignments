package com.uvic.controller;

import com.uvic.mapper.InventoryMapper;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/inventory")
public class InventoryController {

    @Resource
    private InventoryMapper inventoryMapper;


}
