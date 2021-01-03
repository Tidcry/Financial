<%@ page import="com.jsu.bean.User" %>
<%@ page import="com.jsu.bean.Income" %>
<%@ page import="com.jsu.dao.IncomeDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jsu.bean.Pay" %>
<%@ page import="com.jsu.dao.PayDao" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>首页</title>
<link rel="icon" href="images/favicon.ico" type="image/ico">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/materialdesignicons.min.css" rel="stylesheet">
<link href="css/style.min.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
    <script type="text/javascript" src="js/main.min.js"></script>
</head>
  <%
    Double incomeNow=0.0,incomeYesterday=0.0,payNow=0.0,payYesterday=0.0;
    IncomeDao incomeDao=new IncomeDao();
    PayDao payDao=new PayDao();
    //获取今日、昨日的收入及支出记录，存储到list集合中
    List<Income> incomeNowList=incomeDao.getIncomeListByPage("select * from income where to_days(date) = to_days(now())");
    List<Pay> payNowList=payDao.getPayListByPage("select * from pay where to_days(date) = to_days(now())");
    List<Income> incomeYesterdayList=incomeDao.getIncomeListByPage("select * from income where to_days(NOW()) - TO_DAYS(date) = 1; ");
    List<Pay> payYesterdayList=payDao.getPayListByPage("select * from pay where to_days(NOW()) - TO_DAYS(date) = 1; ");

    //遍历集合，统计各金额
    //统计今日收入
    if(incomeNowList.size()>0){
      for(Income i:incomeNowList){
        incomeNow+=i.getPrice();
      }
    }
    //统计今日支出
    if(payNowList.size()>0){
      for(Pay p:payNowList){
        payNow+=p.getPrice();
      }
    }
    //统计昨日收入
    if(incomeYesterdayList.size()>0){
      for(Income i:incomeYesterdayList){
        incomeYesterday+=i.getPrice();
      }
    }
    //统计昨日支出
    if(payYesterdayList.size()>0){
      for(Pay p:payYesterdayList){
        payYesterday+=p.getPrice();
      }
    }

  %>
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
        <!--左侧列表添加栏目-->
        <nav class="sidebar-main">
          <ul class="nav nav-drawer">
            <li class="nav-item active"> <a href="index.jsp"><i class="mdi mdi-home"></i> 后台首页</a> </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-account"></i> 个人信息管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="personalInfo.jsp">个人信息</a></li>
                <li> <a href="passWordInfo.jsp">修改密码</a></li>
              </ul>
            </li>
            <li class="nav-item nav-item-has-subnav">
              <a href="javascript:void(0)"><i class="mdi mdi-calendar-check"></i> 账单管理</a>
              <ul class="nav nav-subnav">
                <li> <a href="/Financial/IncomeInfoServlet?method=searchInfoByUserId">收入账单</a> </li>
                <li> <a href="/Financial/PayInfoServlet?method=searchInfoByUserId">支出账单</a> </li>
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
            <span class="navbar-page-title"> 后台首页 </span>
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
          <div class="col-sm-6 col-lg-3">
            <div class="card bg-primary">
              <div class="card-body clearfix">
                <div class="pull-right">
                  <p class="h5 text-white m-t-0">今日收入</p>
                  <p class="h3 text-white m-b-0"><%=incomeNow%></p>
                </div>
                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-currency-cny fa-1-5x"></i></span> </div>
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-3">
            <div class="card bg-danger">
              <div class="card-body clearfix">
                <div class="pull-right">
                  <p class="h5 text-white m-t-0">相比昨日收入</p>
                  <p class="h3 text-white m-b-0">
                    <%=incomeNow-incomeYesterday%>
