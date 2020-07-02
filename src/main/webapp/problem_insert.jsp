<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>创建题目</title>
    <c:import url="link.jsp"></c:import>
</head>
<body>
<c:import url="header.jsp"></c:import>
<div class="container-fixed">
    <div class="row">
        <div class="col-xs-3">
            <nav class="menu" data-ride="menu" style="width: 200px">
                <c:import url="manager_menu.jsp"></c:import>
            </nav>
        </div>
        <div class="col-xs-9">
            <c:choose>
                <c:when test="${not empty sessionScope.User}">
                    <h1 class="text-center">题目创建</h1>
                    <br><br>

                    <form class="form-horizontal" method="post" id="problemFrom" enctype="multipart/form-data"
                          data-loading="正在上传...">
                        <div class="form-group">
                            <label for="title">标题</label>
                            <input type="text" class="form-control" id="title" name="title"
                                   value="${requestScope.Problem.title}">
                        </div>
                        <div class="form-group">
                            <label for="description">题目描述:</label>
                            <textarea id="description" name="description" class="form-control kindeditor"
                                      style="height:150px;"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="input">输入描述:</label>
                            <textarea id="input" name="input" class="form-control kindeditor"
                                      style="height:150px;"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="output">输出描述:</label>
                            <textarea id="output" name="output" class="form-control kindeditor"
                                      style="height:150px;"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="sample_input">样例输入:</label>
                            <textarea id="sample_input" name="sample_input" class="form-control kindeditor"
                                      style="height:150px;"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="sample_output">样例输出:</label>
                            <textarea id="sample_output" name="sample_output" class="form-control kindeditor"
                                      style="height:150px;"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="hint">hint:</label>
                            <textarea id="hint" name="hint" class="form-control kindeditor"
                                      style="height:150px;"></textarea>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <label for="time_limit">时间限制:</label>
                                <input type="text" class="form-control" id="time_limit" name="time_limit">
                                <label for="time_limit"
                                       class="input-control-label-right text-right text-danger">S</label>
                            </div>
                            <div class="input-group">
                                <label for="memory_limit">空间限制:</label>
                                <input type="text" class="form-control" id="memory_limit" name="memory_limit">
                                <label for="memory_limit"
                                       class="input-control-label-right text-right text-danger">MB</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="dataUploader">题目数据:<i
                                    class="text-danger text-right">(注：输入输出文件名请一一对应)</i></label>
                            <div id='dataUploader' name='dataUploader' class="uploader" data-ride="uploader">
                                <div class="uploader-message text-center">
                                    <div class="content"></div>
                                    <button type="button" class="close">×</button>
                                </div>
                                <div class="uploader-files file-list file-list-lg"
                                     data-drag-placeholder="请拖拽文件到此处"></div>
                                <div class="uploader-actions">
                                    <div class="uploader-status pull-right text-muted"></div>
                                    <button type="button" class="btn btn-link uploader-btn-browse"><i
                                            class="icon icon-plus"></i> 选择文件
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-success" id="upbtn">提交</button>
                        </div>
                    </form>
                    <script>
                        var title, description, input, output, sample_input, sample_output, time_limit, memory_limit,
                            hint;
                        $("#upbtn").click(function () {
                            title = $("#title").val();
                            description = $(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
                            input = $(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
                            output = $(document.getElementsByTagName("iframe")[2].contentWindow.document.body).html();
                            sample_input = $(document.getElementsByTagName("iframe")[3].contentWindow.document.body).html();
                            sample_output = $(document.getElementsByTagName("iframe")[4].contentWindow.document.body).html();
                            hint = $(document.getElementsByTagName("iframe")[5].contentWindow.document.body).html();
                            time_limit = $("#time_limit").val();
                            memory_limit = $("#memory_limit").val();
                            const uploader = $('#dataUploader').data('zui.uploader');
                            var errorMsg = "";
                            if (title == "") errorMsg = "标题";
                            else if (description == "") errorMsg = "题目描述";
                            else if (input == "") errorMsg = "输入描述";
                            else if (output == "") errorMsg = "输出描述";
                            else if (sample_input == "") errorMsg = "样例输入";
                            else if (sample_output == "") errorMsg = "样例输出";
                            else if (time_limit == "") errorMsg = "时间限制";
                            else if (memory_limit == "") errorMsg = "空间限制";
                            if (errorMsg != "") {
                                new $.zui.Messager('请检查' + errorMsg + '是否已经填写！', {
                                    type: 'danger' // 定义颜色主题
                                }).show();
                                uploader.stop();
                                return false;
                            }
                            const file = uploader.getFiles();
                            var cnt = 0;
                            for (var i = 0; i < file.length; i++) {
                                cnt += (file[i].ext == "in");
                            }

                            if (file.length % 2 && cnt != file.length / 2) {
                                new $.zui.Messager('请检查文件个数以及in文件和out文件是否匹配', {
                                    type: 'danger' // 定义颜色主题
                                }).show();
                                uploader.stop();
                                return false;
                            }
                            const formdata = new FormData();
                            formdata.append("title", title);
                            formdata.append("description", description);
                            formdata.append("input", input);
                            formdata.append("output", output);
                            formdata.append("sample_input", sample_input);
                            formdata.append("sample_output", sample_output);
                            formdata.append("time_limit", time_limit);
                            formdata.append("memory_limit", memory_limit);
                            formdata.append("hint", hint);
                            for (var i = 0; i < file.length; i++) {
                                formdata.append("file", file[i].getNative());
                            }
                            $("#problemFrom").toggleClass("load-indicator loading");
                            $.ajax({
                                url: "${ptx}/insertProblem",
                                type: "post",
                                data: formdata,
                                processData: false,
                                contentType: false,
                                success: function (data) {
                                    $("#problemFrom").toggleClass("load-indicator loading");
                                    if (data["code"] != 0) {
                                        showError(data);
                                    } else {
                                        window.location.href = "${ptx}/problem_manager.jsp"
                                    }
                                },
                                error: function (data) {
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
                        var options = {
                            url: "${ptx}/insertProblem",
                            filters: {
                                mime_types: [
                                    {title: '输入', extensions: 'in'},
                                    {title: '输出', extensions: 'out'}
                                ],
                                // 不允许上传重复文件
                                prevent_duplicates: true,
                            },
                        };
                        $('#dataUploader').uploader(options);
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
