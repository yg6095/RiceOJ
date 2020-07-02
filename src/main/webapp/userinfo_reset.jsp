<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <c:import url="link.jsp"></c:import>
    <meta charset="UTF-8">
    <title>${sessionScope.User.user_id}</title>
    <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
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
                    <form class="form-horizontal" method="post" id="userInfoResetForm">
                        <h1 class="text-center">修改个人信息</h1>
                        <div style="height: 20px; width: 100%"></div>
                        <div class="form-group">
                            <label for="user_id" class="col-sm-3 required">用户名</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="text" class="form-control" disabled="disabled" name="user_id"
                                       id="user_id" placeholder="账号"
                                       value="${sessionScope.User.user_id}" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-3 required">原密码</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="password" class="form-control" name="oldpassword"
                                       id="oldpassword" placeholder="原密码" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-3">新密码</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="password" class="form-control" name="password"
                                       id="password" placeholder="密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="confirm_password" class="col-sm-3">确认密码</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="password" class="form-control" name="confirm_password"
                                       id="confirm_password" placeholder="确认密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="nick" class="col-sm-3">真实姓名</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="text" class="form-control" name="nick" id="nick"
                                       placeholder="真实姓名" value="${sessionScope.User.nick}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="school" class="col-sm-3">学校</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="text" class="form-control" name="school" id="school"
                                       placeholder="学校" value="${sessionScope.User.school}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email" class="col-sm-3 required">电子邮箱</label>
                            <div class="col-md-6 col-sm-10">
                                <input class="form-control" type="email" name="email" id="email"
                                       placeholder="电子邮箱" value="${sessionScope.User.email}" required>
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
                                <button type="button" class="btn btn-success" id="submitBtn">提交</button>
                            </div>
                        </div>
                    </form>
                    <style>
                        .error {
                            color: red;
                        }
                    </style>
                    <script>
                        var damo = $("#userInfoResetForm").validate({
                            rules: {
                                oldpassword: {
                                    required: true,
                                    minlength: 5
                                },
                                password: {
                                    minlength: 5
                                },
                                confirm_password: {
                                    equalTo: "#password"
                                },
                                email: {
                                    required: true,
                                    email: true
                                },
                            },
                            messages: {
                                oldpassword: {
                                    minlength: "长度大于5位"
                                },
                                password: {
                                    minlength: "长度大于5位"
                                },
                                confirm_password: {
                                    equalTo: "密码不一致"
                                },
                                email: "邮箱不正确",
                                code: {
                                    required: "验证码为空",
                                }
                            },
                            debug: true
                        },);
                        $("#submitBtn").click(function () {
                            if (damo.valid() == false) {
                                return false;
                            }
                            $.ajax({
                                url: "${ptx}/resetUserInfo",
                                data: $("#userInfoResetForm").serialize(),
                                type: "post",
                                success: function (data) {
                                    if (data["code"] == 0) {
                                        showSuccess({message: "修改成功"});
                                        window.location.href = "/index.jsp";
                                    } else {
                                        showError(data);
                                    }
                                }, error: function (data) {
                                    showError(data);
                                }
                            })


                        })

                        function countDown() {
                            $("#verify").addClass("on");
                            $("#verify").removeClass("load-indicator loading");
                            let time = 60;
                            $('#verify_bu').val(time + "秒");
                            var timer = setInterval(function () {
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

                        $("#verify_bu").click(function () {
                            var email = $("#email").val();
                            var URL = "${ptx}/sendVerify?email=" + email;
                            var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
                            if (email != "" && reg.test(email)) {
                                $("#verify").addClass("load-indicator loading");
                                $("#verify_bu").attr("disabled", true);
                                $.ajax({
                                    url: URL,
                                    type: "get",
                                    success: function (data) {
                                        if (data["code"] == 0) {
                                            showSuccess({message: "验证码已发送至您的邮箱,请注意查收"});
                                            countDown();
                                        } else {
                                            showError(data);
                                            countDown();
                                        }
                                    }, error: function (data) {
                                        showError(data);
                                        countDown();
                                    }
                                });
                            } else {
                                showError({message: "邮箱错误,请检查邮箱是否正确"})
                            }
                        });
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