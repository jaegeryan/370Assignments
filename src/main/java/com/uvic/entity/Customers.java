package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;

/**
 *
 * @TableName customers
 */
@TableName(value ="customers")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Customers implements Serializable {
    /**
     *
     */
    @TableId(type = IdType.AUTO)
    private Integer customerId;

    /**
     *
     */
    private String firstName;

    /**
     *
     */
    private String lastName;

    /**
     *
     */
    private String email;

    /**
     *
     */
    private String phoneNumber;

    /**
     *
     */
    private String address;

    /**
     *
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    /**
     *
     */
    private Integer rewardsPoints;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
