<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }" />
<c:choose>
	<c:when
		test="${not empty sessionScope.id && sessionScope.grade == 'A'}">
		<c:set var="str">관리자</c:set>
	</c:when>
	<c:when
		test="${not empty sessionScope.id && sessionScope.grade != 'A'}">
		<c:set var="str">${sessionScope.mname }</c:set>
	</c:when>
</c:choose>

<!DOCTYPE html>
<html lang="en">
<head>
<title>shopping</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src="https://kit.fontawesome.com/9b25eb70fb.js"
	crossorigin="anonymous"></script>

<style type="text/css">
#grade {
	color: gray;
}

#yellow {
	color: #F2B705;
}

#logo {
	letter-spacing: 1.5px;
}
</style>
<script type="text/javascript">
    function getCategory(){
        return fetch("/contents/getCategory")
                        .then(response => response.json());
    }
    window.onload=function(){
          getCategory()
                .then(data => {  
                   console.log(data);
               for (let i = 0; i < data.length; i++) {
                  $('#pmenu').append("<li><a  class='nav-item' href='/contents/mainlist/"+data[i].cateno+"'>" + data[i].catename + "</a></li>");
               }                  
                        
                }).catch(console.log);
    }; 
</script>

</head>
<body>
	<nav class="navbar navbar-expand-lg bg-white">
		<div class="col-9 container ps-5 pe-5">

			<a class="navbar-brand fs-2" id="logo"
				style="color: #F20707; font-weight: 800;" href="/">PUREUM</a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="collapsibleNavbar">

				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a href="/" class="nav-link m-2 "
						id="yellow">홈</a></li>
					<li class="nav-item"><a href="${root}/contents/mainlist"
						class="nav-link m-2 " id="yellow">쇼핑하기</a></li>
					<li class="nav-item dropdown m-2"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" id="yellow">COMMUNITY</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="${root}/contents/detail">Review</a></li>
							<li><a class="dropdown-item" href="${root}/notice/list">Notice</a></li>
							<li><a class="dropdown-item" href="#">Q&A</a></li>
						</ul></li>
				</ul>

				<ul class="navbar-nav">
					<c:choose>
						<c:when
							test="${not empty sessionScope.id && sessionScope.grade == 'A'}">
							<li class="nav-item"><a href="${root}/admin/contents/create"
								class="nav-link m-2 "> 상품등록</a></li>
							<li class="nav-item"><a href="${root}/admin/contents/list"
								class="nav-link m-2 "> 상품목록</a></li>
							<li class="nav-item"><a href="${root}/admin/contents/list"
								class="nav-link m-2 "> 주문목록</a></li>
							<li class="nav-item"><a href="${root}/admin/member/list"
								class="nav-link m-2 "> 회원목록</a></li>
							<li class="nav-item"><a href="${root}/member/logout"
								class="nav-link m-2 "> Logout</a></li>

						</c:when>
						<c:when test="${empty sessionScope.id }">

							<li class="nav-item"><a href="${root}/member/login"
								class="nav-link m-2 "><i
									class="fa-solid fa-arrow-right-to-bracket"></i> Login</a></li>
							<li class="nav-item"><a href="${root}/member/agree"
								class="nav-link m-2"><i class="fa-solid fa-user-plus"></i>
									Sign Up</a></li>
						</c:when>
						<c:otherwise>

							<li class="nav-item dropdown m-2"><a
								class="nav-link dropdown-toggle" id="grade" href="#"
								role="button" data-bs-toggle="dropdown">${str}</a>

								<ul class="dropdown-menu dropdown-menu-lg-end"
									style="width: 290px;">

									<li class="nav-item"><a
										href="${root}/member/update/${sessionScope.id}"
										class="nav-link text-end me-3">edit</a></li>

									<li class="nav-item">
										<div class="profile-info d-flex justify-content-center">

											<a
												href="${root}/member/updateFile?fname=${sessionScope.fname}">

												<img src="/member/storage/${sessionScope.fname}"
												class="rounded-circle" width="80px" height="80px">

											</a>
										</div>
										<p class="text-center mt-3">${str}님,좋은하루되세요.</p>
									</li>

									<li><hr class="dropdown-divider"></li>

									<li class="nav-item d-flex"><a
										class="dropdown-item text-center" href="${root}/member/mypage">마이페이지</a>
										<a href="${root}/member/logout"
										class="dropdown-item text-center">Logout</a></li>
								</ul></li>

							<li class="nav-item"><a href="${root}/member/logout"
								class="nav-link m-2 "> Logout</a></li>
							<li class="nav-item d-flex align-items-center"><a
								href="${root}/cart/cart" class="nav-link m-2 "><i
									class="fa-solid fa-cart-shopping" style="color: #F20707;"></i></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>