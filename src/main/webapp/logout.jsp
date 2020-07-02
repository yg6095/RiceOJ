<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%session.invalidate();%>
	<script>
		var last_url = document.referrer;
		var url = last_url.split('/');
		url = url.pop();
		 if(url == "")
		 	document.location.href = "index.jsp";
		 else document.location.href=url;
	</script>
</body>
</html>