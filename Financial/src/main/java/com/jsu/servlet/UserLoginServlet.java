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
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(urlPatterns = "/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet( request,  response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        //获取前台提交的用户名和密码
        String userName = request.getParameter("userName");
        String passWord = request.getParameter("passWord");


//        System.out.println(userName+" "+passWord);

        // 根据用户名 和密码查询申请人
        UserDao userDao = new UserDao();

        User user = userDao.getUserByNameAndPass(userName,passWord);
        //判断user == null，返回登录页面，不为空，就进入主页面
        if (user!=null){

//            InfoTransfer(response,"登录成功！","/Financial/index.jsp");
            //将登陆用户对象保存到session
            request.getSession().setAttribute("SESSION_USER",user);
            request.getSession().setAttribute("SESSION_Month",new SimpleDateFormat("yyyy-MM").format(new Date()));
            request.getSession().setAttribute("SESSION_Year",new SimpleDateFormat("yyyy").format(new Date()));
            InfoTransfer(response,"'flag':'true'","'info':'登录成功！'","'src':'/Financial/index.jsp'");
//
//            //用户密码输入正确，是否填写简历
//            //按照当前登录用户id判断，用户是否填写简历
//            Integer resumeID = applicantDAO.isExistResume(applicant.getApplicantId());
//
//            if (resumeID!=null){
//                //将简历ID放入Session中
//                request.getSession().setAttribute("SESSION_RESUMEID",resumeID);
//                response.sendRedirect("CompanyServlet");
//            }else {
//
//                InfoTransfer(response,"登录成功！","applicant/resumeBasicInfoAdd.jsp");
////                response.sendRedirect("applicant/resumeBasicInfoAdd.jsp");
//            }
        }else {

            InfoTransfer(response,"'flag':'false'","'info':'用户名或密码错误！'","'src':'/Financial/login.html'");
            //response.sendRedirect("/Financial/login.html");
        }
    }

    static void InfoTransfer(HttpServletResponse response,String flag,String info,String src) throws IOException {
        PrintWriter pw = response.getWriter();
        pw.write("{");
        pw.write(flag+","+info+","+src);
        pw.write("}");
        pw.flush();
        pw.close();
    }
}
