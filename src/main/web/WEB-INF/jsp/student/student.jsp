<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 大聪
  Date: 2017/12/9
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="../basic.jsp"%>
    <script type="text/javascript">
        $(function () {
            $("button[name=deleteStudentButton]").click(function () {
                var studentId = $(this).attr("studentId");
                $.post("${pageContext.request.contextPath}/student/deleteStudentByIds",
                    {"idStr":studentId},function (data) {
                        alert(data.msg);
                        location.href = location.href;
                    })
            })
            $("#deleteGradeByIdsButton").click(function () {
                var studentId = "";
                $.each($("input:checkbox"),function () {
                    if (this.checked){
                        studentId = studentId + $(this).val() + ",";
                    }
                })
                if (studentId==""){
                    alert("请选择要删除的学生");
                    return;
                }
                if (confirm("确定要删除吗?")){
                    $.post("${pageContext.request.contextPath}/student/deleteStudentByIds",
                        {"idStr":studentId},function (data) {
                            alert(data.msg);
                            location.href = location.href;
                        })
                }
            })
            //添加
            $("#addGradeButton").click(function () {
                selectOption($("#addStudentGradeSelect"));
                $("#addStudentModel").modal("show");
            })
            $("#saveAddStudent").click(function () {
                var student = $("#addStudentFrom").serialize();
                $.post("${pageContext.request.contextPath}/student/addStudent",
                    student,function (data) {
                        alert(data.msg);
                        $("#addStudentModel").modal("hide");
                        location.href = location.href;
                    })
            })
            //详情
            $("button[name=queryStudentButton]").click(function () {
                var studentId = $(this).attr("studentId");
                $.get("${pageContext.request.contextPath}/student/queryStudentById",
                    {"studentId":studentId},function (data) {
                        $("#queryStudentName").val(data.studentName);
                        $("#queryStudentAge").val(data.age);
                        $("#queryStudentGender").val(data.gender);
                        $("#queryStudentNum").val(data.studentNum);
                        $("#queryGradeId").val(data.grade.gradeName);
                    })
                $("#queryStudentModel").modal("show");
            })
            //修改
            $("button[name=updateStudentButton]").click(function () {
                var studentId = $(this).attr("studentId");
                $.get("${pageContext.request.contextPath}/student/queryStudentById",
                    {"studentId":studentId},function (data) {
                        $("#updateStudentName").val(data.studentName);
                        $("#updateAge").val(data.age);
                        $("#updateStudentId").val(data.id);
                        $("#updateStudentNum").val(data.studentNum);
                        if (data.gender=='男'){
                            $("#updateGender1").attr("checked", true);
                        }else{
                            $("#updateGender2").attr("checked", true);
                        }
                        var gradeId = data.grade.id;
                        selectOption($("#updateStudentGradeSelect"), gradeId);
                    })
                $("#updateStudentModal").modal("show");
            })
            $("#updateStudentSaveButton").click(function () {
                var student = $("#updateStudentForm").serialize();
                $.post("${pageContext.request.contextPath}/student/updateStudent",
                    student,function (data) {
                        alert(data.msg);
                        location.href = location.href;
                    })
            })

        })
        function selectOption(ele,gradeId) {
            ele.empty();
            $.get("${pageContext.request.contextPath}/student/queryAll",
                function (data) {
                    for (var i=0;i<data.length;i++) {
                        var option="<option value='"+data[i].id+"'>"+data[i].gradeName+"</option>"
                        ele.append(option);
                    }
                    if (gradeId!=null){
                        ele.val(gradeId);
                    }
                })
        }
    </script>
</head>
<body>
<%@include file="../top.jsp"%>
<div class="container">
    <div class="row">
        <%@include file="../left.jsp"%>
        <div class="col-lg-4 col-lg-offset-2">
            <h3>学生管理</h3>
        </div>
        <div class="col-lg-2 col-lg-offset-2">
            <button class="btn btn-danger" id="deleteGradeByIdsButton">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                删除
            </button>
            <button class="btn btn-info" id="addGradeButton">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                添加
            </button>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <table class="table table-bordered">
                <tr>
                    <td></td>
                    <td>学生id</td>
                    <td>姓名</td>
                    <td>性别</td>
                    <td>年龄</td>
                    <td>学生编号</td>
                    <td>班级</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="student">
                    <tr>
                        <td>
                            <input type="checkbox" name="studentCheckBox" value="${student.id}"/>
                        </td>
                        <td>${student.id}</td>
                        <td>${student.studentName}</td>
                        <td>${student.gender}</td>
                        <td>${student.age}</td>
                        <td>${student.studentNum}</td>
                        <td>${student.grade.gradeName}</td>
                        <td>
                            <button class="btn btn-info" name="queryStudentButton" studentId="${student.id}">详情</button>
                            <button class="btn btn-info" name="updateStudentButton" studentId="${student.id}">修改</button>
                            <button class="btn btn-danger" name="deleteStudentButton" studentId="${student.id}">删除</button>

                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<%@include file="../page.jsp"%>
<%--添加学生模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="addStudentModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">学生添加</h4>
            </div>
            <form class="form-horizontal" id="addStudentFrom">
                <div class="form-group">
                    <label class="col-sm-3 control-label">学生姓名:</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="studentName" placeholder="学生姓名">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">年龄:</label>
                    <div class="col-sm-8">
                        <input type="number" class="form-control" name="age" placeholder="年龄" min="0">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">性别:</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="gender">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">班级:</label>
                    <div class="col-sm-8">
                        <select class="form-control" name="grade.id" id="addStudentGradeSelect">
                        </select>
                        <input type="hidden" name="grade.gradeName" id="addGradeName" />
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveAddStudent">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!--详情模态框-->
<div class="modal fade" tabindex="-1" role="dialog" id="queryStudentModel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">学生添加</h4>
            </div>
            <form class="form-horizontal" id="queryStudentFrom">
                <div class="form-group">
                    <label class="col-sm-3 control-label">学生姓名:</label>
                    <div class="col-sm-8">
                        <input type="text" id="queryStudentName" class="form-control" name="studentName" placeholder="学生姓名">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">年龄:</label>
                    <div class="col-sm-8">
                        <input type="number" id="queryStudentAge" class="form-control" name="age" placeholder="年龄" min="0">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">性别:</label>
                    <div class="col-sm-8">
                        <input type="text" id="queryStudentGender" class="form-control"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">班级:</label>
                    <div class="col-sm-8">
                        <input type="text" id="queryGradeId" class="form-control"/>
                        <input type="hidden" name="grade.gradeName" id="queryGradeName" />
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-3 control-label">学生编号：</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="queryStudentNum" name="studentNum">
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!--修改学生模态框-->
<div class="modal fade" tabindex="-1" role="dialog" id="updateStudentModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改学生</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateStudentForm">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">学生姓名：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="updateStudentName" name="studentName" placeholder="学生姓名">
                            <input type="hidden" name="id" id="updateStudentId"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">年龄：</label>
                        <div class="col-sm-8">
                            <input type="number" min="1" class="form-control" id="updateAge" name="age" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">性别：</label>
                        <div class="col-sm-8">
                            <input type="radio" id="updateGender1" name="gender" value="男"/>男
                            <input type="radio" id="updateGender2" name="gender" value="女"/>女
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">班级：</label>
                        <div class="col-sm-8">
                            <select class="form-control" name="grade.id" id="updateStudentGradeSelect">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">学生编号：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="updateStudentNum" readonly>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateStudentSaveButton">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</div>

</body>
</html>
