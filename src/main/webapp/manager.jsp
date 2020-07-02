<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理</title>
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
            <h1 class="text-center">OJ管理</h1>
            <br><br>

            <article class="article">
                <header>
                    <h2 class="text-center">管理说明</h2>
                    <section class="abstract">
                        <p><strong>摘要：</strong>拥有管理员权限的用户可以管理Online Judge所有信息，没有管理员权限的用户只能管理自己创建的比赛和题目。</p>
                    </section>
                </header>
                <section class="content">
                    <h3>管理组织结构图：</h3>
                    <div id="managerTreemap"></div>
                    <h3>详细说明：</h3>
                    <div class="items">
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="userinfo_reset.jsp">修改个人信息</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">用户修改个人信息（密码、邮箱等）</div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="problem_manager.jsp">题目列表</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">
                                    <p>对Online Judge的题库进行管理
                                    <p>主要功能：</p>
                                    <p><span class="text-danger">隐藏</span>：将一个或多个题目从公共题库中删除</p>
                                    <p><span class="text-success">公开</span>：将一个或多个题目加入公共题库中</p>
                                    <p><span class="text-info">删除</span>：删除一个或多个题目</p>
                                    <p><span class="text-warning">修改</span>：修改题目的题面</p>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="problem_insert.jsp">题目创建</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">用户创建题目</div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="problem_import.jsp">题目导入</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">
                                    <p>管理员可以通过XML导入题目</p>
                                    <p class="text-danger">注：文件不能超过80M</p>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="user_manager.jsp">用户权限列表</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">
                                    <p>管理员可以进行权限管理</p>
                                    <p>1、为指定用户添加权限</p>
                                    <p>2、删除指定用户权限</p>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="contest_manager.jsp">比赛列表</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">
                                    <p>对Online Judge的比赛进行管理
                                    <p>主要功能：</p>
                                    <p><span class="text-info">删除</span>：删除一个或多个比赛</p>
                                    <p><span class="text-warning">修改</span>：修改比赛的相关设置</p>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="item-heading">
                                <h4><a href="contest_create.jsp">比赛创建</a></h4>
                            </div>
                            <div class="item-content">
                                <div class="media pull-left"></div>
                                <div class="text">用户创建比赛</div>
                            </div>
                        </div>
                    </div>
                </section>
            </article>

            <script>
                $('#managerTreemap').treemap({
                    data: {
                        text: '管理',
                        children: [{
                            text: '修改个人信息'
                        }, {
                            text: '题目管理',
                            children: [{
                                text: '题目列表'
                            }, {
                                text: '题目创建'
                            }, {
                                text: '题目导入'
                            }]
                        }, {
                            text: '用户管理',
                            children: ['用户权限列表']
                        }, {
                            text: '比赛管理',
                            children: ['比赛列表', '比赛创建']
                        },]
                    }
                });
            </script>
        </div>
    </div>
</div>
<c:import url="footer.jsp"></c:import>
</body>
</html>
