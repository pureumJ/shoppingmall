<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>이미지 수정</title>
<meta charset="utf-8">
</head>
<body>

	<div class="container mt-3 mb-5">
		<div class="h2 mb-5 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">프로필 이미지
			수정</div>
		<div class="d-flex justify-content-center">
			<form action="/member/updateFile" method="post"
				enctype="multipart/form-data" class="col-10">
				<input type="hidden" name="oldfile" value="${param.fname}">
				<input type="hidden" name="id" value="${sessionScope.id}">
				<div class="row d-flex justify-content-center">
					<div class="col mb-3 mt-3 d-flex justify-content-center">
						<div class="col">
							<img src="/member/storage/${param.fname }" width="300px"
								height="300px">
						</div>
					</div>
					<div class="col mb-3 mt-3 d-flex align-items-center">
						<div class="row">
							<label for="filenameMF">* 변경할 파일 선택</label>
							<div class="col mb-2">
								<input type="file" class="form-control" id="filenameMF"
									name="fname" accept=".jpg,.png,.gif" required="required">
							</div>
						</div>
					</div>
				</div>
				<div class="row buttons d-flex justify-content-end">
					<button type="submit" class="col-auto btn btn-danger me-1">수정</button>
					<button type="button" class="col-auto btn btn-warning"
						onclick="history.back()">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>