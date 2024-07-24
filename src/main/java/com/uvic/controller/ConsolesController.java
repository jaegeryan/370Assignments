package com.uvic.controller;

import com.uvic.entity.Consoles;
import com.uvic.mapper.ConsolesMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/consoles")
public class ConsolesController {

    @Resource
    private ConsolesMapper consolesMapper;

    @RequestMapping(value = "/getAllConsoles")
    @ResponseBody
    public Object list() {
        List<Consoles> consoles = consolesMapper.selectList(null);
        return CommonResult.success(consoles);
    }

}
