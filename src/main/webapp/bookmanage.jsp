<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>도서 관리</h2>
	<button id="search_list">목록조회</button>
	(상세 내용을 조회하기 위해서 목록의 아이템을 클릭하세요)
	<br>
	<ul id="list"></ul>
	<button id="add">추가</button>
	<button id="modify">수정</button>
	<button id="delete">삭제</button>
	<br>
	<br>
	<div class="div_body">
		<span width="30px">ISBN</span> <input type="text" id="isbn"> <br>
		<span width="30px">제 목</span> <input type="text" id="title"> <br>
		<span width="30px">저 자</span> <input type="text" id="author">
		<br> <span width="30px">출판사</span> <input type="number"
			id="price"> <br> <span width="30px">가격</span> <input
			type="text" id="publisher"> <br>
		<textarea rows="3" cols="200" id="desciption"></textarea>
	</div>

	<div id="result"></div>

</body>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	function list() {
		$.ajax({
			url : "/rest/book",
			type : "get",
			success : function(resTxt) {
				if (resTxt.status) {
					$("#list").empty();
					let data = resTxt.data;
					$(data).each(function(idx, item) {
						$("#list").append("<li class='detail'>" + item.isbn);
					})
					$("#result").text("전체 조회 성공");
				} else {
					alert("조회오류");
					$("#result").text("전체 조회 실패");
				}
			},
			error : function(xhr) {
				alert("조회 오류");
				$("#result").text("전체 조회 실패");
				console.log(xhr);
			}
		});
	}

	list();

	$("#search_list").on("click", function() {
		list();
	})

	$("ul").on("click", ".detail", function() {
		console.log(this, $(this).text());
		$.ajax({
			url : "http://localhost:8080/rest/book/" + $(this).text(),
			type : "get",
			success : function(resTxt) {
				//console.log(resTxt);

				if (resTxt.status) {
					$("#isbn").val(resTxt.data.isbn);
					$("#title").val(resTxt.data.title);
					$("#author").val(resTxt.data.author);
					$("#publisher").val(resTxt.data.publisher);
					$("#price").val(resTxt.data.price);
					$("#desciption").val(resTxt.data.desciption);
					$("#result").text("정보 조회 성공");
				} else {
					$("#result").text("정보 조회 실패");
				}
			},
			error : function() {
				alert("목록 조회 실패");
				console.log(error);
			}
		})
	});

	$("#add").click(function(){
		let obj = {
				isbn:$("#isbn").val(),
				title:$("#title").val(),
				author:$("#author").val(),
				publisher:$("#publisher").val(),
				price:$("#price").val(),
				description:$("#description").val(),
				authorno:1
		};
		$.ajax({
			url:"http://localhost:8080/rest/book",
			type:"post",
			data:JSON.stringify(obj),
			contentType:"application/json",
			success:function(resTxt) {
				let data = resTxt.data;
				list();
				$("#result").text(data+"개 저장 성공")
			},
			error:function(error) {
				$("#result").text("저장 실패"+error.responseJSON.data);
				console.log(error);
			}
		})
	});
	
	$("#modify").click(function(){
		let obj = {
				isbn:$("#isbn").val(),
				title:$("#title").val(),
				author:$("#author").val(),
				publisher:$("#publisher").val(),
				price:$("#price").val(),
				description:$("#description").val()
		};
		$.ajax({
			url:"http://localhost:8080/rest/book",
			type:"put",
			data:JSON.stringify(obj),
			contentType:"application/json",
			success:function(resTxt) {
				let data = resTxt.data;
				list();
				$("#result").text(data+"개 수정 성공")
			},
			error:function(error) {
				$("#result").text("수정 실패"+error.responseJSON.data);
				console.log(error);
			}
		})
	});
	
	$("#delete").click(function(){
		$.ajax({
			url:"http://localhost:8080/rest/book/"+$('#isbn').val(),
			type:"delete",
			success:function(resTxt) {
				let data = resTxt.data;
				list();
				$("#result").text(data+"개 수정 성공")
			},
			error:function(error) {
				$("#result").text("삭제 실패"+error.responseJSON.data);
				console.log(error);
			}
		})
	});
	
</script>
</html>