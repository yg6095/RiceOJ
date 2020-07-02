<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理</title>
    <c:import url="link.jsp"></c:import>
</head>
<body>
<c:import url="header.jsp"></c:import>
<div class="container-fixed">
    <div class="row">
        <div class="col-xs-3">
            <c:import url="manager_menu.jsp"></c:import>
        </div>
        <div class="col-xs-9">
            <c:choose>
                <c:when test="${not empty sessionScope.User and sessionScope.User.rightstr eq 'administrator'}">
                    <h1 class="text-center">用户权限添加和管理：</h1>
                    <br><br>
                    <h4>权限添加:</h4>
                    <div class="input-group">
                        <span class="input-group-addon">权限</span>
                        <select class="form-control" id="privilege">
                            <option value="teacher">管理员</option>
                            <option value="administrator">教师</option>
                        </select>
                        <span class="input-group-addon fix-border fix-padding"></span>
                        <input type="text" id="userid" class="form-control" placeholder="用户名">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="addbtn">添加</button>
                        </span>
                    </div>
                    <br>
                    <h4>管理列表:</h4>
                    <div>
                        <div id="userList" class="datagrid">
                            <div class="datagrid-container text-center"></div>
                            <hr>
                        </div>
                    </div>
                    <script>
                        $('#userList').datagrid({
                            dataSource: {
                                cols: [
                                    {name: 'user_id', label: '用户名', checkbox: true},
                                    {name: 'rightstr', label: '权限'},
                                    {name: 'delete', label: '删除', html: true},
                                ]
                            },
                            selectable: false,
                            checkable: true,
                            showRowIndex: false,
                            rowIndexWidth: 0,
                            height: 'page',
                            hoverRow: false,
                            hoverCol: false,
                            checkByClickRow: false,
                        });
                        function get() {
                            $.ajax({
                                url: '${ptx}/searchAllPrivilege',
                                type: 'get',
                                success: function (data) {
                                    const solutions = $('#userList').data('zui.datagrid');
                                    solutions.setDataSource(data["data"]);
                                    solutions.render();
                                },error: function (data) {
                                    showError(data);
                                }
                            })
                        }
                        get();
                        $("#addbtn").click(function () {
                            const user_id = $("#userid").val();
                            if (user_id == "") {
                                showError({message: "请输入用户名"})
                                return false;
                            }
                            $.ajax({
                                url: '${ptx}/insertPrivilege',
                                type: 'get',
                                data: {
                                    user_id: user_id,
                                },
                                success: function (data) {
                                    if(data["code"] == 0) get();
                                    else showError(data);
                                },error: function (data) {
                                    showError(data);
                                }
                            })
                        })
                        function Delete(id) {
                            if (confirm("确认删除用户权限")) {
                                $.ajax({
                                    url: '${ptx}/deletePrivilege',
                                    type: 'get',
                                    data: {
                                        user_id: id,
                                    },
                                    success: function (data) {
                                        if(data["code"] == 0) get();
                                        else showError(data);
                                    },error: function (data) {
                                        showError(data);
                                    }
                                })
                            }
                        }
                    </script>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${empty sessionScope.User}">
                            <h1 class="text-center">请登录后再进行操作</h1>
                        </c:when>
                        <c:otherwise>
                            <h1 class="text-center">您尚未获得管理员权限</h1>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>
<c:import url="footer.jsp"></c:import>
</body>
</html>
