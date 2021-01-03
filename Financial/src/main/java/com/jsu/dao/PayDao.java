package com.jsu.dao;

import com.jsu.bean.Income;
import com.jsu.bean.Pay;
import com.jsu.utils.DBUtils;

import java.util.List;

public class PayDao {
    //保存对象
    public boolean savePay(Pay pay) {
        String sql = "insert into pay(userId,type,price,date,remarks)" +
                "values(?,?,?,?,?)";
        return DBUtils.save(sql,pay.getUserId(),pay.getType(),pay.getPrice(),pay.getDate(),pay.getRemarks());
    }

    //根据userId查询pay
    public List<Pay> getPayListByUserId(Integer userId)  {
        String sql="select * from pay where userId=?";
        List<Pay> payList = DBUtils.getList(Pay.class,sql,userId);
        return payList;
    }

    //删除
    public boolean deletePay(String payId){
        String sql="delete from pay where payId=?";
        boolean flag=DBUtils.delete(sql,payId);
        return flag;
    }
    //根据payId查询pay
    public Pay getPayByPayId(Integer payId){
        String sql="select * from pay where payId=?";
        Pay pay=DBUtils.getSingleObj(Pay.class,sql,payId);
        return pay;
    }

    //更新
    public boolean updatePayInfo(Pay pay) {
        String sql="update pay set \n" +
                "type = ?,\n" +
                "price = ?,\n" +
                "date = ?,\n" +
                "remarks = ?\n" +
                " where payId=?";
        boolean flag = DBUtils.update(sql,pay.getType(),pay.getPrice(),pay.getDate(),pay.getRemarks(),pay.getPayId());
        return flag;
    }
    //查询一共多少行
    public Integer getPayCountByUserId(String sql , Object...param) {

        Integer count = DBUtils.getCount(sql , param);
        return count;
    }

    //分页查询
    public List<Pay> getPayListByPage(String sql)  {

        List<Pay> payList = DBUtils.getList(Pay.class,sql);
        return payList;
    }
}
