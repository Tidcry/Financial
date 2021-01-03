package com.jsu.bean;

import java.util.Date;

//支付账单
public class Pay {
    private Integer payId;
    private Integer userId;
    private String type;
    private double price;
    private Date date;
    private String remarks;


    public Pay() {
    }

    public Pay(Integer payId, Integer userId, String type, double price, Date date, String remarks) {
        this.payId = payId;
        this.userId = userId;
        this.type = type;
        this.price = price;
        this.date = date;
        this.remarks = remarks;
    }

    public Integer getPayId() {
        return payId;
    }

    public void setPayId(Integer payId) {
        this.payId = payId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    @Override
    public String toString() {
        return "Pay{" +
                "payId=" + payId +
                ", userId=" + userId +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", date=" + date +
                ", remarks='" + remarks + '\'' +
                '}';
    }
}
