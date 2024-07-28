package com.uvic.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.entity.Customers;
import com.uvic.entity.Inventory;
import com.uvic.entity.Rentals;
import com.uvic.entity.Transactions;
import com.uvic.mapper.CustomersMapper;
import com.uvic.mapper.InventoryMapper;
import com.uvic.mapper.TransactionsMapper;
import com.uvic.service.RentalsService;
import com.uvic.mapper.RentalsMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
* @author Jaegeryan
* @description 针对表【rentals】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class RentalsServiceImpl extends ServiceImpl<RentalsMapper, Rentals>
    implements RentalsService{

    @Resource
    private RentalsMapper rentalsMapper;

    @Resource
    private InventoryMapper inventoryMapper;

    @Resource
    private TransactionsMapper transactionsMapper;

    @Override
    public int addRental(Rentals rentals, Integer paymentMethod) {
        Rentals rental = new Rentals();
        String payment = "";
        float totalCost = calculateTotalCost(rentals.getRentalStartDate(), rentals.getRentalEndDate());
        switch (paymentMethod) {
            case 1:
                payment = "Credit Card";
                break;
            case 2:
                payment = "Debit Card";
                break;
            case 3:
                payment = "Cash";
                break;
            case 4:
                payment = "Online";
                break;
            default:
                payment = "Cancelled";
        }
        if (payment != "Cancelled") {
            QueryWrapper<Inventory> inventoryQuery = new QueryWrapper<>();
            rental.setCustomerId(rentals.getCustomerId());
            rental.setInventoryId(rentals.getInventoryId());
            rental.setRentalStartDate(rentals.getRentalStartDate());
            rental.setRentalEndDate(rentals.getRentalEndDate());
            rental.setTotalCost(BigDecimal.valueOf(totalCost));
            int count = rentalsMapper.insert(rental);
            if (count > 0) {
                inventoryQuery.eq("inventory_id", rentals.getInventoryId());
                Inventory inventory = inventoryMapper.selectOne(inventoryQuery);
                inventory.setStatus("Rented");
                int result = inventoryMapper.updateById(inventory);
                if(result > 0) {
                    Transactions transaction = new Transactions();
                    transaction.setRentalId(rental.getRentalId());
                    transaction.setAmount(rental.getTotalCost());
                    transaction.setTransactionDate(new Date());
                    transaction.setPaymentMethod(payment);
                    transactionsMapper.insert(transaction);
                    return result;
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

    @Override
    public int updateRental(Rentals rental) {
        QueryWrapper<Inventory> inventoryQuery = new QueryWrapper<>();
        inventoryQuery.eq("inventory_id", rental.getInventoryId());
        Inventory inventory = inventoryMapper.selectOne(inventoryQuery);
        if (rental.getRentalStatus().equals("Completed")) {
            inventory.setStatus("Available");
        } else {
            inventory.setStatus("Rented");
        }
        int result = inventoryMapper.updateById(inventory);
        if (result > 0) {
            return rentalsMapper.updateById(rental);
        } else {
            return 0;
        }
    }

    /**
     * Get the total cost of a rental
     * @param rentalStartDate
     * @param rentalEndDate
     * @return cost
     */
    @Override
    public float calculateTotalCost(Date rentalStartDate, Date rentalEndDate) {
        long durationInMillis = rentalEndDate.getTime() - rentalStartDate.getTime();
        long durationInDays = TimeUnit.MILLISECONDS.toDays(durationInMillis);
        return durationInDays * 10;
    }
}




