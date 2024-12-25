<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조회</title>
<script type="text/javascript">
	function updateN() {
		var url = "../admin/notice/update/${dto.noticeno}";
		location.href = url;
	}
	function delN() {
		let url = "${root}/admin/notice/delete/${dto.noticeno}/${dto.file}"
		if (confirm("상품을 삭제하시겠습니까?")) {
			location.href = url;
		}
	}
	function listN() {
		var url = "list";
		url += "?nowPage=${param.nowPage}";
		url += "&col=${param.col}";
		url += "&word=${param.word}";
		location.href = url;
	}
</script>
</head>
<body>
	<div class="container mt-3 mb-5 col-9">
		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">공지사항
			조회</div>

		<ul class="list-group">
			<li class="list-group-item list-group-item-warning fs-5 fw-bold">${dto.title}</li>
			<li class="list-group-item" style="height: 400px; overflow-y: scroll">${dto.content}</li>
			<li class="list-group-item">첨부파일 : ${dto.file }</li>
			<li class="list-group-item">조회수 : ${dto.cnt}</li>
			<li class="list-group-item">등록일 : ${dto.rdate}</li>
		</ul>


		<div class="buttons d-flex justify-content-end mt-3 mb-3">
			<c:if test="${sessionScope.grade == 'A' }">
				<button type="button" class="btn btn-danger me-1"
					onclick="location.href='/admin/notice/create'">등록</button>
				<button type="button" class="btn btn-warning text-white me-1"
					onclick="updateN()">수정</button>
				<button type="button" class="btn btn-primary me-1" onclick="delN()">삭제</button>
			</c:if>
			<button type="button" class="btn btn-light"
				onclick="location.href='./list'">목록</button>
		</div>



	</div>
</body>
</html>