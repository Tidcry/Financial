package com.jsu.servlet;

import com.jsu.bean.User;
import com.jsu.dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(urlPatterns = "/UserInfoServlet")
@MultipartConfig
public class UserInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        response.setContentType("text/html;charset=UTF-8");
        String method=request.getParameter("method");

        if("updatePersonalInfo".equals(method)) {
            Part part = request.getPart("headShot");

            //上传文件名head1.jpg
            String fileName = part.getSubmittedFileName();
            System.out.println("------------"+fileName);
            //创建保存文件目录
            //C:\\software\\apache-tomcat-9.0.22\\webapps\\offers_war_exploded/applicant/images
            String dir=this.getServletContext().getRealPath("/images");
            //判断 目录是否存在
            File imgDir= new File(dir);
            if(!imgDir.exists()){
                imgDir.mkdirs();
            }
            //上传到服务器文件路径imgDir+'/'+fileName
            part.write(dir+"/"+fileName);

            //获取前台提交信息
            String nickName = new String (request.getParameter("nickname").getBytes("ISO-8859-1"),"UTF-8");
            String email = request.getParameter("email");
            String remark = new String (request.getParameter("remark").getBytes("ISO-8859-1"),"UTF-8");


            User user=(User) request.getSession().getAttribute("SESSION_USER");
            user.setName(nickName);
            user.setEmail(email);
            user.setOther(remark);
            user.setHeadShot(fileName);
            System.out.println(user.toString());

            request.getSession().setAttribute("SESSION_USER",user);

            UserDao userDao=new UserDao();

            //更新操作
            boolean flag=userDao.update(user);
            if(flag){
                InfoTransfer(response,"保存成功！","/Financial/personalInfo.jsp");
            }else{
                InfoTransfer(response,"保存失败！","/Financial/personalInfo.jsp");
            }
        }else if("updatePassWordInfo".equals(method)){
            String oldpwd=request.getParameter("oldpwd");
            String newpwd=request.getParameter("newpwd");
            String confirmpwd=request.getParameter("confirmpwd");

            User user=(User) request.getSession().getAttribute("SESSION_USER");
            if(!user.getPassWord().equals(oldpwd)){
                InfoTransfer(response,"原密码不正确！","/Financial/passWordInfo.jsp");
            }else{
                if(!newpwd.equals(confirmpwd)){
                    InfoTransfer(response,"新密码前后不一致！","/Financial/passWordInfo.jsp");
                }
                else{
                    user.setPassWord(newpwd);
                    request.getSession().setAttribute("SESSION_USER",user);

                    UserDao userDao=new UserDao();
                    boolean flag=userDao.update(user);
                    if(flag){
                        InfoTransfer(response,"修改成功！","/Financial/passWordInfo.jsp");
                    }else{
                        InfoTransfer(response,"修改失败！","/Financial/passWordInfo.jsp");
                    }
                }
            }
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
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
