<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>比赛列表</title>
    <c:import url="link.jsp"></c:import>
</head>
<body>
    <c:import url="header.jsp"></c:import>

    <div class="container-fixed">
        <div id="futureContest" class="datagrid datagrid-striped" >
            <h4>正在进行或尚未开始:<a style="float:right" id="addContest" href="${ptx}/contest_create.jsp">创建比赛<i class="icon icon-plus"></i></a></h4>
            <div class="datagrid-container text-center"></div>
            <div class="pager"></div>
        </div>
        <div id="endContest" class="datagrid datagrid-striped" >
            <h4>已经结束:</h4>
            <div class="datagrid-container text-center"></div>
            <div class="pager"></div>
        </div>
    </div>
    <c:import url="footer.jsp"></c:import>
    <script>
        $(function(){
            $.ajax({
                url: '${ptx}/searchFutureContests',
                type: 'get',
                success: function(data){
                    $('#futureContest').datagrid({
                        dataSource: {cols : [
                                {name : 'contest_id',label : '#', width:0.1},
                                {name : 'title',label : '标题', sort: false, width: 0.3,html:true},
                                {name : 'user_id',label : '创建人',sort : false, width:0.1},
                                {name : 'start_time', label:'开始时间',sort:true,valueOperator : {
                                    getter : function(dataValue, cell, dataGrid) {
                                        const time = new Date(dataValue);
                                        return DateFormat(time);
                                    }}, width:0.15
                                },
                                {name : 'end_time', label:'结束',sort:true,valueOperator : {
                                        getter : function(dataValue, cell, dataGrid) {
                                            const time = new Date(dataValue);
                                            return DateFormat(time);
                                        }}, width:0.15
                                },
                                {name : 'status',label : '状态',sort : false, width:0.1,html:true},
                                {name : 'rg_count',label : '人数',sort : false, width:0.1},
                            ],
                            array: data["data"]
                        },
                        states: {
                            pager: {page: 1, recPerPage: Math.min(10,data["data"].length)}
                        },
                        height : 'page',
                        sort:true,
                        showRowIndex : false,
                        rowIndexWidth: 0,
                        hoverRow: false,
                        hoverCol: false
                    });
                }
            })
            $.ajax({
                url: '${ptx}/searchEndContests',
                type: 'get',
                success: function(data){
                    $('#endContest').datagrid({
                        dataSource: {cols : [
                                {name : 'contest_id',label : '#', width:0.1},
                                {name : 'title',label : '标题', sort: false, width: 0.3, html:true},
                                {name : 'user_id',label : '创建人',sort : false, width:0.1},
                                {name : 'start_time', label:'开始时间',sort:true,valueOperator : {
                                        getter : function(dataValue, cell, dataGrid) {
                                            const time = new Date(dataValue);
                                            return DateFormat(time);
                                        }}, width:0.15
                                },
                                {name : 'end_time', label:'结束',sort:true,valueOperator : {
                                        getter : function(dataValue, cell, dataGrid) {
                                            const time = new Date(dataValue);
                                            return DateFormat(time);
                                        }}, width:0.15
                                },
                                {name : 'status',label : '状态',sort : false, width:0.1,html:true},
                                {name : 'rg_count',label : '人数',sort : false, width:0.1},
                            ],
                            array: data["data"]
                        },
                        states: {
                            pager: {page: 1, recPerPage: Math.min(10,data["data"].length)},
                            sortBy: "contest_id",
                            order: "desc"
                        },
                        height : 'page',
                        sort:true,
                        showRowIndex : false,
                        rowIndexWidth: 0,
                        hoverRow: false,
                        hoverCol: false
                    });
                }
            })
        })
    </script>
</body>

</html>
