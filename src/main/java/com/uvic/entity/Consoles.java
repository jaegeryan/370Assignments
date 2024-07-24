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
 * @TableName consoles
 */
@TableName(value ="consoles")
@Data
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
    private Date purchaseDate;

    /**
     *
     */
    private BigDecimal cost;

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
        Consoles other = (Consoles) that;
        return (this.getConsoleId() == null ? other.getConsoleId() == null : this.getConsoleId().equals(other.getConsoleId()))
            && (this.getModel() == null ? other.getModel() == null : this.getModel().equals(other.getModel()))
            && (this.getType() == null ? other.getType() == null : this.getType().equals(other.getType()))
            && (this.getStorageCapacity() == null ? other.getStorageCapacity() == null : this.getStorageCapacity().equals(other.getStorageCapacity()))
            && (this.getPurchaseDate() == null ? other.getPurchaseDate() == null : this.getPurchaseDate().equals(other.getPurchaseDate()))
            && (this.getCost() == null ? other.getCost() == null : this.getCost().equals(other.getCost()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getConsoleId() == null) ? 0 : getConsoleId().hashCode());
        result = prime * result + ((getModel() == null) ? 0 : getModel().hashCode());
        result = prime * result + ((getType() == null) ? 0 : getType().hashCode());
        result = prime * result + ((getStorageCapacity() == null) ? 0 : getStorageCapacity().hashCode());
        result = prime * result + ((getPurchaseDate() == null) ? 0 : getPurchaseDate().hashCode());
        result = prime * result + ((getCost() == null) ? 0 : getCost().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", consoleId=").append(consoleId);
        sb.append(", model=").append(model);
        sb.append(", type=").append(type);
        sb.append(", storageCapacity=").append(storageCapacity);
        sb.append(", purchaseDate=").append(purchaseDate);
        sb.append(", cost=").append(cost);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}
