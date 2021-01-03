<%@ page import="com.jsu.dao.PayDao" %>
<%@ page import="com.jsu.bean.Pay" %>
<%@ page import="com.jsu.bean.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<head>
  <meta charset="utf-8">
  <title>修改支出账单</title>
  <link rel="icon" href="images/favicon.ico" type="image/ico">
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/materialdesignicons.min.css" rel="stylesheet">
  <link href="css/style.min.css" rel="stylesheet">
  <link href="css/new.css" rel="stylesheet">
  <!--日期选择插件-->
  <link rel="stylesheet" href="js/bootstrap-datepicker/bootstrap-datepicker3.min.css">
  <%
    String payId=request.getParameter("payId");
    System.out.println(payId);
    PayDao payDao=new PayDao();
    Pay pay=payDao.getPayByPayId(Integer.parseInt(payId));
    System.out.println("------------"+pay.getType());
  %>

</head>
  
<body>
<div class="lyear-layout-web">
  <div class="lyear-layout-container">
    <!--左侧导航-->
    <aside class="lyear-layout-sidebar">

      <!-- logo -->
      <div id="logo" class="sidebar-header">
        <a href="index.jsp"><img src="images/logo-sidebar.png" title="LightYear" alt="LightYear" /></a>
      </div>
      <div class="lyear-layout-sidebar-scroll">

        <nav class="sidebar-main">
          <ul class="nav nav-drawer">
            <li class="nav-item"> <a href="index.jsp"><i class="mdi mdi-home"></i> 后台首页</a> </li>

            <li class="nav-item"> <a href="index.jsp"><i class="mdi mdi-home"></i> 后台首页</a> </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-account"></i> 个人信息管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="personalInfo.jsp">个人信息</a></li>
                <li> <a href="passWordInfo.jsp">修改密码</a></li>
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav active open">
              <a href="javascript:void(0)"><i class="mdi mdi-calendar-check"></i> 账单管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="/Financial/IncomeInfoServlet?method=searchInfoByUserId">收入账单</a> </li>
                <li> <a href="/Financial/PayInfoServlet?method=searchInfoByUserId">支出账单</a> </li>
                <li class="active"><a href="updatePay.jsp">编辑支出账单</a> </li>
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-chart-bar"></i> 报表统计</a>
              <ul class="nav nav-subnav">
                <li> <a href="dataOfMonth.jsp">按月统计</a></li>
                <li> <a href="dataOfYear.jsp">按年统计</a></li>
              </ul>
            </li>
          </ul>
        </nav>

        <div class="sidebar-footer">
          <p class="copyright">© 2020 JSU软4杨子轩</p>
        </div>
      </div>

    </aside>
    <!--End 左侧导航-->
    
    <!--头部信息-->
    <header class="lyear-layout-header">
      
      <nav class="navbar navbar-default">
        <div class="topbar">
          
          <div class="topbar-left">
            <div class="lyear-aside-toggler">
              <span class="lyear-toggler-bar"></span>
              <span class="lyear-toggler-bar"></span>
              <span class="lyear-toggler-bar"></span>
            </div>
            <span class="navbar-page-title"> 账单管理 - 修改支出账单 </span>
          </div>
          
          <ul class="topbar-right">
            <li class="dropdown dropdown-profile">
              <a href="javascript:void(0)" data-toggle="dropdown">
                <img class="img-avatar img-avatar-48 m-r-10" src="<%="images/"+((User)request.getSession().getAttribute("SESSION_USER")).getHeadShot()%>" alt="笔下光年" />
                <span><%=((User)request.getSession().getAttribute("SESSION_USER")).getUserName()%> <span class="caret"></span></span>
              </a>
              <ul class="dropdown-menu dropdown-menu-right">
                <li> <a href="personalInfo.jsp"><i class="mdi mdi-account"></i> 个人信息</a> </li>
                <li> <a href="passWordInfo.jsp"><i class="mdi mdi-lock-outline"></i> 修改密码</a> </li>
                <li> <a href="javascript:void(0)"><i class="mdi mdi-delete"></i> 清空缓存</a></li>
                <li class="divider"></li>
                <li> <a href="login.html"><i class="mdi mdi-logout-variant"></i> 退出登录</a> </li>
              </ul>
            </li>
          </ul>
          
        </div>
      </nav>
      
    </header>
    <!--End 头部信息-->
    
    <!--页面主要内容-->
    <main class="lyear-layout-content">
      
      <div class="container-fluid">
        
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-body">
<!--                提交信息到后台-->
                <form action="/Financial/PayInfoServlet?method=update&payId=<%=pay.getPayId()%>" method="post" class="row">
                  <div class="form-group col-md-12">
                    <label for="type">收入来源</label>
                    <div class="form-controls">
                      <select name="type" class="form-control" id="type">
                        <option value="1">餐饮</option>
                        <option value="2">服饰</option>
                        <option value="3">家居</option>
                        <option value="4">交通</option>
                        <option value="5">医疗</option>
                        <option value="6">娱乐</option>
                        <option value="7">其他</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group col-md-12">
                    <label for="title">金额</label>
                    <input type="text" class="form-control" id="title" name="price" value="<%=pay.getPrice()%>" autocomplete="off" placeholder="请输入金额" />
                  </div>
                  <div class="form-group col-md-12">
                    <label for="seo_keywords">日期</label>
                    <input type="text" class="form-control js-datepicker" id="seo_keywords" name="date" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(pay.getDate())%>" autocomplete="off" placeholder="请选择日期" data-date-format="yyyy-mm-dd"/>
                  </div>
                  <div class="form-group col-md-12">
                    <label for="seo_description">备注</label>
                    <textarea class="form-control" id="seo_description" name="remarks" rows="5" value="" autocomplete="off" placeholder="描述"><%=pay.getRemarks()%></textarea>
                  </div>
                  <div class="form-group col-md-12">
                    <button type="submit" class="btn btn-primary ajax-post" target-form="add-form">确 定</button>
                    <button type="button" class="btn btn-default" onclick="javascript:history.back(-1);return false;">返 回</button>
                  </div>
                </form>
       
              </div>
            </div>
          </div>
          
        </div>
        
      </div>
      
    </main>
    <!--End 页面主要内容-->
  </div>
</div>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
<!--日期选择插件-->
<script src="js/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="js/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script type="text/javascript" src="js/main.min.js"></script>
<script type="text/javascript">
  $("#type").val("<%=pay.getType()%>"); // 设置Select的Value值为?的项选中
</script>
</body>
</html>