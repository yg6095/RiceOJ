<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="link.jsp"></c:import>
    <title>${requestScope.Contest.title}</title>
    <style>
        #contest_rank .datagrid-cell{
            padding: 0px;
            line-height:35px;
        }
        .error1{
            width: 100%;
            height: 100%;
            background: #FDD;
        }
        .first{
            width: 100%;
            height: 100%;
            background: #080;
        }
        .success{
            width: 100%;
            height: 100%;
            background: #A9F5AF;
        }
    </style>
</head>
<body>
<c:import url="header.jsp"></c:import>

<div class="container-fixed">
    <div style="display: flex; justify-content:space-between;">
        <span id="_start"></span>
        <h1>${requestScope.Contest.title}</h1>
        <span id="_end"></span>
    </div>
    <div class="progress progress-striped active">
        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 100%" id="progressbar"></div>
    </div>
    <div class="text-center" id="time">
        <span id="st"></span>
        <span id="_d"></span>
        <span id="_h"></span>
        <span id="_m"></span>
        <span id="_s"></span>
        <span id="_ms"></span>
    </div>
    <hr>
    <c:choose>
        <c:when test="${not empty sessionScope.User || requestScope.Contest._private == 0}">
            <c:choose>
                <c:when test="${fn:contains(requestScope.Contest.users, sessionScope.User.user_id) || requestScope.Contest.password eq ''}">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="contest?contest_id=${requestScope.Contest.contest_id}" data-target="#contest_description" data-toggle="tab">比赛详情</a></li>
                        <li><a href="#contest_problems" data-target="#contest_problems" data-toggle="tab">题单</a></li>
                        <li><a href="#contest_problem" data-target="#contest_problem" data-toggle="tab">题目</a></li>
                        <li><a href="#contest_status" data-target="#contest_status" data-toggle="tab">评测状态</a></li>
                        <li><a href="#contest_rank" data-target="#contest_rank" data-toggle="tab">排名</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="contest_description">
                            <div class="container-fixed-md">
                                <article class="article">
                                    <section class="content">
                                        ${requestScope.Contest.description}
                                    </section>
                                </article>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="contest_problems">
                            <h3 class="text-center">比赛题单</h3>
                            <div class="container-fixed-md">
                                <table class="table table-bordered" style="width: 100%;table-layout:fixed ">
                                    <thead >
                                        <tr>
                                            <th style="width: 10%;"></th>
                                            <th style="width: 10%;">统计</th>
                                            <th style="width: 10%;">题号</th>
                                            <th style="width: 50%;">标题</th>
                                            <th style="width: 20%;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="problem" items="${requestScope.Contest.problem_ids}">
                                        <tr>
                                            <td>${problem.status}</td>
                                            <td>${problem.c_accepted} / ${problem.c_submit}</td>
                                            <td>${problem.number}</td>
                                            <td><a onclick="work('${problem.number}')"> ${problem.title}</a></td>
                                            <td></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="contest_problem">
                            <h3 class="text-center"></h3>
                            <div class="row">
                                <div class="col-xs-1">
                                    <ul class="nav nav-tabs nav-stacked">
                                        <c:forEach items="${requestScope.Contest.problem_ids}" var="problem" begin="0" end="0">
                                            <li class="active"><a href="#problem${problem.number}" data-target="#problem${problem.number}" data-toggle="tab">${problem.number}</a></li>
                                        </c:forEach>
                                        <c:forEach items="${requestScope.Contest.problem_ids}" var="problem" begin="1">
                                            <li><a href="#problem${problem.number}" data-target="#problem${problem.number}" data-toggle="tab">${problem.number}</a></li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="col-xs-11">
                                    <div class="tab-content col-xs-13">
                                        <c:forEach var="p" items="${requestScope.Contest.problem_ids}" begin="0" end="0">
                                            <c:forEach var="problem" items="${requestScope.Contest.problems}">
                                                <c:if test="${p.problem_id == problem.problem_id}">
                                                    <div class="tab-pane fade active in" id="problem${p.number}">
                                                        <article class="article">
                                                            <header>
                                                                <h1 class="text-center">${p.number }:
                                                                        ${p.title }</h1>
                                                                <!-- 文章属性列表 -->
                                                                <dl class="dl-inline" style="text-align: center">
                                                                    <dt>时间限制:</dt>
                                                                    <dd>${problem.time_limit * 2000}/${problem.time_limit * 1000} MS (Java/Others)</dd>
                                                                    <dt>内存限制:</dt>
                                                                    <dd>${problem.memory_limit * 2 * 1024}/${problem.memory_limit * 1024 } KB (Java/Others)</dd>
                                                                </dl>
                                                            </header>
                                                            <!-- 文章正文部分 -->
                                                            <section class="content">
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>问题描述：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.description}</div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>输入描述：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.input}</div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>输出描述：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.output}</div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>样例输入：</h4>
                                                                        </div>

                                                                        <div class="item-content">
                                                                            <pre class="pre-scrollable">${problem.sample_input}</pre>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>样例输出：</h4>
                                                                        </div>
                                                                        <div class="item-content">
                                                                            <pre class="pre-scrollable">${problem.sample_output}</pre>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${not problem.hint eq ''}">
                                                                    <div class="items">
                                                                        <div class="item">
                                                                            <div class="item-heading">
                                                                                <h4>hint：</h4>
                                                                            </div>
                                                                            <div class="item-content">${problem.hint}</div>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>来源：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.source}</div>
                                                                    </div>
                                                                </div>

                                                            </section>
                                                            <!-- 文章底部 -->
                                                            <footer style="text-align: center">
                                                                <button class="btn btn-success" data-position="200px" data-toggle="modal" data-target="#submitModal">提交</button>
                                                            </footer>
                                                        </article>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                        <c:forEach var="p" items="${requestScope.Contest.problem_ids}" begin="1">
                                            <c:forEach var="problem" items="${requestScope.Contest.problems}">
                                                <c:if test="${p.problem_id == problem.problem_id}">
                                                    <div class="tab-pane fade" id="problem${p.number}">
                                                        <article class="article">
                                                            <header>
                                                                <h1 class="text-center">${p.number }:
                                                                        ${p.title }</h1>
                                                                <!-- 文章属性列表 -->
                                                                <dl class="dl-inline" style="text-align: center">
                                                                    <dt>时间限制:</dt>
                                                                    <dd>${problem.time_limit*2000}/${problem.time_limit*1000} MS (Java/Others)</dd>
                                                                    <dt>内存限制:</dt>
                                                                    <dd>${problem.memory_limit * 2 * 1024}/${problem.memory_limit * 1024 } KB (Java/Others)</dd>
                                                                </dl>
                                                            </header>
                                                            <!-- 文章正文部分 -->
                                                            <section class="content">
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>问题描述：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.description}</div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>输入描述：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.input}</div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>输出描述：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.output}</div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>样例输入：</h4>
                                                                        </div>

                                                                        <div class="item-content">
                                                                            <pre class="pre-scrollable">${problem.sample_input}</pre>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>样例输出：</h4>
                                                                        </div>
                                                                        <div class="item-content">
                                                                            <pre class="pre-scrollable">${problem.sample_output}</pre>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <c:if test="${not problem.hint eq ''}">
                                                                    <div class="items">
                                                                        <div class="item">
                                                                            <div class="item-heading">
                                                                                <h4>hint：</h4>
                                                                            </div>
                                                                            <div class="item-content">${problem.hint}</div>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                                <div class="items">
                                                                    <div class="item">
                                                                        <div class="item-heading">
                                                                            <h4>来源：</h4>
                                                                        </div>
                                                                        <div class="item-content">${problem.source}</div>
                                                                    </div>
                                                                </div>

                                                            </section>
                                                            <!-- 文章底部 -->
                                                            <footer style="text-align: center">
                                                                <button class="btn btn-success" data-position="200px" data-toggle="modal" data-target="#submitModal">提交</button>
                                                            </footer>
                                                        </article>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="contest_status">
                            <h3 class="text-center">提交详情</h3>
                            <div class="container-fixed">
                                <div id="contestStatus" class="datagrid  datagrid-striped">
                                    <div class="datagrid-container text-center"></div>
                                    <div class="pager"></div>
                                </div>
                            </div>
                            <div class="modal fade" id="modal_sol">
                                <div class="modal-dialog  modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">
                                                <span aria-hidden="true">×</span><span class="sr-only">关闭</span>
                                            </button>
                                            <h4 class="modal-title" id="modal_title"></h4>
                                        </div>
                                        <div class="modal-body">
                                            <table class="table table-auto table-bordered text-center">
                                                <thead>
                                                <tr>
                                                    <th>Status</th>
                                                    <th>Time</th>
                                                    <th>Memory</th>
                                                    <th>Length</th>
                                                    <th>Language</th>
                                                    <th>Submited</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td id="modal_status"></td>
                                                    <td id="modal_time"></td>
                                                    <td id="modal_memory"></td>
                                                    <td id="modal_length"></td>
                                                    <td id="modal_language"></td>
                                                    <td id="modal_date"></td>
                                                </tr>
                                                </tbody>
                                            </table>
                                            <pre class="prettyprint" id="modal_code"></pre>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default"
                                                    data-dismiss="modal">关闭</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                $('#contestStatus').datagrid({
                                    dataSource : {
                                        cols : [
                                            {name : 'in_date',label : '提交时间',sort : false,width:0.2
                                                ,valueOperator : {
                                                    getter : function(dataValue, cell, dataGrid) {
                                                        return DateFormat(new Date(dataValue));
                                                    }
                                                }},
                                            {name : 'num',label : '题号',checkbox : false,html:true,width:0.1,valueOperator : {
                                                getter : function(dataValue, cell, dataGrid) {
                                                    return String.fromCharCode(dataValue + 64);
                                                }
                                            }},
                                            {name : 'user_id',label : '用户',sort : false,width:0.1},
                                            {name : 'html_language',label : '语言',sort : false,width:0.1},
                                            {name : 'html_status',label : '结果',sort : false, html:true,width:0.15},
                                            {name : 'html_score',label : '分数',sort : false, html:true,width:0.05},
                                            {name : 'html_time',label : '时间消耗',sort : false,width:0.1},
                                            {name : 'html_memory',label : '内存消耗',sort : false, width:0.1},
                                        ]
                                    },
                                    sortable : true,
                                    selectable : false,
                                    checkable : true,
                                    showRowIndex : false,
                                    rowIndexWidth: 0,
                                    states : {
                                        pager : {
                                            page : 1,
                                            recPerPage : 50
                                        },
                                        sortBy:'in_date',
                                        order:'desc'
                                    },
                                    height : 'page',
                                    hoverCol:false,
                                    onSelectRow : function(rowId, checked, selections) {
                                        const solutions = (this.getRowConfig(rowId))["data"];
                                        const select_user_id = this.getCell(rowId, 3).value;
                                        const user_id = "${sessionScope.User.user_id}";
                                        if(user_id == select_user_id){
                                            $("#modal_title").html("#" + solutions["solution_id"]);
                                            $("#modal_date").html(DateFormat(new Date(solutions["in_date"])));
                                            $("#modal_language").html(solutions["html_language"]);
                                            $("#modal_length").html(solutions["code_length"] + " bytes");
                                            $("#modal_status").html(solutions["html_status"]);
                                            $("#modal_time").html(solutions["html_time"]);
                                            $("#modal_memory").html(solutions["html_memory"]);
                                            $("#modal_code").html(solutions["source"]);
                                            $('#modal_sol').modal({
                                                keyboard : false,
                                                show     : true
                                            })
                                        }else{
                                            showError({message:"您当前无法查看此提交信息"});
                                        }
                                        $("#modal_code").removeClass("prettyprinted");
                                        prettifyLoad();
                                    },
                                });
                                function getContestStatus() {
                                    $.ajax({
                                        url:'${ptx}/getContestStatus?contest_id=${requestScope.Contest.contest_id}',
                                        type: 'get',
                                        success: function (data) {
                                            const contestStatus = $('#contestStatus').data('zui.datagrid');
                                            contestStatus.setDataSource(data["data"]);
                                            contestStatus.render();
                                        },error: function(data){
                                            showError(data)
                                        }
                                    })
                                }
                                getContestStatus();
                                setInterval(getContestStatus,3000);
                            </script>
                        </div>
                        <div class="tab-pane fade" id="contest_rank">
                            <h3 class="text-center">排名</h3>
                            <div class="container-fixed">
                                <div id="contestRank" class="datagrid">
                                    <div class="datagrid-container text-center"></div>
                                </div>
                            </div>
                            <script>
                                const items = document.getElementById("contest_problem").getElementsByTagName("li");
                                const col1 = [
                                    {name : 'rank',label : '排名', width:50},
                                    {name : 'team',label : '用户名',width:150, html:true},
                                    {name : 'ac_count',label : '通过数',width:70},
                                    {name : 'sumTime',label : '罚时',width:70}
                                ];
                                for(let i = 0; i < items.length; i++){
                                    const number = items.item(i).innerText
                                    col1.push({name : 'problem'+number,label : ''+number,minWidth:70,html: true});
                                }
                                $('#contestRank').datagrid({
                                    dataSource: {
                                        cols: col1
                                    },
                                    states:{
                                        fixedLeftUntil:4
                                    },
                                    height:'page',
                                    selectable : false,
                                    showRowIndex : false,
                                    rowDefaultHeight:50,
                                    rowIndexWidth: 0,
                                    hoverRow:false,
                                    hoverCol:false,
                                });

                                function getContestRank() {
                                    $.ajax({
                                        url:'${ptx}/getContestRank?contest_id=${requestScope.Contest.contest_id}',
                                        type: 'get',
                                        success: function (data) {
                                            const rank = $('#contestRank').data('zui.datagrid');
                                            rank.setDataSource(data["data"]);
                                            rank.render();
                                        //    $(".error").parent().addClass('bg-warning-pale');
                                            $(".success").parent().addClass('bg-success-pale');
                                            $(".first").parent().addClass('bg-success');

                                        },error: function(data){
                                            showError(data)
                                        }
                                    })
                                }
                                getContestRank();
                                setInterval(getContestRank,3000);
                            </script>
                        </div>
                        <div class="modal fade " id="submitModal">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                                        <h4 class="modal-title">提交</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form class="form-horizontal" id="contestSubmitForm">
                                            <div class="form-group">
                                                <input type="hidden" value="${requestScope.Contest.contest_id}" name="contest_id"/>
                                                <label class="col-sm-2">题号</label>
                                                <div class="col-sm-10">
                                                    <select class="form-control" name="num">
                                                        <c:forEach items="${requestScope.Contest.problem_ids}" var="problem">
                                                            <option value="${problem.num}">${problem.number} - ${problem.title}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <label class="col-sm-2">语言</label>
                                                <div class="col-sm-10">
                                                    <select class="form-control" name="language">
                                                        <option value="0">C</option>
                                                        <option value="1">C++</option>
                                                        <option value="3">Java</option>
                                                        <option value="6">Python</option>
                                                    </select>
                                                </div>
                                                <label class="col-sm-2">代码</label>
                                                <div class="col-sm-10">
                                                    <textarea class="form-control" rows="20" name="code"></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-2 col-sm-10">
                                                    <button class="btn btn-default" id="contestSubmitBtn">提交</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                    </div>
                                </div>
                            </div>
                            <script>
                                $("#contestSubmitBtn").click(function () {
                                    if(${empty sessionScope.User}){
                                        $('#submitModal').modal('hide', 'fit')
                                        showError({'message':"用户尚未登录"});
                                        return false;
                                    }
                                    $.ajax({
                                        url:"${ptx}/contestSubmit",
                                        type:"post",
                                        data:$("#contestSubmitForm").serialize(),
                                        success: function(data){
                                            if(data["code"] == 0){
                                                $('#submitModal').modal('hide', 'fit');
                                                $("[data-target = '#contest_problem']").parent().removeClass('active');
                                                $("#contest_problem").removeClass('active in');
                                                $("[data-target = '#contest_status']").parent().addClass('active');
                                                $("#contest_status").addClass('active in');
                                            }else{
                                                showError(data)
                                            }
                                        },error: function(data){
                                            showError(data);
                                        }
                                    })
                                    return false;
                                })
                            </script>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"></button>
                                <h4 class="modal-title text-center">注册码</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form-horizontal" method="post">
                                    <div class="form-group">
                                        <label for="password" class="col-sm-3">密码</label>
                                        <div class="col-md-6 col-sm-10">
                                            <input type="text" class="form-control" name="password" id="password">
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="contestRegBtn">进入</button>
                            </div>
                        </div>
                    </div>
                    <script>
                        $("#contestRegBtn").click(function () {
                            if(${empty sessionScope.User}){
                                showError({message:"请登录后再注册比赛"})
                                return false;
                            }
                            $.ajax({
                                url:"${ptx}/registerContest",
                                type:"post",
                                data:{
                                    "contest_id":${requestScope.Contest.contest_id},
                                    "user_id":"${sessionScope.User.user_id}",
                                    "password": $("#password").val()
                                },
                                success: function(data){
                                    if(data["code"] == 0){
                                        location.reload();
                                    }else{
                                        showError(data)
                                    }
                                },error: function(data){
                                    showError(data)
                                }
                            })
                        });
                    </script>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <h1 class="text-center">请登录后再进行操作</h1>
        </c:otherwise>
    </c:choose>
