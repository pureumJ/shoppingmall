<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/ELFunctions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function read(noticeno) {
		let url = "read";
		url += "?noticeno=" + noticeno;
		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";

		//alert(url);

		location.href = url;
	}
	
	function delN(noticeno, file) {
		if (confirm("상품을 삭제하시겠습니까?")) {
			let url = "../admin/notice/delete/" + noticeno + "/" + file;
			location.href = url;
		}
	}
</script>
</head>
<body>
	<div class="container mt-3 col-9">
	
		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">공지
			목록</div>
			
		<div class="d-flex justify-content-end mb-3">
			<form action="list">
				<div class="row mb-2">
					<div class="col">
						<select class="form-select" name="col">
							<option value="total" <c:if test="${col=='total'}">selected</c:if>>전체출력</option>
							<option value="title" <c:if test="${col=='title'}">selected</c:if>>제목</option>
							<option value="content"
								<c:if test="${col=='content'}">selected</c:if>>내용</option>
							<option value="title_content"
								<c:if test="${col=='title_content'}">selected</c:if>>제목+내용</option>
						</select>
					</div>
					<div class="col-5">
						<input type="search" class="form-control" name="word"
							required="required" value="${word}">
					</div>
					<div class="col-auto">
						<button type="submit" class="btn btn-danger">검색</button>
						<c:if test="${sessionScope.grade == 'A' }">
							<button type="button" class="btn btn-warning text-white"
							onclick="location.href='../admin/notice/create'">등록</button>
						</c:if>
					</div>
				</div>
			</form>
		</div>
		
		<table class="table">
			<thead class="table-warning">
				<tr class="text-center">
					<th>No.</th>
					<th>제목</th>
					<th>날짜</th>
					<th>조회수</th>
					<c:if test="${sessionScope.grade == 'A' }">
						<th>삭제</th>
					</c:if>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list}">
						<tr class="text-center">
							<td colspan="12">등록된 공지사항이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr class="text-center">
								<td>${status.count}</td>
								<td class="text-start"><a class="text-black" style="text-decoration: none;" href="javascript:read('${dto.noticeno }')">${dto.title}</a>
									<c:if test="${util:newImg(fn:substring(dto.rdate,0,10)) }">
										<img src="/images/new.gif">
									</c:if>
								</td>
								<td>${fn:substring(dto.rdate,0,10)}</td>
								<td>${dto.cnt}</td>
								<c:if test="${sessionScope.grade == 'A' }">
									<td><a href="javascript:delN(`${dto.noticeno }`, `${dto.file }`)"><i class="fa-solid fa-trash" style="color: #050DA6;"></i></a></td>
								</c:if>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		${paging}
	</div>
</body>
</html>