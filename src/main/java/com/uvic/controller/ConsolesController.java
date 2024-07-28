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

    @RequestMapping(value = "/updateConsole", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateConsole(@RequestBody Consoles consoles) {
        int update = consolesService.updateConsole(consoles);
        if (update > 0) {
            return CommonResult.success(update, "The console has been updated successfully");
        } else {
            return CommonResult.failed();
        }
    }

    @RequestMapping(value = "/addConsole", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult addConsole(@RequestBody Consoles consoles) {
        int insert = consolesService.addConsole(consoles);
        if (insert > 0) {
            return CommonResult.success(insert, "The console has been added successfully");
        } else {
            return CommonResult.failed();
        }
    }

    @RequestMapping(value = "/deleteConsoleById/{id}", method = RequestMethod.GET)
    @ResponseBody
    public CommonResult deleteConsoleById(@PathVariable Integer id) {
        int delete = consolesService.deleteConsoleById(id);
        if (delete > 0) {
            return CommonResult.success(delete, "The console has been deleted successfully");
        } else {
            return CommonResult.failed();
        }
    }
}
