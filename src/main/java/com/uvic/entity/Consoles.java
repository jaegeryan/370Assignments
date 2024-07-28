package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @TableName consoles
 */
@TableName(value ="consoles")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Consoles implements Serializable {
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer consoleId;

    /**
     *
     */
    private String model;

    /**
     *
     */
    private String type;

    /**
     *
     */
    private String storageCapacity;

    /**
     *
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date purchaseDate;

    /**
     *
     */
    private BigDecimal cost;

    /**
     *
     */
    private String serialNumber;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
