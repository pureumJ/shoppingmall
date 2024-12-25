<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="/ELFunctions"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<script type="text/javascript">
	function deleteM() {
		var url = "${root}/member/delete";
		url += "?id=${dto.id}";
		url += "&oldfile=${dto.fname}";
		if (confirm("탈퇴 처리 하시겠습니까?")) {
			location.href = url;
		}
	}
	function updateM() {
		var url = "/member/update";
		url += "?id=${dto.id}";

		location.href = url;
	}
</script>
</head>
<body>
	<div class="container mt-3 col-9">
		<div class="h3 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">
			${dto.mname}</div>
		<div class="d-flex justify-content-center">
			<c:choose>
				<c:when test="${dto.grade=='A'}">
					<div class="col-1 fw-bold text-center"
						style="color: #fff; background: #F2B705;">[관리자]</div>
				</c:when>
				<c:otherwise>
					<div class="col-1 fw-bold text-center"
						style="color: #fff; background: #F2B705">[일반회원]</div>
				</c:otherwise>
			</c:choose>
		</div>
		<table class="table">
			<tr>
				<td colspan="2" style="text-align: center"><img
					src="/member/storage/${dto.fname}" width="200px" height="200px"
					class="rounded-circle mb-3"></td>
			</tr>
			<tr>
				<th class="table-warning">아이디</th>
				<td>${dto.id}</td>
			</tr>
			<tr>
				<th class="table-warning">전화번호</th>
				<td>${dto.tel}</td>
			</tr>
			<tr>
				<th class="table-warning">이메일</th>
				<td>${dto.email}</td>
			</tr>
			<tr>
				<th class="table-warning">우편번호</th>
				<td>${dto.zipcode}</td>
			</tr>
			<tr>
				<th class="table-warning">주소</th>
				<td>${dto.address1}${dto.address2}</td>
			</tr>
			<tr>
				<th class="table-warning">직업</th>
				<td>직업코드:${dto.job}(${util:jobname(dto.job)})</td>
			</tr>
			<tr>
				<th class="table-warning">날짜</th>
				<td>${dto.mdate}</td>
			</tr>

		</table>


		<div style="text-align: center">
			<button class="btn btn-danger" onclick="updateM()">회원수정</button>
			<button class="btn btn-warning text-white" onclick="deleteM()">회원탈퇴</button>
			<button class="btn btn-primary"
				onclick="location.href='/admin/member/list'">회원목록</button>

		</div>

		<br>

	</div>
</body>
</html>