<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta charset="utf-8">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<script type="text/JavaScript">
	$(function() {
		CKEDITOR.replace('detail');
	});

	function checkIn(f) {
		if (f.pname.value == "") {
			alert("상품명을 입력하세요");
			f.pname.focus()
			return false;
		}
		if (f.price.value == "") {
			alert("가격을 입력하세요");
			f.price.focus();
			return false;
		}
		if (CKEDITOR.instances['detail'].getData() == '') {
			window.alert('내용을 입력해 주세요.');
			CKEDITOR.instances['detail'].focus();
			return false;
		}
		if (f.stock.value == "") {
			alert("재고를 입력하세요");
			f.stock.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<div class="container mt-3">
		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">상품
			정보 수정</div>

		<div class="d-flex justify-content-center">
			<form class="col-10" action="/contents/update" method="post"
				onsubmit="return checkIn(this)">

				<input type="hidden" name="contentsno" value="${contentsno}">

				<div class="row">
					<div class="col-2">
						<select class="form-control" name="cateno">
							<option value="1"
								<c:if test= "${dto.cateno==1}"> selected </c:if>>접시</option>
							<option value="2"
								<c:if test= "${dto.cateno==2}"> selected </c:if>>보울</option>
							<option value="3"
								<c:if test= "${dto.cateno==3}"> selected </c:if>>컵</option>
							<option value="4"
								<c:if test= "${dto.cateno==3}"> selected </c:if>>인테리어</option>
							<option value="5"
								<c:if test= "${dto.cateno==3}"> selected </c:if>>커틀러리</option>
						</select>
					</div>
					<div class="col-5">
						<input type="text" name="pname" id="pname" class="form-control"
							value="${dto.pname }">
					</div>
					<div class="col">
						<input type="text" name="price" id="price" class="form-control"
							value="${dto.price }">
					</div>
					<div class="col-2">
						<input type="text" name="stock" id="stock" class="form-control"
							value="${dto.stock }">
					</div>
				</div>

				<div class="mb-3 mt-3">
					<div class="col-sm-12">
						<textarea rows="10" cols="7" id="detail" name="detail"
							class="form-control">${dto.detail }</textarea>
					</div>
				</div>
				<div class="buttons mb-3 d-flex justify-content-end">
					<button class="btn btn-danger">수정</button>
					<button type="reset" class="ms-2 btn btn-warning text-white">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
