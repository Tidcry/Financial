package com.jsu.dao;

import com.jsu.bean.Income;
import com.jsu.bean.User;
import com.jsu.utils.DBUtils;

public class UserDao {
    //保存注册对象
    public boolean saveUser(User user) {
        String sql = "insert into users(userName,passWord,name,email,other,headShot)" +
                "values(?,?,?,?,?,?)";

        return DBUtils.save(sql,user.getUserName(),user.getPassWord(),user.getName(),user.getEmail(),user.getOther(),user.getHeadShot());
    }

    // 根据用户名 和密码查询用户
    public User getUserByNameAndPass(String userName, String passWord) {

        String sql = "select * " +
                "from users where userName=? and passWord=? ";
        return DBUtils.getSingleObj(User.class,sql,userName,passWord);
    }

    //查询用户名是否存在
    public Integer selectCount(String userName) {

        String sql = "select count(*) from users a where a.userName = ?";
        Integer count = DBUtils.getCount(sql,userName);
        return count;
    }

    //根据userId查询user
    public User getUserByUserId(Integer userId){
        String sql="select * from users where userId=?";
        User user=DBUtils.getSingleObj(User.class,sql,userId);
        return user;
    }

    //更新个人信息
    public boolean update(User user){
        String sql="update users set \n" +
                "userName = ?,\n" +
                "passWord = ?,\n" +
                "name = ?,\n" +
                "email = ?,\n" +
                "other = ?,\n" +
                "headShot = ? \n" +
                " where userId=?";
        boolean flag=DBUtils.update(sql,user.getUserName(),user.getPassWord(),user.getName(),user.getEmail(),user.getOther(),user.getHeadShot(),user.getUserId());
        return flag;
    }

}
