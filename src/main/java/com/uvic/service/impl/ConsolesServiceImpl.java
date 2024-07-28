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
            inventory.setSerialNumber(consoles.getSerialNumber());
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

    @Override
    public int deleteConsoleById(Integer id) {
            QueryWrapper<Consoles> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("console_id", id);
            Consoles consoles = consolesMapper.selectOne(queryWrapper);
            QueryWrapper<Inventory> inventoryQueryWrapper = new QueryWrapper<>();
            inventoryQueryWrapper.eq("serial_number", consoles.getSerialNumber());
            Inventory inventory = inventoryMapper.selectOne(inventoryQueryWrapper);
            int count =  inventoryMapper.deleteById(inventory.getInventoryId());
            if (count > 0) {
                int result = consolesMapper.deleteById(id);
                if (result > 0) {
                    return result;
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
    }

    @Override
    public int updateConsole(Consoles consoles) {
        int result = consolesMapper.updateById(consoles);
        if (result > 0) {
            QueryWrapper<Inventory> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("console_id", consoles.getConsoleId());
            Inventory inventory = inventoryMapper.selectOne(queryWrapper);
            inventory.setSerialNumber(consoles.getSerialNumber());
            inventoryMapper.updateById(inventory);
            return result;
        } else {
            return 0;
        }
    }
}




