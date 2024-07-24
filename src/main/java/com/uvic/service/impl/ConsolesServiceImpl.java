package com.uvic.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.uvic.entity.Consoles;
import com.uvic.service.ConsolesService;
import com.uvic.mapper.ConsolesMapper;
import org.springframework.stereotype.Service;

/**
* @author Jaegeryan
* @description 针对表【consoles】的数据库操作Service实现
* @createDate 2024-07-20 06:31:20
*/
@Service
public class ConsolesServiceImpl extends ServiceImpl<ConsolesMapper, Consoles>
    implements ConsolesService{

}




