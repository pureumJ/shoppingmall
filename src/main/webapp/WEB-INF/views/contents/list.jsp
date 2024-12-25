<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/ELFunctions"%>


<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<script type="text/javascript">
	function read(contentsno) {
		var url = "${root}/contents/read";
		url += "?contentsno=" + contentsno;
		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";
		location.href = url;

	}

	function del(contentsno, filename) {
		if (confirm("상품을 삭제하시겠습니까?")) {
			let url = "${root}/admin/contents/delete/" + contentsno + "/" + filename;
			location.href = url;
		}
	}
</script>

</head>
<body>
	<div class="container mt-3 col-9">

		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">상품
			목록</div>

		<div class="d-flex justify-content-end mb-3">
			<form action="./list">
				<div class="row mb-3">
					<div class="col-4">
						<select class="form-control" name="col">
							<option value="total"
								<c:if test= "${col=='total'}"> selected </c:if>>전체출력</option>
							<option value="cateno"
								<c:if test= "${col=='cateno'}"> selected </c:if>>상품분류(접시:1,보울:2...)</option>
							<option value="pname"
								<c:if test= "${col=='pname'}"> selected </c:if>>상품명</option>
							<option value="price"
								<c:if test= "${col=='price'}"> selected </c:if>>가격</option>

						</select>
					</div>

					<div class="col-5">
						<input type="text" class="form-control" placeholder="검색어 입력"
							name="word" value="${word}">
					</div>
					<div class="col-3">
						<button type="submit" class="btn btn-danger">검색</button>
						<button type="button" class="btn btn-warning text-white"
						onclick="location.href='${root}/admin/contents/create'">등록</button>
					</div>
				</div>
			</form>
		</div>

		<table class="table">
			<thead class="table-warning">
				<tr class="text-center">
					<th>No.</th>
					<th>상품 이미지</th>
					<th>상품명</th>
					<th>가격</th>
					<th>등록 날짜</th>
					<th>재고</th>
					<th>수정 / 삭제 / 이미지 수정</th>
				</tr>
			</thead>
			<tbody class="text-center align-middle">

				<c:choose>
					<c:when test="${empty list}">
						<tr class="text-center">
							<td colspan="12">등록된 상품이 없습니다.</td>
					</c:when>
					<c:otherwise>

						<c:forEach var="dto" items="${list}">
							<tr>
								<td>${dto.contentsno}</td>
								<td>
									<img src="/contents/storage/${dto.filename}"
									 width="100px" height="100px">
								</td>
								<td class="text-start">
									<a href="javascript:read('${dto.contentsno}')" class="fw-bold" style="text-decoration: none; color: black;">${dto.pname}</a>
									<c:if test="${util:newImg(dto.rdate)}">
										<img src="/images/new.gif">
									</c:if>
								</td>
								<td>${dto.price}</td>
								<td>${dto.rdate}</td>
								<td>${dto.stock}</td>
								<td>
									<a href="./update/${dto.contentsno }"><i class="fa-solid fa-pen-to-square" style="color: #050DA6;"></i></a>&emsp;/&emsp;
									<a href="javascript:del(`${dto.contentsno }`,`${dto.filename }`)"><i class="fa-solid fa-trash" style="color: #050DA6;"></i></a>&emsp;/&emsp;
									<a href="./updateFile/${dto.contentsno }/${dto.filename}"><i class="fa-solid fa-image" style="color: #050DA6;"></i>
								</a></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		<div>${paging}</div>
	</div>
</body>
</html>
