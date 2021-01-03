package com.jsu.servlet;

import com.jsu.bean.PageBean;
import com.jsu.bean.Pay;
import com.jsu.bean.User;
import com.jsu.dao.PayDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/PayInfoServlet")
public class PayInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet( request,  response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String method = request.getParameter("method");

        if("add".equals(method)) {

            //封装对象
            Pay pay=requestDataObj(request);
            System.out.println("???????????????????"+pay.toString());
            //保存pay到数据库 payDAO
            PayDao payDao = new PayDao();
            boolean flag = payDao.savePay(pay);

            if (flag) {

                PageBean pageBean=page(request,(String)request.getSession().getAttribute("SESSION_SQL"));
                request.setAttribute("pageBean",pageBean);

                request.getRequestDispatcher("/pay.jsp").forward(request,response);
//                InfoTransfer(response, "添加成功!", "/Financial/pay.jsp");

            } else {
//            response.sendRedirect("addPay.jsp");
                InfoTransfer(response, "添加失败!", "/Financial/addPay.jsp");
            }

        }else if("searchByInfo".equals(method)){

            String sql="";
            int userId = ((User) request.getSession().getAttribute("SESSION_USER")).getUserId();
            String type=request.getParameter("type");
            String lowPrice=request.getParameter("lowPrice");
            String highPrice=request.getParameter("highPrice");
            String startDate=request.getParameter("startDate");
            String endDate=request.getParameter("endDate");
            if(!type.equals("0")){
                sql=sql+" and type="+type;
            }
            if(!lowPrice.equals("")){
                sql=sql+" and price>="+lowPrice;
            }
            if(!highPrice.equals("")){
                sql=sql+" and price<="+highPrice;
            }
            if(!startDate.equals("")){
                sql=sql+" and date>='"+startDate+"'";
            }
            if(!endDate.equals("")){
                sql=sql+" and date<='"+endDate+"'";
            }
            System.out.println(userId+" "+type+" "+lowPrice+" "+highPrice+" "+startDate+" "+endDate);

            request.getSession().setAttribute("SEESION_SQL",sql);
            PageBean pageBean=page(request,sql);

            if(pageBean.getList().isEmpty()){
                InfoTransfer(response, "暂无查询结果!", "/Financial/pay.jsp");
            }
            else{
                request.setAttribute("pageBean",pageBean);
                //请求转发到收入账单管理页面
                request.getRequestDispatcher("/pay.jsp").forward(request,response);
            }



//ajax方式
//从session中取出登录用户的id
//            int userId = ((User) request.getSession().getAttribute("SESSION_USER")).getUserId();
//            String sql = "select * from pay where userId="+userId;
//            //把当前用户所有收入账单查询出来
//            payDao payDao=new payDao();
//            List payList=payDao.getpayListByUserId(sql);
//            //将list集合装换成json对象
//            JSONArray data = JSONArray.fromObject(payList);
//            System.out.println("sdffa");
//            //接下来发送数据
//            //得到输出流
//            PrintWriter writter = response.getWriter();
//            //将JSON格式的对象toString()后发送
//            writter.append(data.toString());

        }else if("searchInfoByUserId".equals(method)){
            request.getSession().setAttribute("SESSION_SQL","");

            PageBean pageBean=page(request,(String)request.getSession().getAttribute("SESSION_SQL"));
            request.setAttribute("pageBean",pageBean);

            if(pageBean.getList().isEmpty()){
                InfoTransfer(response, "暂无查询结果!", "/Financial/pay.jsp");
            }
            else{
                //请求转发到收入账单管理页面
                request.getRequestDispatcher("/pay.jsp").forward(request,response);
            }



//            List<pay> list=payDao.getpayListByUserId(userId);
//            request.setAttribute("searchInfo","");
//            request.getRequestDispatcher("/pay.jsp").forward(request,response);
        }else if("delete".equals(method)){
            String payId=request.getParameter("payId");
            PayDao payDao=new PayDao();
            boolean flag=payDao.deletePay(payId);
//            request.getRequestDispatcher("/pay.jsp").forward(request,response);

            if(flag){
                PageBean pageBean=page(request,(String)request.getSession().getAttribute("SESSION_SQL"));
                request.setAttribute("pageBean",pageBean);
                request.getRequestDispatcher("/pay.jsp").forward(request,response);
//                InfoTransfer(response,"删除成功！","/Financial/pay.jsp");

            }else{
                InfoTransfer(response,"删除失败！","/Financial/pay.jsp");

            }
        }else if("update".equals(method)){
            Integer payId=Integer.parseInt(request.getParameter("payId"));
            PayDao payDao=new PayDao();
            Pay pay=requestDataObj(request);
            pay.setPayId(payId);
            boolean flag= payDao.updatePayInfo(pay);

            if(flag){
                PageBean pageBean=page(request,(String)request.getSession().getAttribute("SESSION_SQL"));
                request.setAttribute("pageBean",pageBean);

                request.getRequestDispatcher("/pay.jsp").forward(request,response);
//                InfoTransfer(response,"编辑成功！","/Financial/pay.jsp");
            }else{
                InfoTransfer(response,"编辑失败！","/Financial/pay.jsp");

            }
        }else if("pageSwitch".equals(method)){
            PageBean pageBean=page(request,(String)request.getSession().getAttribute("SESSION_SQL"));
            request.setAttribute("pageBean",pageBean);
            request.getRequestDispatcher("/pay.jsp").forward(request,response);
        }
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

    //获取页面数据，封装 ResumeBasicInfo
    private Pay requestDataObj(HttpServletRequest request) throws UnsupportedEncodingException {
        //获取前台提交的收入账单信息
        String type = request.getParameter("type");
        double price = Double.parseDouble(request.getParameter("price"));
        String date = request.getParameter("date");
        String remarks = new String (request.getParameter("remarks").getBytes("ISO-8859-1"),"UTF-8");

        System.out.println("----------------------"+type+" "+price+" "+date+" "+remarks );

        //字符串转日期
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Date d=null;
        try {
            d= sdf.parse(date);
        }catch (ParseException e){
            e.printStackTrace();
        }

        //从session中取出登录用户的id
        //对数据进行封装，封装成一个对象
        int userId = ((User) request.getSession().getAttribute("SESSION_USER")).getUserId();
        Pay pay = new Pay(null, userId, type, price, d, remarks);

        return pay;
    }
    public PageBean page(HttpServletRequest request,String sql){

        //1.每页多少行 pageSize
        String pageSizeStr = request.getParameter("pageSize");
        Integer pageSize = null;
        if (pageSizeStr!=null && pageSizeStr.length()>0){
            pageSize = Integer.valueOf(pageSizeStr);
        } else {
            pageSize = 10;
        }
        System.out.println(pageSizeStr);
        System.out.println(pageSize);

        //2.当前是第几页 currentPage
        String currentPageStr = request.getParameter("currentPage");
        Integer currentPage = null;
        if (currentPageStr!=null && currentPageStr.length() > 0){
            currentPage = Integer.valueOf(currentPageStr);
        } else {
            currentPage = 1;
        }
        System.out.println(currentPageStr);
        System.out.println(currentPage);

        //3.一共有多少行数据 totalRows
        Integer totalRows = 0;
        PayDao payDao = new PayDao();
        int userId = ((User) request.getSession().getAttribute("SESSION_USER")).getUserId();
        String sqlCount = "select count(*) from pay where userId="+(String.valueOf(userId))+sql;
        totalRows = payDao.getPayCountByUserId(sqlCount);
        System.out.println(totalRows);


        //5.起始行 startRow
        Integer startRow = (currentPage-1) * pageSize;
        System.out.println(startRow);

        StringBuffer sqlRow = new StringBuffer("SELECT \n" +
                "payId,\n" +
                "type,\n" +
                "price,\n" +
                "date,\n" +
                "remarks \n" +
                "FROM \n" +
                "pay where userId="+userId +sql+"\n") ;

        sqlRow.append(" limit ").append(startRow).append(",").append(pageSize);
        System.out.println(sqlRow);

        //把所有信息查询出来
        List<Pay> payList =  payDao.getPayListByPage(sqlRow.toString());
        System.out.println(payList.toString());
        PageBean pageBean = new PageBean(currentPage,pageSize,totalRows,payList);
        System.out.println(pageBean);
        return pageBean;
    }
}
