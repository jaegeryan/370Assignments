package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import lombok.Data;

/**
 * 
 * @TableName VIP_Customers
 */
@TableName(value ="VIP_Customers")
@Data
public class VipCustomers implements Serializable {
    /**
     * 
     */
    @TableId
    private Integer customerId;

    /**
     * 
     */
    private String membershipLevel;

    /**
     * 
     */
    private BigDecimal additionalDiscount;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}