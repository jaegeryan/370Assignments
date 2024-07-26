package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @TableName inventory
 */
@TableName(value ="inventory")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Inventory implements Serializable {
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer inventoryId;

    /**
     *
     */
    private Integer consoleId;

    /**
     *
     */
    private String serialNumber;

    /**
     *
     */
    private Object status;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
