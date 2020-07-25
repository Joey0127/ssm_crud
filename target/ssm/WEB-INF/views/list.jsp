<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        //获取项目路径,以/开始，不以/结束
        String path = request.getContextPath();
    %>
    <!--Web路径:
    不以/开始的相对路径找资源，以当前资源的路径为基准，经常容易出现问题
    以/开始的相对路径占资源，以服务器的路径为基准(http://localhost:8080):需要加上项目名
        http://localhost:8080/ssm
    -->
    <script src="<%=path%>/include/scripts/jquery-3.2.1.min.js"></script>
    <!-- 引入bootStrap样式-->
    <link rel="stylesheet" href="<%=path%>/include/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="<%=path%>/include/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h2>SSM项目高级整合案例</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-12 col-md-offset-10">
            <button type="button" class="btn btn-primary">修改</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender}</th>
                        <th>${emp.email}</th>
                        <th>${emp.dept.deptName}</th>
                        <th>
                            <button type="button" class="btn btn-info btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                            </button>
                            <button type="button" class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6">
            当前${pageInfo.pageNum}页,共${pageInfo.pages}页,共${pageInfo.total}条记录.
        </div>
        <!--分页条信息-->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="<%=path%>/emps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="<%=path%>/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <!--遍历的页码是否等于当前页码-->
                        <c:if test="${page_Num == pageInfo.pageNum  }">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}">
                            <li><a href="<%=path%>/emps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="<%=path%>/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <!--末页就是获取总页数-->
                    <li><a href="<%=path%>/emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>

</div>
</body>
</html>
