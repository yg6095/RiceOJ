<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>评测状态</title>

	<c:import url="link.jsp"></c:import>

</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="container-fixed">
		<div id="SolutionList" class="datagrid  datagrid-striped">
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

		<!-- 代码对话框 -->

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
						<table class="table table-auto table-bordered">
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
						<div id="ceInfo"></div>
						<pre class="prettyprint" id="modal_code" ></pre>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	<c:import url="footer.jsp"></c:import>
	<script>

	$('#SolutionList').datagrid({
		dataSource : {
			cols : [
				{name : 'html_solution_id',label : '#', width: 0.1, html:true},
				{name : 'in_date',label : '提交时间',	sort : false,width:0.2
					,valueOperator : {
						getter : function(dataValue, cell, dataGrid) {
							var time = new Date(dataValue);
							return DateFormat(time);
						}
					}},
				{name : 'html_problem_id',label : '题号',checkbox : false,html:true,width:0.1},
				{name : 'user_id',label : '用户',sort : false,width:0.1},
				{name : 'html_language',label : '语言',sort : false,width:0.1},
				{name : 'html_status',label : '结果',sort : false, html:true,width:0.15},
				{name : 'html_score',label : '分数',sort : false, html:true,width:0.05},
				{name : 'html_time',label : '时间消耗',sort : false,width:0.1},
				{name : 'html_memory',label : '内存消耗',sort : false, width:0.1},
			],array:{}
		},
		sortable : true,
		selectable : false,
		checkable : true,
		showRowIndex : false,
		checkByClickRow: false,
		rowIndexWidth: 0,
		states : {
			pager : {
				page : 1,
				recPerPage : 50
			}
		},
		height : 'page',
		hoverCol:false,
		hoverRow: false,
	});
	function show(id) {
		const myDataGrid = $('#SolutionList').data('zui.datagrid');
		const ls = myDataGrid.getData();
		let ok = false;
		for(let i in ls){
			const sol = ls[i];
			if(sol["solution_id"] == id && ("${sessionScope.User.user_id}" == sol["user_id"] || "${sessionScope.User.rightstr eq 'administrator'}" == "true")){
				$("#modal_title").html("#" + sol["solution_id"]);
				$("#modal_date").html(DateFormat(new Date(sol["in_date"])));
				$("#modal_language").html(sol["html_language"]);
				$("#modal_length").html(sol["code_length"] + " bytes");
				$("#modal_status").html(sol["html_status"]);
				$("#modal_time").html(sol["html_time"]);
				$("#modal_memory").html(sol["html_memory"]);
				$("#modal_code").html(sol["source"]);
				$('#modal_sol').modal({
					keyboard : false,
					show     : true
				});
				ok = true;
				break;
			}
		}
		if(ok == false){
			showError({message:"您当前无法查看本次提交"});
		}
		$("#modal_code").removeClass("prettyprinted");
		prettifyLoad();
	}
	function getStatus(){
		$.ajax({
			url: '${ptx}/searchAllSolutions',
			type: 'get',
			success: function(data){
				const solutions = $('#SolutionList').data('zui.datagrid');
				solutions.setDataSource(data["data"]);
				$("#loading").css("display", "none");
				solutions.render();
			},error:function (data) {
				showError(data);
			}
		});
	}
	getStatus();
	setInterval(getStatus,3000);
</script>
</body>
</html>