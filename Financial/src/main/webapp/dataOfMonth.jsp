<%@ page import="com.jsu.bean.User" %>
<%@ page import="com.jsu.dao.IncomeDao" %>
<%@ page import="com.jsu.dao.PayDao" %>
<%@ page import="com.jsu.bean.Income" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jsu.bean.Pay" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="zh">
<head>
    <title>按月统计</title>
    <link rel="icon" href="images/favicon.ico" type="image/ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/materialdesignicons.min.css" rel="stylesheet">
    <link href="css/style.min.css" rel="stylesheet">
    <!--日期选择插件-->
    <link rel="stylesheet" href="js/bootstrap-datepicker/bootstrap-datepicker3.min.css">
<%
    IncomeDao incomeDao=new IncomeDao();
    PayDao payDao=new PayDao();

    String sql="select * FROM income where date_format(date,'%Y-%m')='"+request.getSession().getAttribute("SESSION_Month")+"'";
    String sql_pay="select * FROM pay where date_format(date,'%Y-%m')='"+request.getSession().getAttribute("SESSION_Month")+"'";
    System.out.println(request.getSession().getAttribute("SESSION_Month"));
    List<Income> incomeList=incomeDao.getIncomeListByPage(sql);
    List<Pay> payList=payDao.getPayListByPage(sql_pay);

    System.out.println("------------"+incomeList.size());
    System.out.println("------------"+payList.size());

    Double[] incomeData=new Double[]{0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    for(Income i:incomeList){
        int type=Integer.parseInt(i.getType());
        incomeData[type]=incomeData[type]+i.getPrice();
        incomeData[0]=incomeData[0]+i.getPrice();
    }

    Double[] payData=new Double[]{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
    for(Pay p:payList){
        int type=Integer.parseInt(p.getType());
        payData[type]=payData[type]+p.getPrice();
        payData[0]=payData[0]+p.getPrice();
    }
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
                <!--左侧列表添加栏目-->
                <nav class="sidebar-main">
                    <ul class="nav nav-drawer">
                        <li class="nav-item"> <a href="index.jsp"><i class="mdi mdi-home"></i> 后台首页</a> </li>
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
                        <li class="nav-item nav-item-has-subnav active open">
                            <a href="javascript:void(0)"><i class="mdi mdi-chart-bar"></i> 报表统计</a>
                            <ul class="nav nav-subnav">
                                <li class="active"> <a href="dataOfMonth.jsp">按月统计</a></li>
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
                    <form action="/Financial/DataTotalServlet?method=month" method="post" class="">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header"><h4>月份选择</h4></div>
                            <div class="card-body">

                                <input type="text" class="form-control js-datepicker" id="seo_keywords" name="date" value="" autocomplete="off" placeholder="请选择月份" data-date-format="yyyy-mm"/>

                            </div>
                            <button type="submit" class="btn btn-search m-r-5" style="margin-left: 25px;margin-bottom: 15px"><i class="mdi mdi-account-search"></i> 查询</button>
                        </div>
                    </div>
                    </form>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header"><h4><%=request.getSession().getAttribute("SESSION_Month")%>>收入来源</h4></div>
                            <div class="card-body"><div class="chartjs-size-monitor" style="position: absolute; inset: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
                                <canvas id="chart-vbar-1" width="754" height="471" class="chartjs-render-monitor" style="display: block; width: 754px; height: 471px;"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header"><h4><%=request.getSession().getAttribute("SESSION_Month")%>>支出事由</h4></div>
                            <div class="card-body"><div class="chartjs-size-monitor" style="position: absolute; inset: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
                                <canvas id="chart-vbar-2" width="754" height="471" class="chartjs-render-monitor" style="display: block; width: 754px; height: 471px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!--End 页面主要内容-->

    </div>
</div>

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="js/main.min.js"></script>
<!--日期选择插件-->
<script src="js/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="js/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
<script type="text/javascript" src="js/main.min.js"></script>

<!--图表插件-->
<script type="text/javascript" src="js/Chart.js"></script>
<script type="text/javascript">
    new Chart($("#chart-vbar-1"), {
        type: 'bar',
        data: {
            labels: ["工资", "兼职", "奖金", "补贴", "理财", "其他","共计"],
            datasets: [{
                label: "收入",
                backgroundColor: "rgba(51,202,185,0.5)",
                borderColor: "rgba(0,0,0,0)",
                hoverBackgroundColor: "rgba(51,202,185,0.7)",
                hoverBorderColor: "rgba(0,0,0,0)",
                data: [<%=incomeData[1]%>, <%=incomeData[2]%>, <%=incomeData[3]%>, <%=incomeData[4]%>, <%=incomeData[5]%>, <%=incomeData[6]%>,<%=incomeData[0]%>]
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
    new Chart($("#chart-vbar-2"), {
        type: 'bar',
        data: {
            labels: ["餐饮", "服饰", "家居", "交通", "医疗", "娱乐","其他","共计"],
            datasets: [{
                label: "支出",
                backgroundColor: "rgba(51,202,185,0.5)",
                borderColor: "rgba(0,0,0,0)",
                hoverBackgroundColor: "rgba(51,202,185,0.7)",
                hoverBorderColor: "rgba(0,0,0,0)",
                data: [<%=payData[1]%>, <%=payData[2]%>, <%=payData[3]%>, <%=payData[4]%>, <%=payData[5]%>, <%=payData[6]%>,<%=payData[7]%>,<%=payData[0]%>]
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });


    // new Chart($("#chart-line-4"), {
    //     type: 'line',
    //     data: {
    //         labels: ["一月", "二月", "三月", "四月"],
    //         datasets: [{
    //             label: "收入",
    //             fill: false,
    //             borderWidth: 3,
    //             pointRadius: 4,
    //             borderColor: "#36a2eb",
    //             backgroundColor: "#36a2eb",
    //             pointBackgroundColor: "#36a2eb",
    //             pointBorderColor: "#36a2eb",
    //             pointHoverBackgroundColor: "#fff",
    //             pointHoverBorderColor: "#36a2eb",
    //             data: [30, 25, 35, 23]
    //         },
    //             {
    //                 label: "支出",
    //                 fill: false,
    //                 borderWidth: 3,
    //                 pointRadius: 4,
    //                 borderColor: "#ff6384",
    //                 backgroundColor: "#ff6384",
    //                 pointBackgroundColor: "#ff6384",
    //                 pointBorderColor: "#ff6384",
    //                 pointHoverBackgroundColor: "#fff",
    //                 pointHoverBorderColor: "#ff6384",
    //                 data: [23, 29, 30, 33]
    //             }]
    //     },
    //     options: {}
    // });
function search() {

}
</script>
</body>
</html>
