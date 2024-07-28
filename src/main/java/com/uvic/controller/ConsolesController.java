package com.uvic.controller;

import com.uvic.entity.Consoles;
import com.uvic.mapper.ConsolesMapper;
import com.uvic.service.ConsolesService;
import com.uvic.util.CommonResult;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/consoles")
public class ConsolesController {

    @Resource
    private ConsolesMapper consolesMapper;

    @Resource
    private ConsolesService consolesService;

    @RequestMapping(value = "/getAllConsoles", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult list() {
        List<Consoles> consoles = consolesMapper.selectList(null);
        return CommonResult.success(consoles);
    }

    @RequestMapping(value = "/getConsoleById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult getConsoleById(@PathVariable Integer id) {
        Consoles consoles = consolesMapper.selectById(id);
        return CommonResult.success(consoles);
    }

    @RequestMapping(value = "/getConsoleByType/{type}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult getConsoleByType(@PathVariable String type) {
        List<Consoles> consoles = consolesMapper.selectByType(type);
        return CommonResult.success(consoles);
    }

    @RequestMapping(value = "/addConsole", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult addConsole(Consoles consoles) {
        int insert = consolesService.addConsole(consoles);
        if (insert > 0) {
            return CommonResult.success(insert);
        } else {
            return CommonResult.failed();
        }
    }
}
