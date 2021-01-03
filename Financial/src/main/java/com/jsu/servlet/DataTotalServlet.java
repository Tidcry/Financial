package com.jsu.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/DataTotalServlet")
public class DataTotalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet( request,  response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String method=request.getParameter("method");

        if("month".equals(method)) {
            String date = request.getParameter("date");
            System.out.println("????" + date);
            request.getSession().setAttribute("SESSION_Month", date);
            request.getRequestDispatcher("/dataOfMonth.jsp").forward(request, response);
        }else if("year".equals(method)){
            String date = request.getParameter("date");
            System.out.println("????" + date);
            request.getSession().setAttribute("SESSION_Year", date);
            request.getRequestDispatcher("/dataOfYear.jsp").forward(request, response);
        }
    }
}
