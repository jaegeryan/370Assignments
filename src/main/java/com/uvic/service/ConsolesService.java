package com.uvic.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.uvic.entity.Consoles;

/**
* @author Jaegeryan
* @description 针对表【consoles】的数据库操作Service
* @createDate 2024-07-20 06:31:20
*/
public interface ConsolesService extends IService<Consoles> {

    int addConsole(Consoles consoles);
}
