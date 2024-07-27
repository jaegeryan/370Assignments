package com.uvic.controller;

import com.uvic.entity.Consoles;
import com.uvic.mapper.ConsolesMapper;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.PathVariable;
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
    public CommonResult list() {
        List<Consoles> consoles = consolesMapper.selectList(null);
        return CommonResult.success(consoles);
    }

    @RequestMapping(value = "/getConsoleById/{id}")
    @ResponseBody
    public CommonResult getConsoleById(@PathVariable Integer id) {
        Consoles consoles = consolesMapper.selectById(id);
        return CommonResult.success(consoles);
    }

    @RequestMapping(value = "/getConsoleByType/{type}")
    @ResponseBody
    public CommonResult getConsoleByType(@PathVariable String type) {
        List<Consoles> consoles = consolesMapper.selectByType(type);
        return CommonResult.success(consoles);
    }
}
