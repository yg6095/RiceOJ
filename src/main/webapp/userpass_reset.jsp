<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>修改密码</title>
    <c:import url="link.jsp"></c:import>
</head>
<script>
    $.validator.setDefaults({
        submitHandler: function() {
            form.submit();
        }
    });
    $().ready(function() {
        $("#resetPassForm").validate({
            rules: {
                password: {
                    required: true,
                    minlength: 5
                },
                confirm_password: {
                    required: true,
                    equalTo: "#password"
                },
            },
            messages: {
                password: {
                    required: "请输入密码",
                    minlength: "长度大于5位"
                },
                confirm_password: {
                    required: "请确认密码",
                    equalTo: "密码不一致"
                }
            }
        },);
    });
</script>
<body>
    <c:import url="header.jsp"></c:import>
    <div class="container-fixed">
        <div style="height:20px;width:100%"></div>
        <c:choose>
            <c:when test="${not empty sessionScope.resetUser}">
                <form class="form-horizontal" id="resetPassForm" action="${ptx}/resetPassword" method="post">
                    <div class="form-group">
                        <label for="password" class="col-sm-3 required">重置密码</label>
                        <div class="col-md-6 col-sm-10">
                            <input type="password" class="form-control" name="password"
                                   id="password" placeholder="密码" required>
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
                        <div class="col-sm-offset-3 col-sm-10">
                            <button class="btn btn-success">提交</button>
                        </div>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <h1 class="text-center">邮箱验证未通过</h1>
            </c:otherwise>
        </c:choose>
    </div>
    <c:import url="footer.jsp"></c:import>
</body>
</html>
