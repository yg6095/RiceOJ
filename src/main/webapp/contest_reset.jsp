<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>比赛修改</title>
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
                <c:when test="${not empty sessionScope.User and (sessionScope.User.user_id eq requestScope.Contest.user_id || sessionScope.User.rightstr eq 'administrator')}">
                    <h1 class="text-center">比赛创建</h1>
                    <form class="form-horizontal" method="post" id="contestFrom">

                        <div class="form-group">
                            <label for="title">比赛标题:</label>
                            <input type="text" class="form-control" id="title" name="title"
                                   value="${requestScope.Contest.title}">
                        </div>
                        <div class="form-group">
                            <label for="description">比赛描述:</label>
                            <textarea id="description" name="description" class="form-control kindeditor"
                                      style="height:150px;">${requestScope.Contest.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="_private">比赛类型:</label>
                            <div class="radio" id="_private">
                                <label>
                                    <input type="radio" name="_private" value="1">私有比赛(私人链接)<br>
                                    <input type="radio" name="_private" value="0">公开比赛
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password">比赛密码:<span>(非必须)</span></label>
                            <input type="text" class="form-control" name="password" id="password"
                                   value="${requestScope.Contest.password}"/>
                        </div>
                        <div class="form-group">
                            <label for="start_time">开始时间:</label>
                            <input type="text" class="form-datetime" id="start_time" placeholder="yyyy-MM-dd hh:mm">
                        </div>
                        <div class="form-group">
                            <label for="end_time">结束时间:</label>
                            <input type="text" class="form-datetime" id="end_time" placeholder="yyyy-MM-dd hh:mm">
                        </div>
                        <div class="form-group">
                            <label for="end_time">比赛题单:</label>
                            <div class="input-group text-center">
                                <table class="table table-fixed" id="problemSet">
                                    <thead>
                                    <tr>
                                        <th width="10%"><a id="addBtn" onclick="add('','')"><i
                                                class="icon icon-plus"></i></a></th>
                                        <th width="10%">#</th>
                                        <th width="10%">题号</th>
                                        <th width="40%">标题</th>
                                        <th width="30%">状态</th>
                                    </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                            <script>
                                let cnt = 0;
                                function add(problem_id, title) {
                                    cnt++;
                                    const del = "<a onclick='remove(this)'><i class='icon icon-times text-danger'></i></a>"
                                    const rows = $("#problemSet tr").size();
                                    const probNum = "<input type='search' id='search' class='form-control search-input probNum' placeholder='题号' value='" + problem_id + "'>"
                                    const probTitle = "<input type='text' class='form-control probTitle' placeholder='标题' value='" + title + "'>";
                                    const probNumber = "<span>" + String.fromCharCode((65 + cnt - 1)) + "</span>";
                                    const str = "<tr><td>" + del + "</td><td>" + probNumber + "</td><td>" + probNum + "</td><td>" + probTitle + "</td><td><a onclick='check(this)'>检查<i class='status'></i></a><span></span></td></tr>";
                                    $("#problemSet").append(str);
                                }

                                function remove(obj) {
                                    if (!confirm("是否确认删除")) {
                                        return;
                                    }
                                    cnt--;
                                    $(obj).parents("tr").remove();
                                    for (let i = 1; i <= cnt; i++) {
                                        $("#problemSet tr:eq(" + i + ") td:nth-child(2)").find("span").html(String.fromCharCode((65 + i - 1)))
                                    }
                                }
                                $(function () {
                                    const selects = document.getElementsByName("_private");
                                    for (let i = 0; i < selects.length; i++) {
                                        if (selects[i].value == "${requestScope.Contest._private}") {
                                            selects[i].checked = true;
                                            break;
                                        }
                                    }
                                    $("#start_time").val(DateFormat2(new Date(${requestScope.Contest.start_time.getTime()})));
                                    $("#end_time").val(DateFormat2(new Date(${requestScope.Contest.end_time.getTime()})))
                                    <c:forEach items="${requestScope.Contest.problem_ids}" var="problem">
                                    add("${problem.problem_id}", "${problem.title}")
                                    </c:forEach>
                                })

                                function check(obj) {
                                    const row = $(obj).parents("tr").index() + 1;
                                    const probNum = $("#problemSet tr:eq(" + row + ") td:nth-child(3)").find("input").val();
                                    $.ajax({
                                        url: "${ptx}/getProblemTitleById?problem_id=" + probNum,
                                        type: "get",
                                        success: function (data) {
                                            if (data["code"] != 0) {
                                                $("#problemSet tr:eq(" + row + ") td:nth-child(5)").find("i").removeClass("text-success icon-remove icon-check");
                                                $("#problemSet tr:eq(" + row + ") td:nth-child(5)").find("span").html("");
                                                $("#problemSet tr:eq(" + row + ") td:nth-child(5)").find("i").addClass("icon icon-remove text-danger");
                                                showError(data);
                                            } else {
                                                $("#problemSet tr:eq(" + row + ") td:nth-child(5)").find("i").removeClass("text-danger icon-remove icon-check")
                                                $("#problemSet tr:eq(" + row + ") td:nth-child(5)").find("i").addClass("icon icon-check text-success");
                                                $("#problemSet tr:eq(" + row + ") td:nth-child(5)").find("span").html(data["data"][0]);
                                            }
                                        }, error: function (data) {
                                            showError(data);
                                        }
                                    })
                                }
                            </script>
                        </div>

                        <div class="form-group text-center">
                            <button type="button" class="btn btn-success" id="createBtn">创建</button>
                        </div>
                    </form>
                    <script>
                        $("#createBtn").click(function () {
                            if (${empty sessionScope.User}) {
                                showError({message: "用户尚未登录"});
                                return false;
                            }
                            const problems = [];
                            const titles = [];
                            const titles1 = [];
                            $("#problemSet tbody tr td:nth-child(3)").each(function () {
                                problems.push($(this).children().val());
                            });
                            $("#problemSet tbody tr td:nth-child(4)").each(function () {
                                titles.push($(this).children().val());
                            });
                            $("#problemSet tbody tr td:nth-child(5)").each(function () {
                                titles1.push($(this).children("span").html());
                            });
                            for (let i = 0; i < titles.length; i++) {
                                if (titles[i] == "") {
                                    titles[i] = String.fromCharCode((65 + i));
                                }
                                if (titles1[i] == "") {
                                    showError({message: "请确认题目是否都已检查且都在题库中"});
                                    return false;
                                }
                            }
                            const data = {
                                title: $("#title").val(),
                                description: $(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html(),
                                _private: $('#_private input[name="_private"]:checked ').val(),
                                password: $("#password").val(),
                                start_time: $("#start_time").val(),
                                end_time: $("#end_time").val(),
                                problemids: problems,
                                titles: titles,
                                contest_id: ${requestScope.Contest.contest_id}
                            }
                            console.log(data);
                            if (data["title"] == "") {
                                showError({message: "请检查比赛标题是否填写"});
                                return false;
                            }
                            if (data["description"] == "") {
                                showError({message: "请检查比赛描述是否填写"});
                                return false;
                            }
                            if (data["_private"] == null) {
                                showError({message: "请检查比赛性质是否选择"});
                                return false;
                            }
                            if (data["start_time"] == "") {
                                showError({message: "请检查比赛开始时间是否选择"});
                                return false;
                            }
                            if (data["end_time"] == "") {
                                showError({message: "请检查比赛结束时间是否选择"});
                                return false;
                            }
                            if (data[["problemids"]].length == 0) {
                                showError({message: "请检查比赛题目是否添加"});
                                return false;
                            }
                            if (data[["problemids"]].length > 26) {
                                showError({message: "比赛不允许添加超过26道题"});
                                return false;
                            }
                            $.ajax({
                                url: "${ptx}/resetContest",
                                type: "POST",
                                data: JSON.stringify(data),
                                contentType: 'application/json',
                                success: function (data) {
                                    if (data["code"] != 0) {
                                        showError(data);
                                    } else {
                                        window.location.href = "${ptx}/contest_manager.jsp";
                                    }
                                }, error: function (data) {
                                    showError(data);
                                }
                            })
                        })
                        $(".form-datetime").datetimepicker({
                            weekStart: 1,
                            todayBtn: 1,
                            autoclose: 1,
                            todayHighlight: 1,
                            startView: 2,
                            forceParse: 0,
                            showMeridian: 1,
                            format: "yyyy-mm-dd hh:ii"
                        });
                        KindEditor.create('textarea.kindeditor', {
                            basePath: 'https://cdn.bootcss.com/zui/1.9.1/lib/kindeditor/',
                            bodyClass: 'article-content',
                            cssPath: 'https://cdn.bootcss.com/zui/1.9.1/css/zui.css', // 确保编辑器内的内容也应用 ZUI 排版样式
                            resizeType: 1,
                            allowPreviewEmoticons: false,
                            allowImageUpload: false,
                            items: [
                                'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                                'insertunorderedlist', '|', 'emoticons', 'image', 'link'
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
                            <h1 class="text-center">您尚未获得管理员权限</h1>
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
