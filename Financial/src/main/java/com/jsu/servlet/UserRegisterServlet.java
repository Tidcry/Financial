package com.jsu.servlet;

import com.jsu.bean.User;
import com.jsu.dao.UserDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        response.setContentType("text/html;charset=UTF-8");
        //获取前台提交的用户名和密码
        String userName = request.getParameter("userName");
        String passWord = request.getParameter("passWord");
        String againPwd = request.getParameter("againPwd");
        if(!passWord.equals(againPwd)){
            UserRegisterServlet.InfoTransfer(response,"注册失败，密码不一致！","/Financial/register.html");
        }
        else {

//            System.out.println(userName + " " + passWord);
            //插入到数据库中，对数据进行封装，自己封装成一个对象
            User user = new User(null, userName, passWord,"null","null","null","anonymous.png");

            //保存user到数据库 UserDAO
            UserDao userDAO = new UserDao();

            //判断是否有相同的email
            Integer count = userDAO.selectCount(userName);
            if (count > 0) {
                //数据库中已经有相同email的用户
                //通过response对象给客户端一个错误提示
                UserRegisterServlet.InfoTransfer(response, "注册失败，用户名已存在！", "/Financial/register.html");
            } else {
                //flag是否注册成功
                boolean flag = userDAO.saveUser(user);

                if (flag) {
                    //注册成功就跳转到登录页面 重定向
                    UserRegisterServlet.InfoTransfer(response, "注册成功！", "/Financial/login.html");
                    //response.sendRedirect("/login.html");

                } else {
                    //注册失败就返回注册页面
                    UserRegisterServlet.InfoTransfer(response, "注册失败！", "/Financial/register.html");
//                RequestDispatcher dispatcher = request.getRequestDispatcher("/offers/register.html");
//                dispatcher.forward(request,response);
                }
            }
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost( request,  response);
    }

    static void InfoTransfer(HttpServletResponse response,String info,String src) throws IOException {
        PrintWriter writer = response.getWriter();
        writer.write("<script>");
        writer.write("alert('"+info+"');");
        writer.write("window.location.href='"+src+"'");
        writer.write("</script>");
        writer.flush();
        writer.close();
    }
}

