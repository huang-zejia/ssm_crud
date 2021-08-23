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
<%--添加员工的模态框https://v3.bootcss.com/javascript/#modals-examples--%>
<!-- Modal 员工添加的模态框-->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%--表单https://v3.bootcss.com/css/#forms--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                            <span id="helpBlock1" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@hzj.com">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <%--单选按钮https://v3.bootcss.com/css/#forms-controls--%>

                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                                <%--单选按钮https://v3.bootcss.com/css/#forms-controls--%>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label" >deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门直接提交id就好--%>
                            <select  class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
                    <%--https://v3.bootcss.com/css/#forms--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal 员工修改的模态框-->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <%--表单https://v3.bootcss.com/css/#forms--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>

                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@hzj.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <%--单选按钮https://v3.bootcss.com/css/#forms-controls--%>

                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                            <%--单选按钮https://v3.bootcss.com/css/#forms-controls--%>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label" >deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门直接提交id就好--%>
                            <select  class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
                <%--https://v3.bootcss.com/css/#forms--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>


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
            <button class="btn btn-primary" id="emp_add">新增</button>
            <button class="btn btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <!--表格数据-->
    <div class="row">
        <div class="col-md-12">
            <%--https://v3.bootcss.com/css/#tables--%>
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>depetName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>


                </tbody>

            </table>
        </div>
    </div>
    <!--分页信息-->
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info">

        </div>
        <%--分页条https://v3.bootcss.com/components/#pagination--%>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>
