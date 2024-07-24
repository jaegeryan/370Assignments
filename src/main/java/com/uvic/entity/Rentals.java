package com.uvic.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 *
 * @TableName rentals
 */
@TableName(value ="rentals")
@Data
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

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Rentals other = (Rentals) that;
        return (this.getRentalId() == null ? other.getRentalId() == null : this.getRentalId().equals(other.getRentalId()))
            && (this.getCustomerId() == null ? other.getCustomerId() == null : this.getCustomerId().equals(other.getCustomerId()))
            && (this.getInventoryId() == null ? other.getInventoryId() == null : this.getInventoryId().equals(other.getInventoryId()))
            && (this.getRentalStartDate() == null ? other.getRentalStartDate() == null : this.getRentalStartDate().equals(other.getRentalStartDate()))
            && (this.getRentalEndDate() == null ? other.getRentalEndDate() == null : this.getRentalEndDate().equals(other.getRentalEndDate()))
            && (this.getRentalStatus() == null ? other.getRentalStatus() == null : this.getRentalStatus().equals(other.getRentalStatus()))
            && (this.getTotalCost() == null ? other.getTotalCost() == null : this.getTotalCost().equals(other.getTotalCost()))
            && (this.getCreatedAt() == null ? other.getCreatedAt() == null : this.getCreatedAt().equals(other.getCreatedAt()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getRentalId() == null) ? 0 : getRentalId().hashCode());
        result = prime * result + ((getCustomerId() == null) ? 0 : getCustomerId().hashCode());
        result = prime * result + ((getInventoryId() == null) ? 0 : getInventoryId().hashCode());
        result = prime * result + ((getRentalStartDate() == null) ? 0 : getRentalStartDate().hashCode());
        result = prime * result + ((getRentalEndDate() == null) ? 0 : getRentalEndDate().hashCode());
        result = prime * result + ((getRentalStatus() == null) ? 0 : getRentalStatus().hashCode());
        result = prime * result + ((getTotalCost() == null) ? 0 : getTotalCost().hashCode());
        result = prime * result + ((getCreatedAt() == null) ? 0 : getCreatedAt().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", rentalId=").append(rentalId);
        sb.append(", customerId=").append(customerId);
        sb.append(", inventoryId=").append(inventoryId);
        sb.append(", rentalStartDate=").append(rentalStartDate);
        sb.append(", rentalEndDate=").append(rentalEndDate);
        sb.append(", rentalStatus=").append(rentalStatus);
        sb.append(", totalCost=").append(totalCost);
        sb.append(", createdAt=").append(createdAt);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}
