<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/ckeditor/ckeditor.js">
	
</script>
<script type="text/JavaScript">
	$(function() {
		CKEDITOR.replace('content'); // <TEXTAREA>태그 id 값
	});

	function checkf(f) {
		if (f.title.value == "") {
			alert("제목을 입력하세요");
			f.pname.focus()
			return false;
		}
		if (CKEDITOR.instances['content'].getData() == '') {
			window.alert('내용을 입력해 주세요.');
			CKEDITOR.instances['content'].focus();
			return false;
		}
	}
</script>
</head>
<body>
	<div class="container mt-3 mb-3 col-9">
		<div class="h2 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">공지사항
			수정</div>
		<div class="d-flex justify-content-center">
			<form action="/notice/update" method="post"
				enctype="multipart/form-data" onsubmit="return checkf(this)">
				
				<input type="hidden" name='noticeno' value="${noticeno }">
				
				<div class="mb-3 mt-3">
					<input type="text" class="form-control" id="title"
						value="${dto.title }" name="title">
				</div>
				<div class="mb-3 mt-3">
					<div class="col">
						<textarea rows="12" cols="7" id="content" name="content"
							class="form-control">${dto.content }</textarea>
					</div>
				</div>
				<div class="mb-3 mt-3">
					<div class="col">
						<input type="file" name="fnameMF" id="fnameMF"
							class="form-control">
					</div>
				</div>
				<div class="buttons d-flex justify-content-end">
					<button type="submit" class="btn btn-danger">등록</button>
					<input type="reset" value="초기화"
						class="ms-1 btn btn-warning text-white"></input>
					<button type="button" class="ms-1 col-auto btn btn-primary"
						onclick="history.back()">취소</button>
				</div>
			</form>
		</div>

	</div>
</body>
</html>