package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @TableName rentals
 */
@TableName(value ="rentals")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Rentals implements Serializable {
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer rentalId;

    /**
     *
     */
    private Integer customerId;

    /**
     *
     */
    private Integer inventoryId;

    /**
     *
     */
    private Date rentalStartDate;

    /**
     *
     */
    private Date rentalEndDate;

    /**
     *
     */
    private Object rentalStatus;

    /**
     *
     */
    private BigDecimal totalCost;

    /**
     *
     */
    private Date createdAt;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
