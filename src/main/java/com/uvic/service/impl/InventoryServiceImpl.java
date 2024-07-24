package com.uvic.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.entity.Inventory;
import com.uvic.service.InventoryService;
import com.uvic.mapper.InventoryMapper;
import org.springframework.stereotype.Service;

/**
* @author Jaegeryan
* @description 针对表【inventory】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class InventoryServiceImpl extends ServiceImpl<InventoryMapper, Inventory>
    implements InventoryService{

}




