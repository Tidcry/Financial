package com.jsu.dao;

import com.jsu.bean.Income;
import com.jsu.bean.User;
import com.jsu.utils.DBUtils;

import java.util.List;

public class IncomeDao {
    //保存对象
    public boolean saveIncome(Income income) {
        String sql = "insert into income(userId,type,price,date,remarks)" +
                "values(?,?,?,?,?)";
        return DBUtils.save(sql,income.getUserId(),income.getType(),income.getPrice(),income.getDate(),income.getRemarks());
    }

    //根据userId查询income
    public List<Income> getIncomeListByUserId(Integer userId)  {
        String sql="select * from income where userId=?";
        List<Income> incomeList = DBUtils.getList(Income.class,sql,userId);
        return incomeList;
    }

    //删除
    public boolean deleteIncome(String incomeId){
        String sql="delete from income where incomeId=?";
        boolean flag=DBUtils.delete(sql,incomeId);
        return flag;
    }
    //根据incomeId查询income
    public Income getIncomeByIncomeId(Integer incomeId){
        String sql="select * from income where incomeId=?";
        Income income=DBUtils.getSingleObj(Income.class,sql,incomeId);
        return income;
    }

    //更新
    public boolean updateIncomeInfo(Income income) {
        String sql="update income set \n" +
                "type = ?,\n" +
                "price = ?,\n" +
                "date = ?,\n" +
                "remarks = ?\n" +
                " where incomeId=?";
        boolean flag = DBUtils.update(sql,income.getType(),income.getPrice(),income.getDate(),income.getRemarks(),income.getIncomeId());
        return flag;
    }
    //查询一共多少行
    public Integer getIncomeCountByUserId(String sql , Object...param) {

        Integer count = DBUtils.getCount(sql , param);
        return count;
    }

    //分页查询
    public List<Income> getIncomeListByPage(String sql)  {

        List<Income> companyList = DBUtils.getList(Income.class,sql);
        return companyList;
    }
}
