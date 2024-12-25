<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ckeditor/ckeditor.js">
	
</script>
<script type="text/JavaScript">
	$(function() {
		CKEDITOR.replace('detail'); // <TEXTAREA>태그 id 값
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
	
	window.onload=function(){
        getCategory()
              .then(data => {  
                 console.log(data);
             for (let i = 0; i < data.length; i++) {
                $('#category')
                .append("<option value='"+(i+1)+"'<c:if test='${cateno=="+(i+1)+"}'>selected</c:if>>"+data[i].catename+"</option>");
             }      
              }).catch(console.log);
  }; 
</script>
</head>
<body>
	<div class="container mt-3 mb-2">
		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">상품
			등록</div>

		<div class="d-flex justify-content-center">
			<form class="col-10" action="/contents/create" method="post"
				enctype="multipart/form-data" onsubmit="return checkIn(this)">

				<div class="row">
					<div class="col-2">
						<select class="form-select" name="cateno" id="category">
							<option selected>상품분류</option>
						</select>
					</div>
					<div class="col-5">
						<input type="text" name="pname" id="pname" class="form-control"
							placeholder="상품명 입력">
					</div>
					<div class="col">
						<input type="text" name="price" id="price" class="form-control"
							placeholder="상품 가격 입력">
					</div>
					<div class="col-2">
						<input type="number" name="stock" id="stock" class="form-control"
							min="1" placeholder="상품 수량">
					</div>
				</div>

				<div class="mb-3 mt-3">
					<div class="col-sm-12">
						<textarea rows="12" cols="7" id="detail" name="detail"
							class="form-control"></textarea>
					</div>
				</div>

				<div class="mb-3 mt-3">
					<div class="col">
						<input type="file" name="filenameMF" id="filenameMF"
							class="form-control">
					</div>
				</div>

				<div class="buttons mb-3 d-flex justify-content-end">
					<button class="btn btn-danger">등록</button>
					<input type="reset" value="초기화" class="ms-1 btn btn-warning text-white"></input>
					<button type="button" class="ms-1 col-auto btn btn-primary"
							onclick="history.back()">취소</button>
				</div>
			</form>
		</div>

	</div>
</body>
</html>