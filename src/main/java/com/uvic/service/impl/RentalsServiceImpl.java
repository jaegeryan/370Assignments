package com.uvic.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.entity.Rentals;
import com.uvic.service.RentalsService;
import com.uvic.mapper.RentalsMapper;
import org.springframework.stereotype.Service;

/**
* @author Jaegeryan
* @description 针对表【rentals】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class RentalsServiceImpl extends ServiceImpl<RentalsMapper, Rentals>
    implements RentalsService{

}




