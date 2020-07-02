<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="link.jsp"></c:import>
    <title>排名</title>
</head>

<body>
    <c:import url="header.jsp"></c:import>
    <div class="container-fixed text-center">
        <h1>用户排行榜（此榜单根据用户通过数以及通过率排名）</h1>
        <div id="ranklist" class="datagrid .datagrid-borderless"></div>
    </div>
    <script>
        $(function(){
            $.ajax({
                url: '${ptx}/searchAllRankUser',
                type: 'get',
                success: function(data){
                    $('#ranklist').datagrid({
                        dataSource: {cols : [
                                {name : 'rank',label : '排名'},
                                {name : 'user_id',label : '用户名', sort: false, checkbox : false},
                                {name : 'submit',label : '提交数',sort : false},
                                {name : 'solve',label : '通过数',sort : false},
                                {name : 'solved',label : '解决数',sort : false},
                                {name : 'pass_rate',label : '通过率',valueOperator : {
                                        getter : function(dataValue, cell, dataGrid) {
                                            let pass = dataValue * 100;
                                            pass = pass.toFixed(1);
                                            console.log(pass);
                                            return pass + "%";
                                        }
                                    }},
                            ],
                            array: data["data"]
                        },
                        borderWidth:0,
                        states: {
                            pager: {
                                pager: 1,
                                recPerPage:Math.min(50, data["data"].length)
                            }
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
    <c:import url="footer.jsp"></c:import>
</body>
</html>
