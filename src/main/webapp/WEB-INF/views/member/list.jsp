<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<meta charset="utf-8">
<script type="text/javascript">
	function read(id) {
		var url = "${root}/admin/member/read";
		url += "?id=" + id;

		location.href = url;
	}
</script>
</head>
<body>
	<div class="container mt-3 col-9">
		<div class= "h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">회원목록</div>
		
		<form method="post" action="list">
			<div class="row d-flex justify-content-end">
				<div class="col-3">
					<select class="form-select" name="col">
						<option value="mname"
							<c:if test="${col=='mname' }">selected</c:if>>성명</option>
						<option value="id" <c:if test="${col=='id' }">selected</c:if>>아이디</option>
						<option value="email"
							<c:if test="${col=='email' }">selected</c:if>>이메일</option>
						<option value="total"
							<c:if test="${col=='total' }">selected</c:if>>전체출력</option>
					</select>
				</div>
				<div class="col-4">
					<input type="text" class="form-control" name="word"
						required="required" value="${word}">
				</div>
				<div class="col-auto">
					<button class="btn btn-danger">검색</button>
				</div>
			</div>
		</form>

		<br>

		<c:forEach var="dto" items="${list}">
			<table class="table">
				<tr>
					<td rowspan="5" class="col-sm-2"><img
						src="${root}/member/storage/${dto.fname}" class="rounded-circle"
						width="200px" height="200px"></td>
					<th class="col-sm-2 table-warning">아이디</th>
					<td class="col-sm-8"><a href="javascript:read('${dto.id}')" class="text-decoration-none text-black fw-bold">${dto.id}</a></td>
				</tr>
				<tr>
					<th class="col-sm-2 table-warning">성명</th>
					<td class="col-sm-8">${dto.mname}</td>
				</tr>
				<tr>
					<th class="col-sm-2 table-warning">전화번호</th>
					<td class="col-sm-8">${dto.tel}</td>
				</tr>
				<tr>
					<th class="col-sm-2 table-warning">이메일</th>
					<td class="col-sm-8">${dto.email}</td>
				</tr>
				<tr>
					<th class="col-sm-2 table-warning">주소</th>
					<td class="col-sm-8">(${dto.zipcode}) ${dto.address1}
						${dto.address2}</td>
				</tr>
			</table>
		</c:forEach>
		${paging}

	</div>
</body>
</html>