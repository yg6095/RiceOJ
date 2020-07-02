<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%
	pageContext.setAttribute("ptx",request.getContextPath());
%>
<div class="header">

	<div class="container-fixed">
		<hr>
		<h1 style="text-align: center">Welcome to Rice Online Judge</h1>
		<hr>
		<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<!-- 导航头部 -->
				<div class="navbar-header">
					<!-- 品牌名称或logo -->
					<a class="navbar-brand" href="index.jsp">RiceOJ</a>
				</div>
				<!-- 导航项目 -->
				<div class="collapse navbar-collapse navbar-collapse-example" id="pageContent">
					<!-- 一般导航项目 -->
					<ul class="nav navbar-nav nav-pills">
						<li class="" id="nav_index"><a href="problems.jsp">题库</a></li>
						<li class="" id="nav_contest"><a href="contests.jsp">比赛</a></li>
						<li class="" id="nav_status"><a href="status.jsp">评测状态</a></li>
						<li class="" id=nav_ranklist><a href="ranklist.jsp">排名</a></li>
					</ul>
					<!-- 右侧的导航项目 -->
					<ul class="nav navbar-nav nav-pills navbar-right">
						<c:choose>
							<c:when test="${not empty sessionScope.User and empty sessionScope.login 
								and empty sessionScope.register}">
								<li class="dropdown active"><a href="#"
									class="dropdown-toggle" data-toggle="dropdown" id="login_id">${sessionScope.User.user_id}<b
										class="caret"></b></a>
									<ul class="dropdown-menu" role="menu">
										<li><a href="userinfo_reset.jsp">修改个人信息</a></li>
										<li><a href="manager.jsp">管理</a></li>
										<li><a href="logout.jsp">注销</a></li>
									</ul></li>
							</c:when>
							<c:otherwise>
								<li class="" id="nav_login"><a href="login.jsp">登录</a></li>
								<li class="" id="nav_register"><a href="register.jsp">注册</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<!-- END .navbar-collapse -->
			</div>
		</nav>
		<hr>
	</div>

	<script>
	function DateFormat(date) {
		const y = date.getFullYear();
		let m = date.getMonth() + 1;
		m = m < 10 ? ("0" + m) : m;
		let d = date.getDate();
		d = d < 10 ? ("0" + d) : d;
		let h = date.getHours();
		h = h < 10 ? ("0" + h) : h;
		let minute = date.getMinutes();
		minute = minute < 10 ? ("0" + minute) : minute;
		let second= date.getSeconds();
		second = second < 10 ? ("0" + second) : second;
		return y + '-' + m + '-' + d+' '+h+':'+minute+':'+ second;
	};
	function DateFormat2(date) {
		const y = date.getFullYear();
		let m = date.getMonth() + 1;
		m = m < 10 ? ("0" + m) : m;
		let d = date.getDate();
		d = d < 10 ? ("0" + d) : d;
		let h = date.getHours();
		h = h < 10 ? ("0" + h) : h;
		let minute = date.getMinutes();
		minute = minute < 10 ? ("0" + minute) : minute;
		return y + '-' + m + '-' + d+' '+h+':'+minute;
	};
	function showError(data){
		new $.zui.Messager(data["message"], {
			type: 'danger',
			time:2000
		}).show();
	}
	function showSuccess(data){
		new $.zui.Messager(data["message"], {
			type: 'success',
			time:2000
		}).show();
	}
	$('#pageContent').on('click', '.navbar-nav > li > a', function() {
		var $item = $(this).parent('li');
		$item.parent().children('.active').removeClass('active');
		$item.addClass('active')
	});
	</script>
</div>