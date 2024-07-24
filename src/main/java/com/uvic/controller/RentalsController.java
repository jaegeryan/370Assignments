package com.uvic.controller;

import com.uvic.mapper.RentalsMapper;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/rentals")
public class RentalsController {

    @Resource
    private RentalsMapper rentalsMapper;
}
