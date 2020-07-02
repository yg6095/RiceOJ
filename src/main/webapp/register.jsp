<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ricky.Bean.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注册</title>
<c:import url="link.jsp"></c:import>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<style>
.error {
	color: red;
}
</style>

</head>
<body>

	<c:import url="header.jsp"></c:import>

	<div class="container-fixed">
		<form class="form-horizontal" method="post" id="signupForm">
			<div style="height: 20px; width: 100%"></div>
			<div class="form-group">
				<label for="user_id" class="col-sm-3 required">用户名</label>
				<div class="col-md-6 col-sm-10">
					<input type="text" class="form-control" name="user_id"
						id="user_id" placeholder="账号"
						value="${requestScope.User.user_id}" required>
				</div>
			</div>
			<div class="form-group">
				<label for="password" class="col-sm-3 required">密码</label>
				<div class="col-md-6 col-sm-10">
					<input type="password" class="form-control" name="password"
						id="password" placeholder="密码"
						value="${requestScope.User.password}" required>
				</div>
			</div>
			<div class="form-group">
				<label for="confirm_password" class="col-sm-3 required">确认密码</label>
				<div class="col-md-6 col-sm-10">
					<input type="password" class="form-control" name="confirm_password"
						id="confirm_password" placeholder="确认密码" required>
				</div>
			</div>
			<div class="form-group">
				<label for="nick" class="col-sm-3">真实姓名</label>
				<div class="col-md-6 col-sm-10">
					<input type="text" class="form-control" name="nick" id="nick"
						placeholder="真实姓名" value="${requestScope.User.nick}">
				</div>
			</div>
			<div class="form-group">
				<label for="school" class="col-sm-3">学校</label>
				<div class="col-md-6 col-sm-10">
					<input type="text" class="form-control" name="school" id="school"
						placeholder="学校" value="${requestScope.User.school}">
				</div>
			</div>

			<div class="form-group">
				<label for="email" class="col-sm-3 required">电子邮箱</label>
				<div class="col-md-6 col-sm-10">
					<input class="form-control" type="email" name="email" id="email"
						placeholder="电子邮箱" value="${requestScope.User.email}" required>
				</div>
			</div>
			<div class="form-group">
				<label for="code" class="col-sm-3 required">验证码</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="code" name="code"
						placeholder="验证码" required>
				</div>
				<div class="col-sm-3" id="verify">
					<input class="form-control" type="button" value="获取验证码" id="verify_bu">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-10">
					<button class="btn btn-success" id="regBtn">注册</button>
					<div class="info">
						已有账号？点击<a href="login.jsp">登陆</a>
					</div>
				</div>
			</div>

		</form>

	</div>
	<c:import url="footer.jsp"></c:import>
	<script>
		var demo = $("#signupForm").validate({
			rules: {
				user_id: {
					required: true,
					minlength: 2,
				},
				password: {
					required: true,
					minlength: 5
				},
				confirm_password: {
					required: true,
					equalTo: "#password"
				},
				email: {
					required: true,
					email: true
				},
			},
			messages: {
				user_id: {
					required: "请输入用户名",
					minlength: "长度大于2位",
				},
				password: {
					required: "请输入密码",
					minlength: "长度大于5位"
				},
				confirm_password: {
					required: "请确认密码",
					equalTo: "密码不一致"
				},
				email: "邮箱不正确",
				code:{
					required: "验证码为空",
					equalTo: "验证码错误或验证码已过期",
				}
			},
			debug: true
		});
		$("#regBtn").click(function () {
			if (demo.valid() == false) {
				return false;
			};
			$.ajax({
				url: "${ptx}/register",
				type: "post",
				data: $("#signupForm").serialize(),
				dataType: "json",
				success: function (data) {
					if(data["code"] != 0){
						showError(data);
					}else{
						window.location.href="login.jsp";
					}
				},error: function (data) {
					showError(data)
				}
			});
			return false;
		})

		function countDown(){
			$("#verify").addClass("on");
			$("#verify").removeClass("load-indicator loading");
			let time = 60;
			$('#verify_bu').val(time + "秒");
			var timer = setInterval(function() {
				if (time == 0) {
					clearInterval(timer);
					$("#verify_bu").attr("disabled", false);
					$("#verify_bu").val("获取验证码");
					$("#verify").removeClass("on");
				} else {
					time--;
					$('#verify_bu').val(time + "秒");
				}
			}, 1000);
		}
		$("#verify_bu").click(function() {
			var email = $("#email").val();
			var URL = "${ptx}/sendVerify?email=" + email;
			var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
			if (email != "" && reg.test(email)) {
				$("#verify").addClass("load-indicator loading");
				$("#verify_bu").attr("disabled", true);
				$.ajax({
					url : URL,
					type : "get",
					success : function(data) {
						if(data["code"] == 0){
							showSuccess({message:"验证码已发送至您的邮箱,请注意查收"})
							countDown();
						}else{
							showError(data);
							countDown();
						}
					},error:function(data){
						showError(data);
						countDown();
					}
				});
			}else{
				showError({message: "邮箱错误,请检查邮箱是否正确"})
			}
		});
	</script>
</body>
</html>