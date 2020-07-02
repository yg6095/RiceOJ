<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>题目管理</title>
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
                    <h1 class="text-center">题目列表管理</h1>
                    <br><br>
                    <div id="problemlist" class="datagrid">
                        <div id="loading" data-loading="正在获取数据..." class="load-indicator loading" style="width: 100%; height: 100%"></div>
                        <div class="datagrid-container text-center"></div>
                        <hr>
                        <ul class="nav-justified">
                            <li class="btn-group">
                                <button type="button" class="btn btn-info" onclick="SelectAll()">全选</button>
                            </li>
                            <li class="btn-group">
                                <button type="button" class="btn btn-success" onclick="Do('display',-1)">公开</button>
                            </li>
                            <li class="btn-group">
                                <button type="button" class="btn btn-danger" onclick="Do('hidden', -1)">隐藏</button>
                            </li>
                            <li class="btn-group">
                                <button type="button" class="btn btn-info" onclick="Do('delete',-1)">删除</button>
                            </li>
                        </ul>

                        <div class="pager" style="display: block"></div>
                    </div>
                    <script>
                        $('#problemlist').datagrid({
                            dataSource: {
                                cols: [
                                    {name: 'problem_id', label: '题号', checkbox: true, width: 0.1},
                                    {name: 'title', label: '标题', width: 0.2, html: true},
                                    {name: 'source', label: '来源', width: 0.3},
                                    {name: 'provider', label: '提供者', width: 0.1},
                                    {name: 'status', label: '状态', width: 0.1, html: true},
                                    {name: 'delete', label: '删除', width: 0.1, html: true},
                                    {name: 'edit', label: '修改', width: 0.1, html: true}
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
                                    recPerPage: 30
                                },
                                sortBy: "problem_id",
                                order: "desc"
                            },
                            height: 'page',
                        });

                        function adminGet() {
                            $.ajax({
                                url: '${ptx}/searchAllProblems',
                                type: 'get',
                                success: function (data) {
                                    const solutions = $('#problemlist').data('zui.datagrid');
                                    $("#loading").css("display", "none");
                                    solutions.setDataSource(data["data"]);
                                    solutions.render();
                                }, error: function (data) {
                                    showError(data);
                                }
                            })
                        }
                        function userGet() {
                            $.ajax({
                                url: '${ptx}/searchProblemsByUser?user_id=${sessionScope.User.user_id}',
                                type: 'get',
                                success: function (data) {
                                    const solutions = $('#problemlist').data('zui.datagrid');
                                    $("#loading").css("display", "none");
                                    solutions.setDataSource(data["data"]);
                                    solutions.render();
                                }, error: function (data) {
                                    showError(data);
                                }
                            })
                        }
                        function get() {
                            if(${sessionScope.User.rightstr eq 'administrator'}){
                                adminGet();
                            }else{
                                userGet();
                            }
                        };
                        get();
                        function SelectAll() {
                            const myDataGrid = $('#problemlist').data('zui.datagrid');
                            const page = myDataGrid.getFilterParams();
                            for (var i = 0; i < page.recPerPage; i++) {
                                myDataGrid.checkRow(i, true);
                            }
                        }

                        function Do(op, id) {
                            const problems = new Array();
                            const url = "${ptx}/" + op + "Problem";
                            if (id != -1) problems.push(id);
                            else {
                                const myDataGrid = $('#problemlist').data('zui.datagrid');
                                const selections = myDataGrid.getCheckItems();
                                for (let i = 0; i < selections.length; i++) {
                                    if (selections[i] != null)
                                        problems.push(selections[i].problem_id);
                                }
                            }
                            if (op == "delete" && !confirm("确定删除该题目")) {
                                return false;
                            }
                            $.ajax({
                                url: url,
                                type: 'post',
                                contentType: "application/json",
                                data: JSON.stringify(problems),
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
