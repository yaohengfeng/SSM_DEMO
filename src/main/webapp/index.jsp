<%--
  Created by IntelliJ IDEA.
  User: Mr.Yao
  Date: 2019/9/27
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <%--引入样式--%>
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/js/bootstrap.min.js"></script>

</head>
<body>
<%--修改员工--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="empUpdateForm">
                    <div class="form-group">
                        <label for="update_empName" class="col-sm-2 control-label">empNme</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="update_empName"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="update_email" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="gender_Update_input" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender_Update_input" value="男" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender2_Update_input" value="女">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_email" class="col-sm-2 control-label" >部门名</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateEmp">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 新增员工-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="empForm">
                    <div class="form-group">
                        <label for="add_empName" class="col-sm-2 control-label">empNme</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="add_empName" placeholder="员工姓民">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="input_email" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_email" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender_add_input" value="男" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender2_add_input" value="女">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_email" class="col-sm-2 control-label" >部门名</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveEmp">保存</button>
            </div>
        </div>
    </div>
</div>

<%--搭建页面--%>
<div class="container">
    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_mode_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <%-- <tr>
                     <th>1</th>
                     <th>张三</th>
                     <th>男</th>
                     <th>aaa@qq.com</th>
                     <th>开发部</th>
                     <th>
                         <button class="btn btn-primary btn btn-default btn-sm">
                             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                         </button>
                         <button class="btn btn-danger btn btn-default btn-sm">
                             <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                         </button>
                     </th>
                 </tr>--%>
                </tbody>



            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
            当前页,总页,总条记录
        </div>
        <%--分页条--%>
        <div class="col-md-6" id="page_info_nav">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord ,courtPage
    //首次调用页码跳转到首页
    $(function () {
        to_page(1);
    })
    //页码跳转
    function to_page(pn) {
        $.ajax({
            url:"/emps",
            data:"pn="+pn,
            type:"get",
            success:function (result) {
                //解析并显示信息数据
                build_emps_table(result);
                //解析并显示分页信息
                build_pageInfo(result);
                //解析并显示分页条信息
                build_page_nav(result);
            }
        }) ;
    }

    //接收并解析员工信息表
    function build_emps_table(result) {
        $("#emps_tables tbody").empty();//清空表中信息
        var emps=result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var empGenderTd=$("<td></td>").append(item.empGender);
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);

            var editBtn=$("<button></button>").addClass("btn btn-primary btn btn-default btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil").append("编辑");
            //为编辑按钮加上自定义属性,表示当前id
            editBtn.attr("edit_id",item.empId);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn btn-default btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
            //为删除按钮加上自定义属性,表示当前id
            delBtn.attr("del_id",item.empId);
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd).append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_tables tbody");
        });
    }
    //解析并显示分页信息
    function build_pageInfo(result) {
            $("#page_info_area").empty();

            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"
                +result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录");
            totalRecord=result.extend.pageInfo.total;
            courtPage=result.extend.pageInfo.pageNum;
    }
    //解析并显示分页条数据
    function build_page_nav(result) {
            $("#page_info_nav").empty();
            var ul=$("<ul></ul>").addClass("pagination");
            //首页
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            //上一页
            var proPageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
            //判断是否有上一页
            if (result.extend.pageInfo.hasPreviousPage==false){
                firstPageLi.addClass("disabled");
                proPageLi.addClass("disabled");
            }else {
                //首页的点击事件，调用to_page方法跳转到第一页
                firstPageLi.click(function () {
                    to_page(1);
                });
                //上一页的点击事件，调用to_page方法跳转到上一页
                proPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1);
                });
            }
            //下一页
            var nestPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            //末页
            var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            //判断是否有下一页
            if (result.extend.pageInfo.hasNextPage==false){
                nestPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                //下一页的点击事件，调用to_page方法跳转到下一页
                nestPageLi.click(function () {
                    to_page(result.extend.pageInfo.pageNum+1);
                });
                ////末页页的点击事件，调用to_page方法跳转到最后一页
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }

            ul.append(firstPageLi).append(proPageLi);

            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                var numLi=$("<li></li>").append($("<a></a>").append(item));
                if (result.extend.pageInfo.pageNum==item){
                    numLi.addClass("active");//每一页加高光
                }
                //分页栏中每一页的点击事件
                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            })
            ul.append(nestPageLi).append(lastPageLi);
            var navEle=$("<nav></nav>").append(ul);
            navEle.appendTo("#page_info_nav");
    }
    //清空样式
    function reset_from(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    //添加按钮
    $("#emp_add_mode_btn").click(function () {
        //清空表单

        reset_from("#empAddModal form");

        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $('#empAddModal').modal({
            backdrop:"static"
        });
    });
    //获取员工的部门名
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"/depts",
            type:"Get",
            success:function (result) {

                $.each(result.extend.dept,function (index,item) {
                    var optionEle=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                    optionEle.appendTo(ele);
                });

            }
        });
    }
    //校验表单方法
    function validate_add_form(){
        //校验名字合法
        var empName=$("#add_empName").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u4e00-\u9fa5]{2,5})/;
        if(!regName.test(empName)){

            //alert("用户名可以是2-5位汉字或者6-16位英文");
            show_validate_msg("#add_empName","error","用户名必须是2-5位汉字或者6-16位字母和数字");
            return false;
        }else {
            show_validate_msg("#add_empName","success","");
        }
        //检验邮箱合法
        var email=$("#input_email").val();
        var regEmail=/(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#input_email","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#input_email","success","");
        }
        return true;
    }
    //显示检验码
    function show_validate_msg(ele,status,msg){
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if(status=="success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if (status=="error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //输入发生改变验证是否有误
    $("#add_empName").change(function () {
        var empName=this.value;
        $.ajax({
            url:"/checkName",
            data:"empName="+empName,
            type:"post",
            success:function (result) {
                if (result.code==100){
                    show_validate_msg("#add_empName","success","用户名可用");
                    $("#saveEmp").attr("ajax-va","success");
                }else if(result.code==200){
                    show_validate_msg("#add_empName","error",result.extend.va_msg);
                    $("#saveEmp").attr("ajax-va","error");
                }
            }
        });

    });

    //点击保存
    $("#saveEmp").click(function () {

       if(!validate_add_form()){
            return false;
        };

       if($(this).attr("ajax-va")=="error"){
            return false;
        };

        $.ajax({
            url:"/emp",
            type:"post",
            data:$("#empForm").serialize(),
            success:function (result) {
                if (result.code==100){
                    $("#empAddModal").modal('hide');
                    to_page(totalRecord);
                }else{
                    if(undefined!=result.extend.errorFields.email){
                        //显示邮箱的错误信息
                        show_validate_msg("#input_email","error",result.extend.errorFields.email);
                    }
                    if(undefined!=result.extend.errorFields.empName){
                        //显示名字的错误信息
                        show_validate_msg("#add_empName","error",result.extend.errorFields.empName);
                    }
                }

            }
        });
    });

    //修改按钮
    $(document).on("click",".edit_btn",function () {
        //查出员工信息显示在页面中
        getEmp($(this).attr("edit_id"));
        //查出部门信息，并显示部门列表
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empUpdateModal select");
        //把员工的id传递给更新按钮
        $("#updateEmp").attr("edit_id",$(this).attr("edit_id"));


        //弹出模态框
        $('#empUpdateModal').modal({
            backdrop:"static"
        });
    });
    function getEmp(id) {
        $.ajax({
            url:"/emp/"+id,
            type:"get",
            success:function (result) {
                /*console.log(result);*/
                var empDate=result.extend.emp;
                $("#update_empName").text(empDate.empName);
                $("#update_email").val(empDate.email);
                $("#empUpdateModal input[name=empGender]").val([empDate.empGender]);
                $("#empUpdateModal select").val([empDate.dId]);
            }
        });
    }

    //点击更新，进行更新
    $("#updateEmp").click(function () {
        var email=$("#update_email").val();
        var regEmail=/(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#update_email","error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg("#update_email","success","");
        }
        //var data=$("#empUpdateForm").serialize()+"_method=PUT"
        var data=$("#empUpdateModal form").serialize();
        alert(data);
        $.ajax({
            url:"/saveEmp/"+$(this).attr("edit_id"),
            type:"POST",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                $("#empUpdateModal").modal("hide");
                to_page(courtPage);
            }
        });
    });
    //单个删除
    $(document).on("click",".delete_btn",function () {
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        var empId=$(this).attr("del_id");
        if (confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
               url:"/delemp/"+empId,
                type:"get",
                success:function (result) {
                    alert(result.msg);
                    to_page(courtPage);
                }
            });
        }
    });
    //全选和全不选
    $("#check_all").click(function () {
        //attr获取check是undfined
       //原生dom用prop获取，attr获取自定义
        $(this).prop("checked");
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function () {
        //当前选中的个数是不是5个
        //alert($(".check_item:checked").length==5);
        var flag= $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除
    $("#emp_delete_all").click(function () {
        var empNames="";
        var del_idstr=""
       $.each($(".check_item:checked"),function () {
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
       }) ;
        //alert(empNames);
        empNames=empNames.substring(0,empNames.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
/*        alert(empNames);
        alert(del_idstr);*/
        if (confirm("确认删除【"+empNames+"】吗？")){
            $.ajax({
                url:"/delemp/"+del_idstr,
                type:"get",
                success:function (result) {
                    alert(result.msg);
                    to_page(courtPage);
                }
            });
        }
    });
</script>
</body>
</html>
