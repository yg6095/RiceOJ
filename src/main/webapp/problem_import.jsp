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
            <c:choose>
                <c:when test="${not empty sessionScope.User and sessionScope.User.rightstr eq 'administrator'}">
                    <h1 class="text-center">通过xml导入</h1>
                    <br><br>

                    <div id='importUploader' class="uploader" data-ride="uploader">
                        <div class="uploader-message text-center">
                            <div class="content"></div>
                            <button type="button" class="close">×</button>
                        </div>
                        <div class="uploader-files file-list file-list-lg" data-drag-placeholder="请拖拽文件到此处"></div>
                        <div class="uploader-actions">
                            <div class="uploader-status pull-right text-muted"></div>
                            <button type="button" class="btn btn-link uploader-btn-browse"><i
                                    class="icon icon-plus"></i> 选择文件
                            </button>
                            <button type="button" class="btn btn-link uploader-btn-start"><i
                                    class="icon icon-cloud-upload"></i> 开始导入
                            </button>
                        </div>
                    </div>
                    <h4>导入信息：</h4>
                    <div class="cards" id="importMessage">
                    </div>


                    <script>
                        var options = {
                            url: "${ptx}/importProblem",
                            filters: {
                                mime_types: [
                                    {title: 'xml', extensions: 'xml'},
                                ],
                                max_file_size: '80mb',
                                // 不允许上传重复文件
                                prevent_duplicates: true,
                            },
                            chunk_size: 0,
                            responseHandler: function (responseObject, file) {
                                const data = JSON.parse(responseObject["response"]);
                                if(data["code"] != 0){
                                    return data["message"];
                                }else{
                                    for(let i = 0; i < data["data"].length; i++){
                                        $("#importMessage").append("<div class='col-md-4 col-sm-6 col-lg-3'>"+data["data"][i]+"</div>")
                                    }
                                }
                            }
                        };
                        $('#importUploader').uploader(options);
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