</div>
<c:import url="footer.jsp"></c:import>
<script>
    function work(id){
        console.log(id);
        $("[data-target = '#contest_problems']").parent().removeClass('active');
        $("#contest_problems").removeClass('active in');
        $("[data-target = '#contest_problem']").parent().addClass('active');
        $("#contest_problem").addClass('active in');
        $("#contest_problem li").removeClass('active in');
        $("#contest_problem div").removeClass('active in');
        $("[data-target = '#problem" + id + "']").parent().addClass('active');
        $("#problem"+id).addClass('active in');
    }
    $("#_start").html(DateFormat(new Date(${requestScope.Contest.start_time.getTime()})))
    $("#_end").html(DateFormat(new Date(${requestScope.Contest.end_time.getTime()})))
    function countTime() {
        const date = new Date();
        const now = date.getTime();
        const end = parseInt("${requestScope.Contest.end_time.getTime()}");//设置截止时间
        const start = parseInt("${requestScope.Contest.start_time.getTime()}");
        const maxtime = end - start;
        let leftTime = start - now; //时间差
        let d, h, m, s, ms;
        if(leftTime >= 0) {
            d = Math.floor(leftTime / 1000 / 60 / 60 / 24);
            h = Math.floor(leftTime / 1000 / 60 / 60 % 24);
            m = Math.floor(leftTime / 1000 / 60 % 60);
            s = Math.floor(leftTime / 1000 % 60);
            if(s < 10) {
                s = "0" + s;
            }
            if(m < 10) {
                m = "0" + m;
            }
            if(h < 10) {
                h = "0" + h;
            }
            //将倒计时赋值到div中
            $("#st").html("距离比赛开始还有")
            $("#_d").html(d + "天");
            $("#_h").html(h + "时");
            $("#_m").html(m + "分");
            $("#_s").html(s + "秒");
            $("#progressbar").width("0%");
            $("#time").addClass("text-info")
            setTimeout(countTime, 500);
        } else {
            leftTime = end - now;
            if(leftTime >= 0) {
                d = Math.floor(leftTime / 1000 / 60 / 60 / 24);
                h = Math.floor(leftTime / 1000 / 60 / 60 % 24);
                m = Math.floor(leftTime / 1000 / 60 % 60);
                s = Math.floor(leftTime / 1000 % 60);
                if(s < 10) {
                    s = "0" + s;
                }
                if(m < 10) {
                    m = "0" + m;
                }
                if(h < 10) {
                    h = "0" + h;
                }
                //将倒计时赋值到div中
                $("#st").html("距离比赛结束还有")
                $("#_d").html(d + "天");
                $("#_h").html(h + "时");
                $("#_m").html(m + "分");
                $("#_s").html(s + "秒");
                const precent = leftTime / maxtime * 100;
                $("#progressbar").width(parseInt(100 - precent)+"%");
                $("#time").addClass("text-success");
                setTimeout(countTime, 500);
            } else {
                $("#progressbar").width("100%");
                $("#time").html("已结束");
                $("#time").addClass("text-danger")
            }
        }
    }
    countTime();
</script>
</body>
</html>