<script type="text/javascript">

    var pageNums;//最后一页
    var currentNum;//当前页

    //页面加载完成后，组件发送ajax请求，得到分页数据
    $(function (){
      to_page(1)
    });
        function to_page(pn){
            $.ajax({
                url:"${ContextPath}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result){
                    //console.log(result)
                    //解析并显示员工数据
                    build_emps_table(result);
                    //解析并显示分页信息
                    buile_page_info(result);
                    //解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }


    function build_emps_table(result){

        //清空表格数据
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item' /></td>")
           var empIdTd= $("<td></td>").append(item.empId);
           var empNameTd= $("<td></td>").append(item.empName);
           var genderTd =$("<td></td>").append(item.gender=='M'?'男':'女');
           var emailTd =$("<td></td>").append(item.email);
           var deptNameTd =$("<td></td>").append(item.department.deptName);
           /* <button class="btn btn-primary btn-sm">
                  <%--https://v3.bootcss.com/components/#glyphicons-examples--%>
                  <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                  新增</button>
               <button class="btn btn-danger btn-sm">
                  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                  删除</button>*/
           var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
           //为编辑按钮添加一个自定义属性，用于保存员工id
            editBtn.attr("edit_Id",item.empId);

           var deleteBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

           deleteBtn.attr("del_Id",item.empId)

            var btn=$("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>")
            .append(checkBoxTd)
            .append(empIdTd)
            .append(empNameTd)
            .append(genderTd)
            .append(emailTd)
            .append(deptNameTd)
            .append(btn)
            .appendTo("#emps_table tbody");
        });
    }
    function buile_page_info(result){
            $("#page_info").empty();
        $("#page_info").append("当前第"+result.extend.pageInfo.pageNum+" 页,总共"+result.extend.pageInfo.pages+"页,共"+result.extend.pageInfo.total+"条记录");

            //保存当前页码信息
            currentNum=result.extend.pageInfo.pageNum;
            //保证回到的是最后一页
            pageNums=result.extend.pageInfo.pages+1;
        }

    function build_page_nav(result){
            $("#page_nav").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            firstPageLi.click(function (){
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            })
        }

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }

        //添加首页和末页
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);

        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav")
    }

    //清空表单样式和内容
    function reset_all_form(ele){
        //清除表单数据
        $(ele)[0].reset();
        //清除表单下所有关于校验的样式
        $(ele).find("*").removeClass("has-success has-error");
        //清空文本提示
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮，弹出模态框
    $("#emp_add").click(function () {
        //表单完整重置，数据和样式都要重置
        reset_all_form("#empAddModel form");
        //发送Ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        $("#empAddModel").modal({
            backdrop:"static"
        });

    });
    //查出所有部门信息
    function getDepts (ele){
        //清空下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${ContextPath}/depts",
            type: "GET",
            success:function (result){
                //console.log(result)
                //显示部门信息在下拉列表中
                // $("#dept_add_select").append("")
                $.each(result.extend.depts,function (){
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId)
                    optionEle.appendTo(ele);
                });
            }
        });
    }


    //抽取校验后改变的步骤
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if ("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验数据库中是否有该用户名
    $("#empName_add_input").change(function (){
        //发送Ajax请求校验用户名是否可用
        var empName= this.value;
        $.ajax({
            url:"${ContextPath}/checkUser",
            data:"empName="+empName,
            type:"GET",
            success:function (result) {
                if (result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("status","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.validator_msg);
                    $("#emp_save_btn").attr("status","error");
                }
            }
        });
    });

    //校验表单数据
    function validate_add_form(){
        //拿到要校验的数据
        var empName =$("#empName_add_input").val();
        //使用正则表达式验证用户名
        var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if( !regName.test(empName)){
            // alert("用户名为3-16字母或2-8位汉字");
            /*表单验证https://v3.bootcss.com/css/#forms-control-validation*/
            /*
             $("#empName_add_input").parent().addClass("has-error");
             $("#empName_add_input").next("span").text("用户名为3-16字母或2-8位汉字");*/
            show_validate_msg("#empName_add_input","error","用户名为3-16字母或2-8位汉字")
            return false;
        }else {
            /*            $("#empName_add_input").parent().addClass("has-success");
                        $("#empName_add_input").next("span").text("");*/
            show_validate_msg("#empName_add_input","success","")
        }
        //验证邮箱信息
        var email=$("#email_add_input").val();
        var regEmail= /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if (!regEmail.test(email)){
            // alert("邮箱格式不正确")
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            return false
        }else {
            show_validate_msg("#email_add_input","success","");
            /*$("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");*/
        }

        return true;

    }
    //保存新增员工
    $("#emp_save_btn").click(function (){
        //数据校验
        if (!validate_add_form()){
            return false;
        }
        //保证用户名不重复
        if ($(this).attr("status")=="error"){
            return false;
        }
        $.ajax({
            url: "${ContextPath}/emp",
            type: "POST",
            //将表单数据通过jquery序列化
            data: $("#empAddModel form").serialize(),
            success:function (result){
                if (result.code==100){
                    //保存成功
                    //1关闭模态框
                    $("#empAddModel").modal('hide');
                    //2跳到最后一页
                    to_page(pageNums);
                }else {
                    //判断哪个字段存在错误信息
                    if (result.extend.errorFields.email!=undefined){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if (result.extend.errorFields.empName!=undefined){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        });

    });

//-------------------员工更新-----------------------
    /*不能直接在按钮上绑定单击事件，因为按钮是后期页面发送Ajax请求后才创建的
    * 1、可以在Ajax请求创建按钮的时候绑定
    * 2、使用on对事件进行绑定*/
    $(document).on("click",".edit_btn",function () {
        //alert("Edit");
        //查出部门信息
        getDepts("#dept_update_select");
        //查询员工信息
        getEmp($(this).attr("edit_Id"));

        //将员工id传递给模态框的更新按钮中
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_Id"));
        //弹出模态框
        $("#empUpdateModel").modal({
            backdrop: "static"
        })
    });
    //查出部门信息
    function getEmp(id){
        $.ajax({
            url:"${ContextPath}/emp/"+id,
            type:"GET",
            success:function (result){
                //显示员工数据
                var empDate=result.extend.emp;
                $("#empName_update_static").text(empDate.empName);
                $("#email_update_input").val(empDate.email);
                $("#empUpdateModel radio[name=gender]").val([empDate.gender]);
                $("#empUpdateModel select").val([empDate.dId]);

            }
        });
    }

    //修改员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱信息
        var email=$("#email_update_input").val();
        var regEmail= /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if (!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false
        }else {
            show_validate_msg("#email_update_input","success","");
        }

        /*如果使用Ajax直接发送PUT请求，后端想拿到数据的话，
        要在web.xml中配置HttpPutFormContentFilter过滤器*/
        //发送Ajax请求保存员工
        $.ajax({
            url:"${ContextPath}/emp/"+$(this).attr("edit_id"),
            type:"PUT",
            //data:$("#empUpdateModel form").serialize()+"&_method=PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
                //关闭模态框
                $("#empUpdateModel").modal('hide');
                //回到原页面
                to_page(currentNum);
            }
        });
    });

    //-----------------------员工删除------------------------
    $(document).on("click",".delete_btn",function (){
        //获取数据
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId=$(this).attr("del_Id");
        //弹出确认删除对话框
        if (confirm("你确认要删除【"+empName+"】吗")){
            $.ajax({
                url:"${ContextPath}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentNum);
                }
            })
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function () {
        /*attr用于获取自定义属性
        * prop用于dom原生的属性
        * prop修改和读取dom原生属性的值*/
        //同步全选
        $(".check_item").prop("checked",$(this).prop("checked"));
    })

    //根据选中个数，确定是否全选
    $(document).on("click",".check_item",function () {
        //判断是否全部选中了
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    //批量删除
    $("#emp_delete_all").click(function () {
        var empNames=""
        var del_idstr=""
        //遍历被选中的员工
        $.each($(".check_item:checked"),function () {
            //合并被选中的员工的姓名
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            //合并被选中的员工id
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的后缀
        empNames=empNames.substring(0,empNames.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
        if (confirm("确认删除【"+empNames+"】吗")){

            //发送Ajax请求批量删除
            $.ajax( {
                url:"${ContextPath}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //删除完成将全选按钮的勾去掉
                    $("#check_all").prop("checked",false);
                    to_page(currentNum);
                }
            });
        }

    });

</script>
</body>
</html>
