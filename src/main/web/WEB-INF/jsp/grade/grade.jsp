<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/9/009
  Time: 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <%@include file="../basic.jsp"%>
    <script type="text/javascript">
        $(function () {
            //班级详情
            $("button[name=queryGradeButton]").click(function () {
                var gradeId=$(this).attr("gradeId");
                $.get("${pageContext.request.contextPath}/grade/queryGradeById",{"gradeId":gradeId},function (data) {
                    $("#gradeNameDiv").html(data.gradeName);
                    $("#createDateDiv").html(data.createDate);
                    $("#detailsDiv").html(data.details);
                });
                $("#gradeDetailsModal").modal("show");
            })
            //删除班级（单条）
            $("button[name=deleteGradeButton]").click(function () {
                var gradeId=$(this).attr("gradeId");
                var url="${pageContext.request.contextPath}/grade/deleteGradeById";
                $.post(url,{"gradeId":gradeId},function (data) {
                    alert(data.msg);
                    location.href = location.href;

                });


            })
            //批量删除
            $("#deleteGradeByIdsButton").click(function () {
                /**
                 *       $.each($("input:checkbox"),function () {
            if(this.checked){
                gradeIds=gradeIds+$(this).val()+",";
            }
        })
                 * @type {string}
                 */
                var gradeIds="";
                $.each($("input:checkbox"),function () {
                    if(this.checked){
                        gradeIds=gradeIds+$(this).val()+",";
                    }
                })
                if(gradeIds==""){
                    alert("请选择要删除的班级");
                    return
                }
                if(confirm("确定要删除？")){
                    $.post("${pageContext.request.contextPath}/grade/deleteGradeByIds",
                        {"gradeIds":gradeIds},function (data) {
                            alert(data.msg);
                            location.href=location.href;
                        })
                }

            })
            //添加
            $("#addGradeButton").click(function () {
                $("#gradeAddModal").modal("show");
            })
            $("#addGrade").click(function () {
                var grade=$("#addGradeForm").serialize();
                $.post("${pageContext.request.contextPath}/grade/addGrade",
                    grade,function (data) {
                        alert(data.msg);
                        $("#gradeAddModal").modal("show");
                        location.href = location.href;
                    })
            })
            //修改
            $("button[name=updateGradeButton]").click(function () {
                var gradeId=$(this).attr("gradeId");
                alert(gradeId);
                $.get("${pageContext.request.contextPath}/grade/queryGradeById",
                    {"gradeId":gradeId},function (data) {
                        alert(data);
                        $("#updateGradeName").val(data.gradeName);
                        $("#updateDetails").val(data.details);
                        $("#updateId").val(gradeId);
                    })
                $("#gradeUpdateModal").modal("show");
            })
            $("#updateGrade").click(function () {
                var grade=$("#updateGradeForm").serialize();
                $.post("${pageContext.request.contextPath}/grade/updateGrade",
                        grade,function (data) {
                        alert(data.msg);
                        $("#gradeUpdateModal").modal("hide");
                        location.href = location.href;
                    })
            })
        })
    </script>
</head>
<body>
<%@include file="../top.jsp"%>

<div class="container">
    <div class="row">
        <%@include file="../left.jsp"%>
        <div class="col-lg-4 col-lg-offset-2">
            <h3>班级管理</h3>
        </div>
        <div class="col-lg-2 col-lg-offset-2">
            <button class="btn btn-danger" id="deleteGradeByIdsButton">删除</button>
            <button class="btn btn-danger" id="addGradeButton">添加</button>
        </div>


    </div>
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2" >
            <table class="table table-striped">
                <tr>
                    <td></td>
                    <td>id</td>
                    <td>班级名称</td>
                    <td>创建时间</td>
                    <td>描述</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="${pageInfo.list}" var="grade">
                    <tr>
                        <td>
                            <input type="checkbox" name="gradeIds" value="${grade.id}">
                        </td>
                        <td>${grade.id}</td>
                        <td>${grade.gradeName}</td>
                        <td>
                            <fmt:formatDate value="${grade.createDate}" pattern="yyyy-MM-dd"></fmt:formatDate>

                        </td>
                        <td>${grade.details}</td>
                        <td>
                            <button type="button" class="btn btn-info " name="queryGradeButton" gradeId="${grade.id}">详情</button>
                            <button type="button" class="btn btn-info btn " name="updateGradeButton" gradeId="${grade.id}">修改</button>
                            <button type="button" class="btn btn-danger btn" name="deleteGradeButton" gradeId="${grade.id}">删除</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%@include file="../page.jsp"%>

    <!--详情模态框-->
    <div class="modal fade" tabindex="-1" role="dialog" id="gradeDetailsModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">班级详情</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered">
                        <tr>
                            <td>班级名称：</td>
                            <td>
                                <div id="gradeNameDiv"></div>
                            </td>
                        </tr>
                        <tr>
                            <td>创建时间：</td>
                            <td>
                                <div id="createDateDiv"></div>
                            </td>
                        </tr>
                        <tr>
                            <td>描述：</td>
                            <td>
                                <div id="detailsDiv"></div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <!--添加模态框-->
    <div class="modal fade" tabindex="-1" role="dialog" id="gradeAddModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">班级添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="addGradeForm">
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">班级名称：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="gradeName" placeholder="班级名称">
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">班级描述：</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" rows="3" name="details"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-default" data-dismiss="modal" id="addGrade">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <!--修改模态框-->
    <div class="modal fade" tabindex="-1" role="dialog" id="gradeUpdateModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">班级修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="updateGradeForm">
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">班级名称：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="updateGradeName" name="gradeName" placeholder="班级名称" disabled>
                                <input type="hidden" id="updateId" name="id" >
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">班级描述：</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" rows="3" name="details" id="updateDetails"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-default" data-dismiss="modal" id="updateGrade">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>
</body>
</html>
