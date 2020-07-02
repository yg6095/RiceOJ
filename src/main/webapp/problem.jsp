<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ricky.Bean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>${requestScope.Problem.problem_id}</title>

<c:import url="link.jsp"></c:import>
</head>
<body>
	<c:import url="header.jsp"></c:import>
	<div class="container-fixed">
		<c:choose>
			<c:when test="${requestScope.Problem.defunct == 78}">
				<article class="article">
					<header>
						<h1 class="text-center">${requestScope.Problem.problem_id }:
								${requestScope.Problem.title }</h1>
						<!-- 文章属性列表 -->
						<dl class="dl-inline" style="text-align: center">
							<dt>时间限制:</dt>
							<dd>${requestScope.Problem.time_limit*2000}/${requestScope.Problem.time_limit*1000} MS (Java/Others)</dd>
							<dt>内存限制:</dt>
							<dd>${requestScope.Problem.memory_limit * 2 * 1024}/${requestScope.Problem.memory_limit * 1024 } KB (Java/Others)</dd>
						</dl>
					</header>
					<!-- 文章正文部分 -->
					<section class="content">
						<div class="items">
							<div class="item">
								<div class="item-heading">
									<h4>问题描述：</h4>
								</div>
								<div class="item-content">${requestScope.Problem.description}</div>
							</div>
						</div>
						<div class="items">
							<div class="item">
								<div class="item-heading">
									<h4>输入描述：</h4>
								</div>
								<div class="item-content">${requestScope.Problem.input}</div>
							</div>
						</div>
						<div class="items">
							<div class="item">
								<div class="item-heading">
									<h4>输出描述：</h4>
								</div>
								<div class="item-content">${requestScope.Problem.output}</div>
							</div>
						</div>
						<div class="items">
							<div class="item">
								<div class="item-heading">
									<h4>样例输入：</h4>
								</div>

								<div class="item-content">
									<pre class="pre-scrollable">${requestScope.Problem.sample_input}</pre>
								</div>
							</div>
						</div>
						<div class="items">
							<div class="item">
								<div class="item-heading">
									<h4>样例输出：</h4>
								</div>
								<div class="item-content">
									<pre class="pre-scrollable">${requestScope.Problem.sample_output}</pre>
								</div>
							</div>
						</div>
						<c:if test="${not problem.hint eq ''}">
							<div class="items">
								<div class="item">
									<div class="item-heading">
										<h4>hint：</h4>
									</div>
									<div class="item-content">${requestScope.Problem.hint}</div>
								</div>
							</div>
						</c:if>
						<div class="items">
							<div class="item">
								<div class="item-heading">
									<h4>来源：</h4>
								</div>
								<div class="item-content">${requestScope.Problem.source}</div>
							</div>
						</div>

					</section>
					<!-- 文章底部 -->
					<footer style="text-align: center">
						<button class="btn btn-success" data-position="200px" data-toggle="modal" data-target="#submitModal">提交</button>
					</footer>
				</article>
			</c:when>
			<c:otherwise>
				<h1 class="text-center">您目前无法查看此题</h1>
			</c:otherwise>
		</c:choose>
		<div class="modal fade " id="submitModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
						<h4 class="modal-title">提交</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="problemSubmitForm">
							<div class="form-group">
								<label class="col-sm-2">题号</label>
								<div class="col-sm-10">
									<p class="form-control-static">${requestScope.Problem.problem_id}</p>
									<input type="hidden" name="problem_id" value="${requestScope.Problem.problem_id}">
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
									<button type="button" class="btn btn-default" id="problemSubmitBtn">提交</button>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
					</div>
				</div>
			</div>
			<script>
				$("#problemSubmitBtn").click(function () {
					if(${empty sessionScope.User}){
						$('#submitModal').modal('hide', 'fit')
						showError({'message':"用户尚未登录，请登录后提交"});
						return false;
					}
					$.ajax({
						url:"${ptx}/submit",
						type:"post",
						data:$("#problemSubmitForm").serialize(),
						success: function(date){
							const code = date["code"];
							if(code == 0){
								$('#submitModal').modal('hide', 'fit');
								window.location.href="status.jsp";
							}else{
								showError(date)
							}
						},error: function(date){
							showError(date);
						}
					})
					return false;
				})
			</script>
		</div>
	</div>
	<c:import url="footer.jsp"></c:import>
</body>

</html>