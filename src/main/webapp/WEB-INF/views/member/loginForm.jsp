<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<meta charset="utf-8">
</head>
<body>
	<div class="container mt-5 mb-5">

		<!-- <div class="h2 text-center"
			style="color: #050DA6; font-weight: 800; letter-spacing: 1.5px">Login</div> -->
			
		<div class="d-flex justify-content-center">
			<div class="h2 text-center col-2 p-1" style="background: #F2B705; color: #050DA6; font-weight: 800; letter-spacing: 1.5px">Login</div>
		</div>

		<div class="d-flex justify-content-center mt-5">
			<form action="/member/login" method="post" class="col-4">
				<input type="hidden" name="contentsno" value="${param.contentsno}">
				<input type="hidden" name="cateno" value="${param.cateno}">
				<input type="hidden" name="nowPage" value="${param.nowPage}">
				<input type="hidden" name="col" value="${param.col}"> 
				<input type="hidden" name="word" value="${param.word}">

				<div class="mt-4 mb-2">
					<input type="text" class="form-control " id="id" placeholder="아이디"
						name="id" required="required" value='${c_id_val}'>
				</div>
				<div class="mb-4">
					<input type="password" class="form-control" id="pwd"
						placeholder="비밀번호" name="passwd" required="required">
				</div>

				<div class="form-check mb-5">
					<label class="form-check-label"> 
						<c:choose>
							<c:when test="${c_id =='Y'}">
								<input class="form-check-input" type="checkbox" name="c_id"
									value="Y" checked="checked"> 로그인 상태 유지
          					</c:when>
							<c:otherwise>
								<input class="form-check-input" type="checkbox" name="c_id"
									value="Y"> 로그인 상태 유지
         					</c:otherwise>
						</c:choose>
					</label>
				</div>

				<div class="buttons p-3">
					<div class="row mb-2">
						<button type="submit" class="btn btn-danger fw-bold">로그인</button>
					</div>
					<div class="row">
						<div class="col">
						<a type="button" onclick="location.href='agree'">회원가입</a>
					</div>
					<div class="col-auto">
						<a href="#" style="text-decoration: none; color: black;">아이디 / 비밀번호 찾기</a>
					</div>
					</div>	
				</div>

			</form>
		</div>
	</div>

</body>
</html>