package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @TableName Membership_Rewards
 */
@TableName(value ="Membership_Rewards")
@Data
public class MembershipRewards implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer rewardId;

    /**
     * 
     */
    private Integer customerId;

    /**
     * 
     */
    private Integer rewardPoints;

    /**
     * 
     */
    private Date rewardDate;

    /**
     * 
     */
    private String rewardDescription;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}