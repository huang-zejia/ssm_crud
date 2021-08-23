<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 大神皇
  Date: 2021/8/17
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setAttribute("ContextPath", request.getContextPath());%>
<html>
<head>
    <title>员工列表页面</title>
    <%--引入juqery--%>
    <script type="text/javascript" src="${ContextPath}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入样式--%>
    <link rel="stylesheet"  href="${ContextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${ContextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <!--搭建显示页面
        https://v3.bootcss.com/css/
    -->
    <div class="container">
        <!--标题-->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!--按钮-->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <!--表格数据-->
        <div class="row">
            <div class="col-md-12">
                <%--https://v3.bootcss.com/css/#tables--%>
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>depetName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                    <%--https://v3.bootcss.com/css/#buttons-sizes--%>
                                <button class="btn btn-primary btn-sm">
                                        <%--https://v3.bootcss.com/components/#glyphicons-examples--%>
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    新增</button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除</button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <!--分页信息-->
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前第${pageInfo.pageNum}页,共${pageInfo.total}条记录
            </div>
            <%--分页条https://v3.bootcss.com/components/#pagination--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li><a href="${ContextPath}/emps?pn=1">首页</a></li>
                            <li>
                                <a href="${ContextPath}/emps?pn=${pageInfo.prePage}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page">
                            <c:if test="${page==pageInfo.pageNum}">
                                <li class="active"><a>${page}</a></li>
                            </c:if>
                            <c:if test="${page!=pageInfo.pageNum}">
                                <li ><a href="${ContextPath}/emps?pn=${page}">${page}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${ContextPath}/emps?pn=${pageInfo.nextPage}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li><a href="${ContextPath}/emps?pn=${pageInfo.pages}">末页</a></li>
                        </c:if>

                    </ul>
                </nav>
            </div>
        </div>
    </div>

</body>
</html>
