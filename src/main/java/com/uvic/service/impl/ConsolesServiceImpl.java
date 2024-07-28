package com.uvic.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.entity.Consoles;
import com.uvic.entity.Inventory;
import com.uvic.entity.Rentals;
import com.uvic.mapper.InventoryMapper;
import com.uvic.mapper.RentalsMapper;
import com.uvic.service.ConsolesService;
import com.uvic.mapper.ConsolesMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

/**
* @author Jaegeryan
* @description 针对表【consoles】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class ConsolesServiceImpl extends ServiceImpl<ConsolesMapper, Consoles>
    implements ConsolesService{

    @Resource
    private ConsolesMapper consolesMapper;

    @Resource
    private InventoryMapper inventoryMapper;

    @Override
    public int addConsole(Consoles consoles) {
        int result = consolesMapper.insert(consoles);
        if (result > 0) {
            Inventory inventory = new Inventory();
            QueryWrapper<Consoles> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("serial_number", consoles.getSerialNumber());
            consoles = consolesMapper.selectOne(queryWrapper);
            inventory.setConsoleId(consoles.getConsoleId());
            inventory.setStatus("Available");
            int column = inventoryMapper.insert(inventory);
            if (column > 0) {
                return column;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }
}




