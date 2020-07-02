<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>
<nav class="menu" data-ride="menu" style="width: 200px">
    <ul id="treeMenu" class="tree tree-menu" data-ride="tree" data-idx="0">
        <li data-idx="1" data-id="1" class="open in"><a href="manager.jsp"><i class="icon icon-th"></i>管理首页</a></li>
        <li data-idx="2" data-id="2" class="open in"><a href="userinfo_reset.jsp"><i class="icon icon-user"></i>修改个人资料</a></li>
        <li data-idx="3" data-id="3" class="has-list"><i class="list-toggle icon"></i>
            <a href="#"><i class="icon icon-time"></i>题目管理</a>
            <ul data-idx="3">
                <li data-idx="1" data-id="3-1" class=""><a href="problem_manager.jsp">题目-列表</a></li>
                <li data-idx="2" data-id="3-2" class="open in"><a href="problem_import.jsp">题目-导入</a></li>
                <li data-idx="3" data-id="3-3" class="open in"><a href="problem_insert.jsp">题目-创建</a></li>
            </ul>
        </li>
        <li data-idx="4" data-id="4" class="has-list"><i class="list-toggle icon"></i>
            <a href="#"><i class="icon icon-time"></i>用户管理</a>
            <ul data-idx="4">
                <li data-idx="1" data-id="4-1" class=""><a href="user_manager.jsp">用户-权限-列表</a></li>
            </ul>
        </li>
        <li data-idx="5" data-id="5" class="has-list"><i class="list-toggle icon"></i>
            <a href="#"><i class="icon icon-time"></i>比赛管理</a>
            <ul data-idx="5">
                <li data-idx="1" data-id="5-1" class=""><a href="contest_manager.jsp">比赛-列表</a></li>
                <li data-idx="2" data-id="5-2" class=""><a href="contest_create.jsp">比赛-创建</a></li>
            </ul>
        </li>
    </ul>
</nav>
</body>
</html>
