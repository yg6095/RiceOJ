<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>题目修改</title>
    <c:import url="link.jsp"></c:import>
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
                <c:when test="${not empty sessionScope.User and (sessionScope.User.rightstr eq 'administrator' || sessionScope.User.user_id eq requestScope.Problem.user_id)}">
                    <h1 class="text-center">题面修改</h1>
                    <br><br>
                    <form class="form-horizontal" method="post" id="problemFrom" enctype="multipart/form-data"
                          data-loading="正在上传...">
                        <input type="hidden" name="problem_id" id="problem_id"
                               value="${requestScope.Problem.problem_id}">
                        <div class="form-group">
                            <label for="title">标题</label>
                            <input type="text" class="form-control" id="title" name="title"
                                   value="${requestScope.Problem.title}">
                        </div>
                        <div class="form-group">
                            <label for="description">题目描述:</label>
                            <textarea id="description" name="description" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Problem.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="input">输入描述:</label>
                            <textarea id="input" name="input" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Problem.input}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="output">输出描述:</label>
                            <textarea id="output" name="output" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Problem.output}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="sample_input">样例输入:</label>
                            <textarea id="sample_input" name="sample_input" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Problem.sample_input}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="sample_output">样例输出:</label>
                            <textarea id="sample_output" name="sample_output" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Problem.sample_output}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="hint">hint:</label>
                            <textarea id="hint" name="hint" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Problem.hint}</textarea>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <label for="time_limit">时间限制:</label>
                                <input type="text" class="form-control" id="time_limit" name="time_limit"
                                       value="${requestScope.Problem.time_limit}">
                                <label for="time_limit"
                                       class="input-control-label-right text-right text-danger">S</label>
                            </div>
                            <div class="input-group">
                                <label for="memory_limit">空间限制:</label>
                                <input type="text" class="form-control" id="memory_limit" name="memory_limit"
                                       value="${requestScope.Problem.memory_limit}">
                                <label for="memory_limit"
                                       class="input-control-label-right text-right text-danger">MB</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-success" id="upbtn">提交</button>
                        </div>
                    </form>
                    <script>
                        let title, description, input, output, sample_input, sample_output, time_limit, memory_limit,
                            hint, problem_id;
                        $("#upbtn").click(function () {
                            problem_id = $("#problem_id").val();
                            title = $("#title").val();
                            description = $(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
                            input = $(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
                            output = $(document.getElementsByTagName("iframe")[2].contentWindow.document.body).html();
                            sample_input = $(document.getElementsByTagName("iframe")[3].contentWindow.document.body).html();
                            sample_output = $(document.getElementsByTagName("iframe")[4].contentWindow.document.body).html();
                            hint = $(document.getElementsByTagName("iframe")[5].contentWindow.document.body).html();
                            time_limit = $("#time_limit").val();
                            memory_limit = $("#memory_limit").val();
                            let errorMsg = "";
                            if (title == "") errorMsg = "标题";
                            else if (description == "") errorMsg = "题目描述";
                            else if (input == "") errorMsg = "输入描述";
                            else if (output == "") errorMsg = "输出描述";
                            else if (sample_input == "") errorMsg = "样例输入";
                            else if (sample_output == "") errorMsg = "样例输出";
                            else if (time_limit == "") errorMsg = "时间限制";
                            else if (memory_limit == "") errorMsg = "空间限制";
                            if (errorMsg != "") {
                                showError({message: '请检查' + errorMsg + '是否已经填写！'});
                                return false;
                            }
                            const formdata = new FormData();
                            formdata.append("problem_id", problem_id)
                            formdata.append("title", title);
                            formdata.append("description", description);
                            formdata.append("input", input);
                            formdata.append("output", output);
                            formdata.append("sample_input", sample_input);
                            formdata.append("sample_output", sample_output);
                            formdata.append("time_limit", time_limit);
                            formdata.append("memory_limit", memory_limit);
                            formdata.append("hint", hint);
                            $("#problemFrom").toggleClass("load-indicator loading");
                            $.ajax({
                                url: "${ptx}/resetProblem",
                                type: "post",
                                data: formdata,
                                processData: false,
                                contentType: false,
                                success: function (data) {
                                    $("#problemFrom").toggleClass("load-indicator loading");
                                    if (data["code"] != 0) {
                                        showError(data)
                                    } else {
                                        window.location.href = "${ptx}/problem_manager.jsp"
                                    }
                                },
                                error: function (data) {
                                    $("#problemFrom").toggleClass("load-indicator loading");
                                    showError(data)
                                }
                            })
                        });
                        KindEditor.create('textarea.kindeditor', {
                            basePath: 'https://cdn.bootcss.com/zui/1.9.1/lib/kindeditor/',
                            bodyClass: 'article-content',
                            cssPath: 'https://cdn.bootcss.com/zui/1.9.1/css/zui.css', // 确保编辑器内的内容也应用 ZUI 排版样式
                            resizeType: 1,
                            allowPreviewEmoticons: false,
                            allowImageUpload: false,
                            items: [
                                'source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                                'insertunorderedlist', '|', 'emoticons', 'link'
                            ]
                        });
                    </script>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${empty sessionScope.User}">
                            <h1 class="text-center">请登录后再进行操作</h1>
                        </c:when>
                        <c:otherwise>
                            <h1 class="text-center">您尚未获得权限</h1>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<c:import url="footer.jsp"></c:import>
</body>
</html>
