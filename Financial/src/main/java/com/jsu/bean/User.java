package com.jsu.bean;
//用户类
public class User {
    private Integer userId;
    private String userName;
    private String passWord;
    private String name;
    private String email;
    private String other;
    private String headShot;

    public User() {
    }

    public User(Integer userId,String userName, String passWord) {
        this.userId=userId;
        this.userName = userName;
        this.passWord = passWord;
    }


    public User(Integer userId, String userName, String passWord, String name, String email, String other, String headShot) {
        this.userId = userId;
        this.userName = userName;
        this.passWord = passWord;
        this.name = name;
        this.email = email;
        this.other = other;
        this.headShot = headShot;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOther() {
        return other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHeadShot() {
        return headShot;
    }

    public void setHeadShot(String headShot) {
        this.headShot = headShot;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", passWord='" + passWord + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", other='" + other + '\'' +
                ", headShot='" + headShot + '\'' +
                '}';
    }
}