<%--                    <c:when test="${incomeNow>incomeYesterday}">${incomeNow-incomeYesterday}</c:when>--%>
<%--                    <c:when test="${incomeNow<incomeYesterday}">${incomeYesterday-incomeNow}</c:when>--%>
                  </p>
                </div>
                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-currency-cny fa-1-5x fa-1-5x"></i></span> </div>
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-3">
            <div class="card bg-success">
              <div class="card-body clearfix">
                <div class="pull-right">
                  <p class="h5 text-white m-t-0">今日支出</p>
                  <p class="h3 text-white m-b-0"><%=payNow%></p>
                </div>
                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-currency-cny fa-1-5x fa-1-5x"></i></span> </div>
              </div>
            </div>
          </div>

          <div class="col-sm-6 col-lg-3">
            <div class="card bg-purple">
              <div class="card-body clearfix">
                <div class="pull-right">
                  <p class="h5 text-white m-t-0">相比昨日支出</p>
                  <p class="h3 text-white m-b-0"><%=payNow-payYesterday%></p>
                </div>
                <div class="pull-left"> <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-currency-cny fa-1-5x fa-1-5x"></i></span> </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header"><h4>收入与支出</h4></div>
                    <div class="card-body">
                        <canvas id="chart-pie1" width="280" height="280" style="margin-left:30px;display: inline-block;"></canvas>
                        <canvas id="chart-pie2" width="280" height="280" style="margin-left:120px;display: inline-block;"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header"><h4>收入与收入-支出与支出</h4></div>
                    <div class="card-body">
                        <canvas id="chart-pie3" width="280" height="280" style="margin-left:30px;display: inline-block;"></canvas>
                        <canvas id="chart-pie4" width="280" height="280" style="margin-left:120px;display: inline-block;"></canvas>
                    </div>
                </div>
            </div>






<%--          <div class="col-lg-6">--%>
<%--            <div class="card">--%>
<%--              <div class="card-header"><h4>收入与支出</h4></div>--%>
<%--              <div class="card-body">--%>
<%--                <canvas id="chart-pie5" width="280" height="280" style="display: block;"></canvas>--%>
<%--                <canvas id="chart-pie2" width="280" height="280" style="display: inline-block;"></canvas>--%>

<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>

<%--          <div class="col-lg-6">--%>
<%--            <div class="card">--%>
<%--              <div class="card-header"><h4>收入与收入-支出与支出</h4></div>--%>
<%--              <div class="card-body">--%>
<%--                <canvas id="chart-pie3" width="280" height="280" style="display: inline-block;"></canvas>--%>
<%--                <canvas id="chart-pie4" width="280" height="280" style="display: inline-block;"></canvas>--%>

<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>



        </div>

      </div>

    </main>
    <!--End 页面主要内容-->
  </div>
</div>



<!--图表插件-->
<script type="text/javascript" src="js/Chart.js"></script>
<script type="text/javascript">
$(document).ready(function(e) {
    $(document).ready(function(e) {

    new Chart($("#chart-pie"), {
        type: 'pie',
        data: {
            labels: ["红色", "蓝色", "橙色"],
            datasets: [{
                data: [300, 50, 100],
                backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)']
            }]
        },
        options: {
            responsive: false
        }
    });
  new Chart($("#chart-pie1"), {
    type: 'pie',
    data: {
      labels: ["今日收入", "今日支出"],
      datasets: [{
        data: [<%=incomeNow%>, <%=payNow%>],
        backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)']
      }]
    },
    options: {
      responsive: false
    }
  });

  new Chart($("#chart-pie2"), {
    type: 'pie',
    data: {
      labels: ["昨日收入", "昨日支出"],
      datasets: [{
        data: [<%=incomeYesterday%>, <%=payYesterday%>],
        backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)']
      }]
    },
    options: {
      responsive: false
    }
  });
  new Chart($("#chart-pie3"), {
    type: 'pie',
    data: {
      labels: ["今日收入", "昨日收入"],
      datasets: [{
        data: [<%=incomeNow%>, <%=incomeYesterday%>],
        backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)']
      }]
    },
    options: {
      responsive: false
    }
  });

  new Chart($("#chart-pie4"), {
    type: 'pie',
    data: {
      labels: ["今日支出", "昨日支出"],
      datasets: [{
        data: [<%=payNow%>, <%=payYesterday%>],
        backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)']
      }]
    },
    options: {
      responsive: false
    }
  });
    new Chart($("#chart-pie5"), {
        type: 'pie',
        data: {
            labels: ["今日支出", "昨日支出"],
            datasets: [{
                data: [20, 40],
                backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)']
            }]
        },
        options: {
            responsive: false
        }
    });
    new Chart($dashChartBarsCnt, {
        type: 'bar',
        data: $dashChartBarsData
    });

    var myLineChart = new Chart($dashChartLinesCnt, {
        type: 'line',
        data: $dashChartLinesData,
    });
});
  // new Chart($("#chart-pie1"), {
  //   type: 'pie',
  //   data: {
  //     labels: ["红色", "蓝色", "橙色"],
  //     datasets: [{
  //       data: [100, 50, 100],
  //       backgroundColor: ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)']
  //     }]
  //   },
  //   options: {
  //     responsive: false
  //   }
  // });


});
</script>
</body>
</html>