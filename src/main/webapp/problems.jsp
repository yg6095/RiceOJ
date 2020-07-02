<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>题库</title>
    <c:import url="link.jsp"></c:import>
</head>
<body>
    <c:import url="header.jsp"></c:import>
    <div class="container-fixed">
        <div id="ProblemList" class="datagrid  datagrid-striped">
            <div class="input-control search-box search-box-circle has-icon-left has-icon-right"
                 id="searchboxExample2" style="margin-bottom: 10px; max-width: 300px">
                <input id="inputSearchExample2" type="search"
                       class="form-control search-input" placeholder="搜索"> <label
                    for="inputSearchExample2"
                    class="input-control-icon-left search-icon"><i
                    class="icon icon-search"></i></label> <a href="#"
                    class="input-control-icon-right search-clear-btn"><i
                    class="icon icon-remove"></i></a>
            </div>
            <div id="loading" data-loading="正在获取数据..." class="load-indicator loading" style="width: 100%; height: 100%"></div>
            <div class="datagrid-container text-center"></div>
            <div class="pager"></div>
        </div>
    </div>
    <c:import url="footer.jsp"></c:import>
    <script>
        function problemSetUpdate(data){
            $('#ProblemList').datagrid({
                dataSource : {
                    cols : [
                        {name : 'user_status',label : '', sort : false,checkbox : false, width:0.08,html: true},
                        {name : 'problem_id',label : '题号',checkbox : false, width:0.1},
                        {name : 'title',label : '标题',sort : false, width:0.2},
                        {name : 'source',label : '类型',sort : false, width:0.38},
                        {name : 'provider',label : '提供者',sort : false, width:0.1},
                        {name : 'accepted',label : '通过数', width:0.07},
                        {name : 'submit',label : '提交数', width:0.07},
                    ],
                    array:data["data"]
                },
                sortable : true,
                selectable : false,
                checkable : true,
                showRowIndex : false,
                rowIndexWidth: 0,
                hoverCol:false,
                states : {
                    pager : {
                        page : 1,
                        recPerPage : Math.min(50, data["data"].length)
                    }
                },
                height : 'page',
                onSelectRow : function(rowId, checked, selections) {
                    const a = this.getCell(rowId, 2).value;
                    window.location.href = "${ptx}/problem?problem_id=" + a;
                }
            });
        }

        $(function(){
            $.ajax({
                url: '${ptx}/searchAllPublicProblems',
                type: 'get',
                dataType: 'json',
                success: function(data){
                    $("#loading").css("display", "none");
                    problemSetUpdate(data)
                },error: function(data){
                    alert("error");
                }
            })
        })
    </script>

</body>
</html>
