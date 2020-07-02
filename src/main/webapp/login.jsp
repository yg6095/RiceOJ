<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.ricky.Bean.*"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录</title>
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
    <div style="height:20px;width:100%"></div>
    <form class="form-horizontal" id="loginForm">
        <div class="form-group">
            <label for="user_id" class="col-sm-3 required">账号</label>
            <div class="col-md-6 col-sm-10">
                <input type="text" class="form-control" name="user_id" id="user_id"
                       placeholder="用户名" value="${requestScope.user_id}" required>
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-sm-3 required">密码</label>
            <div class="col-md-6 col-sm-10">
                <input type="password" class="form-control"
                       name="password" id="password" placeholder="密码" required>
            </div>
        </div>
        <div class="form-group">
            <label for="code" class="col-sm-3 required">验证码</label>
            <div class="col-sm-3">
                <input type="text" class="form-control" id="code" name="code" placeholder="验证码">
            </div>
            <canvas class="col-md-1 col-sm-2" id="canvas" onclick="dj()" width="100" height="42"
                    style="border: 1px solid #ccc; border-radius: 5px;"></canvas>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-10">
                <button class="btn btn-success" id="loginBtn">登录</button>
                <a data-toggle="modal" data-target="#emailVerify">忘记密码</a>
                <div class="info">没有账号？点击<a href="register.jsp">注册账号</a></div>
            </div>
        </div>
    </form>
    <script>
        jQuery.validator.addMethod("Equal", function (value, element, param) {
            var code = $(param).val();
            if (value.toLowerCase() == code) return true;
            else return false;
        }, "验证码错误");
        jQuery.validator.addMethod("Empty", function (value, element, param) {
            if(param == true){
                if(value.length == 0) return false;
                else return true;
            }
        }, "请输入");
        var demo = $("#loginForm").validate({
            rules: {
                user_id: {
                    required: true,
                    minlength: 2,
                },
                password: {
                    required: true,
                    minlength: 5
                },
                code: {
                    required: true,
                    Equal: "#code1"
                }
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
                code: {
                    required: "验证码为空",
                }
            }, debug: true
        });
        $("#loginBtn").click(function () {
            if (demo.valid() == false) {
                return false;
            }
            if($("#code").val() == ""){
                showError({message:"请输入验证码"});
                return false;
            }
            $.ajax({
                url: "${ptx}/login",
                data: $("#loginForm").serialize(),
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data["code"] != 0) {
                        showError(data);
                        dj();
                    } else {
                        const last_url = document.referrer;
                        const url = last_url.split('/');
                        const last_page = url.pop();
                        if (last_page != "login.jsp" && last_page != "register.jsp" &&
                            last_page != "userpass_reset.jsp" && last_page != "logout.jsp" && last_page != "") {
                            window.location.href = "" + last_page;
                        } else {
                            window.location.href = "index.jsp";
                        }
                    }
                }, error: function (data) {
                    showError(data);
                }
            });
            return false;
        })
    </script>
    <div class="modal fade" id="emailVerify">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                            class="sr-only">关闭</span></button>
                    <h4 class="modal-title">邮箱验证</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="resetForm">
                        <div class="form-group">
                            <label for="resetUser_id" class="col-sm-3 required">用户名</label>
                            <div class="col-md-6 col-sm-10">
                                <input type="text" class="form-control" name="resetUser_id"
                                       id="resetUser_id" placeholder="账号" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="resetEmail" class="col-sm-3 required">电子邮箱</label>
                            <div class="col-md-6 col-sm-10">
                                <input class="form-control" type="email" name="resetEmail" id="resetEmail"
                                       placeholder="电子邮箱" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="code" class="col-sm-3 required">验证码</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="verifyCode" name="verifyCode"
                                       placeholder="验证码" required>
                                <input type="hidden" id="code1" name="code1">
                            </div>
                            <div class="col-sm-3" id="verify">
                                <input class="form-control" type="button" value="获取验证码" id="verify_bu">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="resetBtn">提交</button>
                </div>
                <script>
                    $("#resetBtn").click(function () {
                        if ($("#verifyCode").val() == "") {
                            showError({message: "验证码不能为空"});
                            return false;
                        }
                        $.ajax({
                            url: "${ptx}/verifyCode",
                            data: $("#resetForm").serialize(),
                            success: function (data) {
                                if (data["code"] == 0) {
                                    window.location.href = "userpass_reset.jsp"
                                } else {
                                    showError(data)
                                }
                            }, error: function (data) {
                                showError(data)
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
                        const email = $("#resetEmail").val();
                        const user_id = $("#resetUser_id").val();
                        if (user_id == "") {
                            showError({message: "用户名不能为空"});
                            return false;
                        }
                        if (email == null) {
                            showError({message: "邮箱不能为空"});
                            return false;
                        }
                        const reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
                        if (reg.test(email)) {
                            $("#verify").addClass("load-indicator loading");
                            $("#verify_bu").attr("disabled", true);
                            $.ajax({
                                url: "${ptx}/sendResetVerify",
                                type: "post",
                                data: $("#resetForm").serialize(),
                                success: function (data) {
                                    if (data["code"] == 0) {
                                        showSuccess({message: "验证码已发送至您的邮箱,请注意查收"})
                                        countDown();
                                    } else {
                                        showError(data)
                                        countDown();
                                    }
                                }, error: function (data) {
                                    showError(data)
                                    countDown();
                                }
                            });
                        } else {
                            showError({message: "邮箱错误,请检查邮箱是否正确"})
                        }
                    });
                </script>
            </div>
        </div>
    </div>
</div>
<c:import url="footer.jsp"></c:import>
<script>
    var show_num = [];
    draw(show_num);

    function dj() {
        draw(show_num);
    }

    function draw(show_num) {
        var canvas_width = 100;
        var canvas_height = 42;
        var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
        var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
        canvas.width = canvas_width;
        canvas.height = canvas_height;
        var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m";
        var aCode = sCode.split(",");
        var aLength = aCode.length;//获取到数组的长度

        for (var i = 0; i <= 3; i++) {
            var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
            var deg = Math.random() * 30 * Math.PI / 180;//产生0~30
            var txt = aCode[j];//得到随机的一个内容
            show_num[i] = txt;
            var x = 10 + i * 20;//文字在canvas上的x坐标
            var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
            context.font = "bold 23px 微软雅黑";

            context.translate(x, y);
            context.rotate(deg);

            context.fillStyle = randomColor();
            context.fillText(txt, 0, 0);

            context.rotate(-deg);
            context.translate(-x, -y);
        }
        for (var i = 0; i <= 5; i++) { //验证码上显示线条
            context.strokeStyle = randomColor();
            context.beginPath();
            context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.stroke();
        }
        for (var i = 0; i <= 30; i++) { //验证码上显示小点
            context.strokeStyle = randomColor();
            context.beginPath();
            var x = Math.random() * canvas_width;
            var y = Math.random() * canvas_height;
            context.moveTo(x, y);
            context.lineTo(x + 1, y + 1);
            context.stroke();
        }
        $("#code1").val(show_num.join("").toLowerCase());
    }

    function randomColor() {//得到随机的颜色值
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        return "rgb(" + r + "," + g + "," + b + ")";
    }
</script>
</body>
</html>