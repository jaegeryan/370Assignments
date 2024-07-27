package com.uvic.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.uvic.entity.Consoles;

import java.util.List;

/**
* @author Jaegeryan
* @description 针对表【consoles】的数据库操作Mapper
* @createDate 2024-07-20 06:31:20
* @Entity com.uvic.entity.Consoles
*/
public interface ConsolesMapper extends BaseMapper<Consoles> {

    List<Consoles> selectByType(String type);
}




