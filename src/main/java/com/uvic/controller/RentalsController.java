package com.uvic.controller;

import com.uvic.entity.Customers;
import com.uvic.entity.Inventory;
import com.uvic.entity.Rentals;
import com.uvic.mapper.InventoryMapper;
import com.uvic.mapper.RentalsMapper;
import com.uvic.service.RentalsService;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/rentals")
public class RentalsController {

    @Resource
    private RentalsMapper rentalsMapper;

    @Resource
    private RentalsService rentalsService;

    @Resource
    private InventoryMapper inventoryMapper;

    /**
     * Get all rentals
     * @return CommonResult
     */
    @RequestMapping(value = "/getAllRentals", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult getAllRentals() {
        List<Rentals> rentals = rentalsMapper.selectList(null);
        if (rentals.size() > 0) {
            return CommonResult.success(rentals);
        } else {
            return CommonResult.failed();
        }
    }

    /**
     * Update a rental by ID
     * @return CommonResult
     */
    @RequestMapping(value = "/updateRental", method = RequestMethod.PUT)
    @ResponseBody
    public CommonResult updateRental(@RequestBody Rentals rental) {
        int count = rentalsService.updateRental(rental);
        if (count > 0) {
            return CommonResult.success(count);
        } else {
            return CommonResult.failed();
        }
    }


    /**
     * Add a rental, including the payment method which is passed as a parameter in the URL
     * @return CommonResult
     */
    @RequestMapping(value ="/addRental/{paymentMethod}", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult addRental(@RequestBody Rentals rental, @PathVariable Integer paymentMethod) {
        int count = rentalsService.addRental(rental,paymentMethod);
        if (count > 0) {
            return CommonResult.success(count);
        } else {
            return CommonResult.failed();
        }
    }

    /**
     * Calculate the total cost of a rental
     * @return CommonResult
     */
    @RequestMapping(value = "/calculateTotalCost", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult calculateTotalCost(@RequestParam Date rentalStartDate, @RequestParam Date rentalEndDate) {
        float totalCost = rentalsService.calculateTotalCost(rentalStartDate, rentalEndDate);
        return CommonResult.success(totalCost);
    }

}
