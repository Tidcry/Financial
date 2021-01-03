<%@ page import="com.jsu.bean.User" %>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="app.jsp"%>
<%@page isELIgnored="false" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<head>
    <meta charset="utf-8">
<!--    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />-->
    <title>支出账单</title>
    <link rel="icon" href="images/favicon.ico" type="image/ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/materialdesignicons.min.css" rel="stylesheet">
    <link href="css/style.min.css" rel="stylesheet">
    <link href="css/new.css" rel="stylesheet">
    <!--日期选择插件-->
    <link rel="stylesheet" href="js/bootstrap-datepicker/bootstrap-datepicker3.min.css">
    <script type="text/javascript">

    </script>



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
                                <li class="active"><a href="/Financial/PayInfoServlet?method=searchInfoByUserId">支出账单</a> </li>
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
                        <span class="navbar-page-title"> 账单管理 - 支出账单 </span>
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
                            <div class="card-toolbar clearfix">
<%--                                提交表单--%>
                                <form action="/Financial/PayInfoServlet?method=searchByInfo" method="post" class="">
                                <div class="search-bar-new">
                                    <div class="search-label">
                                        <label class="label-select" for="example-select">支出事由</label>
                                        <label class="label-price" for="example-select">金额</label>
                                        <label class="label-date" for="example-select">日期</label>
                                    </div>
                                    <div class="search-text">
                                            <select class="form-control text select-text" id="example-select" name="type" size="1">
                                                <option value="0">请选择</option>
                                                <option value="1">餐饮</option>
                                                <option value="2">服饰</option>
                                                <option value="3">家居</option>
                                                <option value="4">交通</option>
                                                <option value="5">医疗</option>
                                                <option value="6">娱乐</option>
                                                <option value="7">其他</option>
                                            </select>
                                            <input class="form-control text input-text-price1" type="text" id="example1-text-input" name="lowPrice" value="" autocomplete="off" placeholder="最低金额：">
                                            <label class="label-input-price" for="example-select">~</label>
                                            <input class="form-control text input-text-price2" type="text" id="example2-text-input" name="highPrice" value="" autocomplete="off" placeholder="最高金额：">
                                            <input class="form-control js-datepicker text input-text-date1" type="text" id="example3-text-input" name="startDate" value="" autocomplete="off" placeholder="开始日期：" data-date-format="yyyy-mm-dd">
                                            <label class="label-input-date" for="example-select">~</label>
                                            <input class="form-control js-datepicker text input-text-date2" type="text" id="example4-text-input" name="endDate" value="" autocomplete="off" placeholder="结束日期：" data-date-format="yyyy-mm-dd">

                                    </div>
                                </div>
                                <div class="toolbar-btn-action">
                                    <a class="btn btn-primary m-r-5" href="addPay.jsp"><i class="mdi mdi-plus"></i> 新增</a>
                                    <button type="submit" class="btn btn-search m-r-5" ><i class="mdi mdi-account-search"></i> 查询</button>
                                </div>
                                </form>
                            </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="tab">
                                            <thead>
                                            <tr>
                                                <th>编号</th>
                                                <th>支出事由</th>
                                                <th>金额</th>
                                                <th>日期</th>
                                                <th>备注</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <c:if test="${not empty requestScope.pageBean.list}">
                                                <c:forEach items="${requestScope.pageBean.list}" var="pay">
                                                <tbody>
                                                <tr>
                                                    <td>${pay.payId}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${pay.type == 1}">餐饮</c:when>
                                                            <c:when test="${pay.type == 2}">服饰</c:when>
                                                            <c:when test="${pay.type == 3}">家居</c:when>
                                                            <c:when test="${pay.type == 4}">交通</c:when>
                                                            <c:when test="${pay.type == 5}">医疗</c:when>
                                                            <c:when test="${pay.type == 6}">娱乐</c:when>
                                                            <c:when test="${pay.type == 7}">其他</c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>${pay.price}</td>
                                                    <td><fmt:formatDate value="${pay.date}" pattern="yyyy-MM-dd"/></td>
                                                    <td>${pay.remarks}</td>
                                                    <td>
                                                        <div class="btn-group">
                                                            <a class="btn btn-xs btn-default" href="updatePay.jsp?payId=${pay.payId}" title="编辑" data-toggle="tooltip"><i class="mdi mdi-pencil"></i></a>
                                                            <a class="btn btn-xs btn-default" href="/Financial/PayInfoServlet?method=delete&payId=${pay.payId}" title="删除" data-toggle="tooltip"><i class="mdi mdi-window-close"></i></a>
                                                        </div>
                                                    </td>
                                                </tr>
