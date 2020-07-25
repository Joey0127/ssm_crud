<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<!-- empAddModal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_add_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add_input" name="empName"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email_add_input" name="email"
                                   placeholder="jiangbin@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderM_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderF_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deteName</label>
                        <div class="col-sm-4">
                            <!--部门 提交部门id即可-->
                            <select class="form-control" id="emp_add_select" name="dId">
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- empUpdateModal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_update_form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email_update_input" name="email"
                                   placeholder="jiangbin@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderM_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="genderF_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deteName</label>
                        <div class="col-sm-4">
                            <!--部门 提交部门id即可-->
                            <select class="form-control" id="emp_update_select" name="dId">
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    var totalRecord; //总记录数
    var currentPage;
    //页面加载完成以后，直接发送ajax请求获得分页数据
    $(function () {
        to_page(1); //首页
    });

    function to_page(pn) {
        $.ajax({
            url: "<%=path%>/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                console.log(result);
                //1.利用js解析json 显示员工数据
                build_emps_table(result);
                //2.利用js解析json 显示分页信息
                build_page_info(result)
                //3.利用js解析json 显示分页条
                build_page_nav(result)
            }
        });
    }

    //1.利用js解析json 显示员工数据
    function build_emps_table(result) {
        //每发送一次ajax请求，要先清除之前的数据
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {  //item表示一条员工信息，index表示一条员工索引
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? 'M' : 'F');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.dept.deptName);
            // <button type="button" class="btn btn-info btn-sm">
            //         <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
            //         </button>
            //         <button type="button" class="btn btn-danger btn-sm">
            //         <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
            //         </button>
            var updateBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            // $(".edit_btn").attr("edit_id",item.empId);
            updateBtn.attr("edit_id", item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            deleteBtn.attr("delete_id", item.empId);
            var btnTd = $("<td></td>")
                .append(updateBtn)
                .append(" ")
                .append(deleteBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //2.利用js解析json 显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页," +
            "共" + result.extend.pageInfo.pages + "页,"
            + "共" + result.extend.pageInfo.total + "条记录.")
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //3.利用js解析json 显示分页条
    function build_page_nav(result) {
        //page_nav_area
        // <nav aria-label="Page navigation">
        //         <ul class="pagination">
        //         <li>
        //         <a href="#" aria-label="Previous">
        //         <span aria-hidden="true">&laquo;</span>
        //     </a>
        //     </li>
        //     <li><a href="#">1</a></li>
        //     <li><a href="#">2</a></li>
        //     <li><a href="#">3</a></li>
        //     <li><a href="#">4</a></li>
        //     <li><a href="#">5</a></li>
        //     <li>
        //     <a href="#" aria-label="Next">
        //         <span aria-hidden="true">&raquo;</span>
        //     </a>
        //     </li>
        //     </ul>
        //     </nav>
        $("#page_nav_area").empty();
        var nav = $("<nav></nav>");
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {   //禁用
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {  //禁用
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        //将首页和前一页添加到ul中
        ul.append(firstPageLi).append(prePageLi);
        //遍历连续显示的页码
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {  //高亮
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            //将连续显示的页码添加到ul中
            ul.append(numLi);
        });
        //将末页和下一页添加到ul中
        ul.append(nextPageLi).append(lastPageLi);
        nav.append(ul)
            .appendTo("#page_nav_area");
    }

    //清除表单样式及内容
    function reset_form(ele) {
        //清空表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //查出所有的部门信息，并显示在下拉列表中
    function getDepts(ele) {
        //在每次获取下拉列表之前 清空之前的数据
        $(ele).empty();
        $.ajax({
            url: "<%=path%>/depts",
            type: "GET",
            success: function (result) {
                console.log(result);
                // {"code":100,"msg":"请求成功","
                // extend":{"deptList":[{"id":1,"deptName":"开发部"},{"id":2,"deptName":"运维部"},
                // {"id":3,"deptName":"测试部"},{"id":4,"deptName":"营销部"},{"id":5,"deptName":"产品部"},
                // {"id":6,"deptName":"事业部"}]}}

                //将部门数据放到下拉框中
                var depts = result.extend.deptList;
                $.each(depts, function (index, item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value", item.id);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        reset_form("#emp_add_form");
        getDepts("#emp_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //显示校验信息
    function show_validate_msg(ele, status, msg) {
        //每次校验之前 要清除之前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text();
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }

    }

    //校验表单数据
    function validate_add_form() {
        //1.拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        // alert(regName.test(empName));
        if (!regName.test(empName)) {
            // alert("用户名可以事2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合")
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        //2.校验邮箱
        var empEmail = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        // alert(regEmail.test(empEmail));
        if (!regEmail.test(empEmail)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "")
        }
        return true;
    }

    //检验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url: "<%=path%>/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax_val", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax_val", "error");
                }
            }
        });
    });

    //发送ajax请求保存员工
    $("#emp_save_btn").click(function () {
        //.保存员工数据之前先进行前端校验
        if (!validate_add_form()) {
            return false;
        }

        //2.判断之前的ajax用户名校验是否成功
        if ($(this).attr("ajax_val") == "error") {
            return false;
        }

        //3.
        $.ajax({
            url: "<%=path%>/emp",
            type: "POST",
            data: $("#emp_add_form").serialize(), //表单序列化数据 key=value&key:value&....
            success: function (result) {
                console.log(result);
                if (result.code == 100) {
                    //1.关闭模块框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页显示刚刚插入的数据,发送ajax请求显示总记录数即可
                    to_page(totalRecord);
                } else {
                    //显示失败的信息
                    // console.log(result);
                    //有哪个字段错误信息就显示哪个字段的...
                    // alert(result.extend.errorFields.email);
                    // alert(result.extend.errorFields.empName);
                    if (undefined != result.extend.errorFields.email) {
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //查出员工信息并显示
    function getEmp(id) {
        $.ajax({
            url: "<%=path%>/emp/" + id,
            type: "GET",
            success: function (result) {
                console.log(result);
                // {code: 100, msg: "请求成功",…}
                // code: 100
                // extend: {emp: {empId: 2, empName: "huzhong", gender: "F", email: "huzhong@163.com", dId: 6, dept: null}}
                // emp: {empId: 2, empName: "huzhong", gender: "F", email: "huzhong@163.com", dId: 6, dept: null}
                // msg: "请求成功"

                var empDate = result.extend.emp;
                // alert(empDate.dId)
                $("#empName_update_static").text(empDate.empName);
                $("#email_update_input").val(empDate.email);
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
                // $("#emp_update_select").val([empDate.dId]);
            }
        });

    }

    //因为按钮 编辑和删除 是之后通过js创建的，所以不能使用click()属性进行绑定 eg.$(".edit_btn").click()...
    //可以使用.live进行控件绑定，新版jquery使用.on进行控件绑定
    $(document).on("click", ".edit_btn", function () {
        //1.查出部门信息并显示
        getDepts("#emp_update_select");
        //2.查出员工信息并显示
        getEmp($(this).attr("edit_id"));
        //将员工id给模态框更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit_id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //2.员工更新，更新哪里 后端就更新哪里
        $.ajax({
            url: "<%=path%>/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#emp_update_form").serialize(),
            success: function (result) {
                console.log(result);
                //关闭模态框
                $("#empUpdateModal").modal('hide');
                //回到本页面
                to_page(currentPage);
            }
        });
    });

    //删除员工
    $(document).on("click", ".delete_btn", function () {
        var empName = $(this).parents("tr").find("td:eq(1)").text();
        var empId = $(this).attr("delete_id");
        if (confirm("确认删除" + empName + "嘛?")) {
            $.ajax({
                url: "<%=path%>/emp/"+empId,
                type: "DELETE",
                success: function (result) {
                    console.log(result);
                    //回到当前页
                    to_page(currentPage);
                }
            });
        }
    });


</script>

</body>
</html>
