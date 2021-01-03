package com.jsu.bean;

import java.util.Date;

//收入账单
public class Income {
    private Integer incomeId;
    private Integer userId;
    private String type;
    private double price;
    private Date date;
    private String remarks;

    public Income() {
    }

    public Income(Integer incomeId, Integer userId, String type, double price, Date date, String remarks) {
        this.incomeId = incomeId;
        this.userId = userId;
        this.type = type;
        this.price = price;
        this.date = date;
        this.remarks = remarks;
    }

    public Integer getIncomeId() {
        return incomeId;
    }

    public void setIncomeId(Integer incomeId) {
        this.incomeId = incomeId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Income{" +
                "incomeId='" + incomeId + '\'' +
                ", userId='" + userId + '\'' +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", date='" + date + '\'' +
                ", remarks='" + remarks + '\'' +
                '}';
    }
}