<%--                                            <%--%>
<%--                                                //从session中取出登录用户的id--%>
<%--                                                int userId = ((User) request.getSession().getAttribute("SESSION_USER")).getUserId();--%>
<%--                                                String sql = "select * from pay where userId="+userId;--%>

<%--                                                //把当前用户所有收入账单查询出来--%>
<%--                                                payDao payDao=new payDao();--%>
<%--                                                List<pay> payList=payDao.getPayListByUserId(sql);--%>
<%--                                                for(pay pay:payList)--%>
<%--                                                {%>PageBean--%>
<%--                                            <tr>--%>
<%--                                                <td><%=pay.getpayId()%></td>--%>
<%--                                                <td><%=pay.getType()%></td>--%>
<%--                                                <td><%=pay.getPrice()%></td>--%>
<%--                                                <td><%=pay.getDate()%></td>--%>
<%--                                                <td><%=pay.getRemarks()%></td>--%>
<%--                                                <td>--%>
<%--                                                    <div class="btn-group">--%>
<%--                                                        <a class="btn btn-xs btn-default" href="updatePay.jsp?payId=<%=pay.getpayId()%>" title="编辑" data-toggle="tooltip"><i class="mdi mdi-pencil"></i></a>--%>
<%--                                                        <a class="btn btn-xs btn-default" href="/Financial/payInfoServlet?method=delete&payId=<%=pay.getpayId()%>" title="删除" data-toggle="tooltip"><i class="mdi mdi-window-close"></i></a>--%>
<%--                                                    </div>--%>
<%--                                                </td>--%>
<%--                                            </tr>--%>
<%--                                            <%}--%>
<%--                                            %>--%>

                                            </tbody>
                                            </c:forEach>
                                            </c:if>
                                        </table>

                                    </div>

                                </div>
                            <div class="card-body" align="center">

                                <nav>
                                    <ul class="pager">
                                        <li><a href="/Financial/PayInfoServlet?method=pageSwitch&currentPage=${pageBean.beforePage}&pageSize=${pageBean.pageSize}">上一页</a></li>
                                        共${pageBean.totalPages}页 共${pageBean.totalRows}行
                                        第${pageBean.currentPage}页
                                        每页${pageBean.pageSize}行
                                        <li><a href="/Financial/PayInfoServlet?method=pageSwitch&currentPage=${pageBean.afterPage}&pageSize=${pageBean.pageSize}">下一页</a></li>
                                    </ul>
                                </nav>

                            </div>
<%--                            <div align="center">--%>
<%--                                <a href="/Financial/payInfoServlet?method=pageSwitch&currentPage=${pageBean.beforePage}&pageSize=${pageBean.pageSize}">上一页</a>--%>
<%--                                共${pageBean.totalPages}页 共${pageBean.totalRows}行--%>
<%--                                第${pageBean.currentPage}页--%>
<%--                                每页${pageBean.pageSize}行--%>
<%--                                <a href="/Financial/payInfoServlet?method=pageSwitch&currentPage=${pageBean.afterPage}&pageSize=${pageBean.pageSize}">下一页</a>--%>
<%--                            </div>--%>
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
<%--<script>--%>
<%--    function beforePage(page) {--%>
<%--        window.location = "/payInfoServlet?method=pageSwitch&currentPage="+page+"&pageSize=${pageSize}";--%>

<%--    }--%>
<%--    function afterPage(page) {--%>
<%--        window.location = "/payInfoServlet?currentPage="+page+"&pageSize=${pageSize}";--%>

<%--    }--%>
<%--</script>--%>

</body>
</html>