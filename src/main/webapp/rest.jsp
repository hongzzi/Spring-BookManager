<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Rest Service</h1>
	<ul id="list">
	</ul>
</body>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function list() {
		$.ajax({
			url:"/rest/book",
			type:"get",
			success:function(resTxt) {
				if(resTxt.status) {
					$("#list").empty();
					let data = resTxt.data;
					$(data).each(function(idx, item) {
						$("#list").append("<li>"+item.isbn);
					})
				} else {
					alert("조회 오류");
				}
				console.log(resTxt);
			},
			error : function(xhr) {
				alert("조회 오류");
				console.log(xhr);
			}
		})
	}
	list();
</script>
</html>