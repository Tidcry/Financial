<%@ page import="com.jsu.bean.User" %>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <link rel="icon" href="favicon.ico" type="image/ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/materialdesignicons.min.css" rel="stylesheet">
    <link href="css/style.min.css" rel="stylesheet">
</head>
<body>
<!--左侧导航-->
<aside class="lyear-layout-sidebar">

    <!-- logo -->
    <div id="logo" class="sidebar-header">
        <a href="index.jsp"><img src="images/logo-sidebar.png" title="LightYear" alt="LightYear" /></a>
    </div>
    <div class="lyear-layout-sidebar-scroll">

        <nav class="sidebar-main">
            <ul class="nav nav-drawer">

                <!--            -------------------------------------------左侧列表添加栏目-->
                <li class="nav-item"> <a href="index.jsp"><i class="mdi mdi-home"></i> 后台首页</a> </li>
                <li class="nav-item nav-item-has-subnav active open">
                    <a href="javascript:void(0)"><i class="mdi mdi-account"></i> 个人信息管理</a>
                    <ul class="nav nav-subnav">
                        <li> <a href="personalInfo.jsp">个人信息</a></li>
                        <li class="active"> <a href="passWordInfo.jsp">修改密码</a></li>
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
                    <span class="navbar-page-title"> 个人信息管理 - 修改密码 </span>
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

                            <form method="post" action="/Financial/UserInfoServlet?method=updatePassWordInfo" class="site-form">
                                <div class="form-group">
                                    <label for="old-password">旧密码</label>
                                    <input type="password" class="form-control" name="oldpwd" id="old-password" autocomplete="off" placeholder="输入账号的原登录密码">
                                </div>
                                <div class="form-group">
                                    <label for="new-password">新密码</label>
                                    <input type="password" class="form-control" name="newpwd" id="new-password" autocomplete="off" placeholder="输入新的密码">
                                </div>
                                <div class="form-group">
                                    <label for="confirm-password">确认新密码</label>
                                    <input type="password" class="form-control" name="confirmpwd" id="confirm-password" autocomplete="off" placeholder="再次输入新的密码">
                                </div>
                                <button type="submit" class="btn btn-primary">修改密码</button>
                            </form>

                        </div>
                    </div>
                </div>

            </div>

        </div>

    </main>
    <!--End 页面主要内容-->

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="js/main.min.js"></script>
</body>
</html>