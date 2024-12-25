<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조회</title>
<script type="text/javascript">
	function updateFile() {
		var url = "${root}/admin/contents/updateFile/${dto.contentsno}/${dto.filename}";
		location.href = url;
	}
	function update() {
		var url = "${root}/admin/contents/update/${dto.contentsno}";
		location.href = url;
	}
	function del() {
		let url = "${root}/admin/contents/delete/${dto.contentsno}/${dto.filename}";
		if (confirm("상품을 삭제하시겠습니까?")) {
			location.href = url;
		}
	}
</script>
</head>
<body>
	<div class="container mt-3">
		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">상품
			조회</div>
			
		<!-- 테이블로 구현 -->
		<table class="table">
			<tr>
				<td rowspan="4" class="col-sm-2 text-center align-middle"><img
					src="/contents/storage/${dto.filename}"
					width="150px" height="150px"></td>
				<th class="col-sm-2 table-warning">상품명</th>
				<td class="col-sm-8">${dto.pname}</td>
			</tr>
			<tr>
				<th class="col-sm-2 table-warning">가격</th>
				<td class="col-sm-8">${dto.price}</td>
			</tr>
			<tr>
				<th class="col-sm-2 table-warning">재고</th>
				<td class="col-sm-8">${dto.stock}</td>
			</tr>
			<tr>
				<th class="col-sm-2 table-warning">등록일</th>
				<td class="col-sm-8">${dto.rdate}</td>
			</tr>
			<tr>
				<td colspan="3"><div style="height: 200px; overflow-y: scroll" >${dto.detail }</div></td>
			</tr>
		</table>
		
		<div class="buttons d-flex justify-content-end m-3">
			<button type="button" class="btn btn-danger me-1"
				onclick="location.href='/admin/contents/create'">등록</button>
			<button type="button" class="btn btn-warning text-white me-1" onclick="update()">수정</button>
			<button type="button" class="btn btn-success me-1" onclick="updateFile()">사진수정</button>
			<button type="button" class="btn btn-primary me-1" onclick="del()">삭제</button>
			<button type="button" class="btn btn-light"
				onclick="location.href='${root}/admin/contents/list'">목록</button>
		</div>
		
	</div>
</body>
</html>