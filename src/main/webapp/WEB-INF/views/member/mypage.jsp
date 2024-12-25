<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<script>
	function updateFile() {
		let url = "/member/updateFile";
		url += "?fname=${dto.fname}";
		location.href = url;
	}
</script>
</head>
<body style="background: #F2F2F2;">

	<div class="container col-9 mt-5 mb-5 d-flex justify-content-center">
		<%-- <div class="row">

			<div class="col-sm-3">
				<!-- <h4><i class="bi bi-people-fill"></i> 나의 정보</h4> -->
				<img src="/member/storage/${dto.fname}" style="width: 280px">${dto.fname}
				<p>
					<a href="javascript:updateFile()">사진수정</a>
				</p>
				<p>ID:${dto.id}, 성명:${dto.mname}</p>
				<p>배송지:(${dto.zipcode })${dto.address1 } ${dto.address2}</p>
			</div>

			<div class="col-sm-6">
				<h4>
					<i class="fa-solid fa-shirt"></i> 주문 내역 및 리뷰 작성
				</h4>
				<ul class="list-group m-3">
					<c:choose>
						<c:when test="${empty dto.list }">주문한 상품이 없습니다.</c:when>

						<c:otherwise>
							<c:forEach var="order" items="${dto.list}">
								<p class='h5 mt-3 mb-auto'>
									<i class="bi bi-calendar-date-fill"></i>
									${fn:substring(order.odate,0,10)}
								<p>
								<li class="list-group-item">결제금액 : ${order.total} 원, 주문상태 :
									${order.ostate} <c:forEach var="detail" items="${order.list}">
										<li class="list-group-item">${detail.pname},
											${detail.quantity}개 <a
											href="review/create/{order.contentsno}"><span
												class="badge rounded-pill bg-dark">Review</span></a>
										</li>
									</c:forEach>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div> --%>
		<div class="col-2">
			<div class="sidemenu">
				<ul class="nav flex-column">
					<li class="nav-item"><a href="#" class="nav-link text-black">주문
							조회</a></li>
					<li class="nav-item"><a href="#" class="nav-link text-black">취소/교환/반품</a></li>
					<li class="nav-item"><a href="#" class="nav-link text-black">1:1
							문의</a></li>
					<li class="nav-item"><a href="#" class="nav-link text-black">정보
							수정</a></li>
					<li class="nav-item"><a href="#" class="nav-link text-black">회원
							탈퇴</a></li>
				</ul>
			</div>
		</div>

		<div class="col-9 bg-white d-flex align-items-center">
			<div class="p-5 d-flex align-items-center">
				<div class="img-area me-4">
					<img class="rounded-circle" src="/member/storage/${dto.fname}"
						style="width: 90px; height: 90px;">
					<%-- ${dto.fname} --%>
				</div>
				<div class="text-area">
					<span class="fs-4">${dto.mname} 님 안녕하세요.</span><br>
					누적 구매금액 : 0원
						
				</div>
			</div>

		</div>

	</div>


</body>
</html>
