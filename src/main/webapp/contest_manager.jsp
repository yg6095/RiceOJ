<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>比赛管理</title>
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
                <c:when test="${not empty sessionScope.User}">
                    <h1 class="text-center">比赛列表管理</h1>
                    <br><br>
                    <div id="contestList" class="datagrid">
                        <div class="datagrid-container text-center"></div>
                        <hr>
                        <ul class="nav-justified">
                            <li class="btn-group">
                                <button type="button" class="btn btn-info" onclick="SelectAll()">全选</button>
                            </li>
                            <li class="btn-group">
                                <button type="button" class="btn btn-info" onclick="Do('delete',-1)">删除</button>
                            </li>
                        </ul>

                        <div class="pager" style="display: block"></div>
                    </div>
                    <script>

                            $('#contestList').datagrid({
                                dataSource: {
                                    cols: [
                                        {name: 'contest_id', label: '#', checkbox: true, width: 0.1},
                                        {name: 'title', label: '标题', sort: false, width: 0.2, html: true},
                                        {name: 'user_id', label: '创建人', sort: false, width: 0.1},
                                        {
                                            name: 'start_time', label: '开始时间', sort: true, valueOperator: {
                                                getter: function (dataValue, cell, dataGrid) {
                                                    const time = new Date(dataValue);
                                                    return DateFormat(time);
                                                }
                                            }, width: 0.18
                                        },
                                        {
                                            name: 'end_time', label: '结束', sort: true, valueOperator: {
                                                getter: function (dataValue, cell, dataGrid) {
                                                    const time = new Date(dataValue);
                                                    return DateFormat(time);
                                                }
                                            }, width: 0.18
                                        },
                                        {name: 'password', label: '密码', width: 0.1, html: true},
                                        {name: 'status', label: '状态', width: 0.07, html: true},
                                        {name: 'edit', label: '修改', width: 0.07, html: true}
                                    ]
                                },
                                selectable: false,
                                checkable: true,
                                showRowIndex: false,
                                rowIndexWidth: 0,
                                hoverRow: false,
                                hoverCol: false,
                                checkByClickRow: false,
                                states: {
                                    pager: {
                                        page: 1,
                                        recPerPage: 20
                                    },
                                    sortBy: "contest_id",
                                    order: "desc"
                                },
                                height: 'page',
                            });

                        function adminGet() {
                            $.ajax({
                                url: '${ptx}/searchAllContests',
                                type: 'get',
                                success: function (data) {
                                    const solutions = $('#contestList').data('zui.datagrid');
                                    solutions.setDataSource(data["data"]);
                                    solutions.render();
                                }, error: function (data) {
                                    showError(data);
                                }
                            })
                        }

                        function userGet() {
                            $.ajax({
                                url: '${ptx}/searchContestsByUser?user_id=${sessionScope.User.user_id}',
                                type: 'get',
                                success: function (data) {
                                    const solutions = $('#contestList').data('zui.datagrid');
                                    solutions.setDataSource(data["data"]);
                                    solutions.render();
                                }, error: function (data) {
                                    showError(data);
                                }
                            })
                        }
                        function get() {
                            if (${sessionScope.User.rightstr eq "administrator"}) {
                                adminGet();
                            } else {
                                userGet();
                            }
                        }
                        get();
                        function SelectAll() {
                            const myDataGrid = $('#contestList').data('zui.datagrid');
                            const page = myDataGrid.getFilterParams();
                            for (var i = 0; i < page.recPerPage; i++) {
                                myDataGrid.checkRow(i, true);
                            }
                        }

                        function Do(op, id) {
                            const contests = new Array();
                            const url = "${ptx}/" + op + "Contest";
                            if (id != -1) contests.push(id);
                            else {
                                const myDataGrid = $('#contestList').data('zui.datagrid');
                                const selections = myDataGrid.getCheckItems();
                                for (let i = 0; i < selections.length; i++) {
                                    if (selections[i] != null)
                                        contests.push(selections[i].contest_id);
                                }
                            }
                            if (op == "delete" && !confirm("确定删除该题目")) {
                                return false;
                            }
                            $.ajax({
                                url: url,
                                type: 'post',
                                contentType: "application/json",
                                data: JSON.stringify(contests),
                                success: function (data) {
                                    get();
                                }, error: function (data) {
                                    showError(data);
                                }
                            })
                        }
                    </script>
                </c:when>
                <c:otherwise>
                    <h1 class="text-center">请登录后再进行操作</h1>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<c:import url="footer.jsp"></c:import>
</body>
</html>
