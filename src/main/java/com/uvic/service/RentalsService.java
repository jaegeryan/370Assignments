package com.uvic.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.uvic.entity.Customers;
import com.uvic.entity.Inventory;
import com.uvic.entity.Rentals;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
* @author Jaegeryan
* @description 针对表【rentals】的数据库操作Service
* @createDate 2024-07-20 06:31:20
*/
public interface RentalsService extends IService<Rentals> {

    @Transactional
    int addRental(Rentals rental, Integer paymentMethod);

    @Transactional
    int updateRental(Rentals rental);

    float calculateTotalCost(Date rentalStartDate, Date rentalEndDate);
}
