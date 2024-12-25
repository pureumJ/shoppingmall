<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>상품메인페이지</title>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
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
	              $('#pmenu').append("<li><a class='nav-link ' href='/contents/mainlist/"+data[i].cateno+"'>" + data[i].catename + "</a></li>");
	           }                  
	                    
	            }).catch(console.log);
	}; 

	function cart(cateno) {
		if ('${sessionScope.id}' == '') {
			alert('먼저 로그인을 하세요');
			let url = '/member/login';
			url += '?cateno='+cateno;
			location.href = url;
			return;
		}
		//카트테이블에 등록하고 등록 확인 창 보여주기 (비동기)
	}
	function order(cateno) {
		if ('${sessionScope.id}' == '') {
			alert('먼저 로그인을 하세요');
			let url = '/member/login';
			url += '?cateno='+cateno;
			location.href = url;
			return;
		}
		//주문서 작성으로 이동 주문생성 (비동기)
	}
</script>
</head>
<body>
	<%-- <div class="container">
		<h3>new Item</h3>
		<c:choose>
			<c:when test="${empty list}">
				<div class="row">
					<h3>상품 준비중 입니다.</h3>
					<p>
						<img src="/contents/storage/default.jpg" class="img-thumbnail"
							width="236" height="306">
					</p>

				</div>
			</c:when>
			<c:otherwise>
				<c:set var="list" value="${list}" />
				<div class="row">
					<c:forEach var="dto" begin="0" end="3" items="${list}">
						<div class="col-sm-3">
							<c:choose>
								<c:when test="${cateno==1 }">
									<h3>Ripped Skinny</h3>
								</c:when>
								<c:when test="${cateno==2 }">
									<h3>Luxury BAG</h3>
								</c:when>
							</c:choose>
							<p>
								<a href="/contents/detail/${dto.contentsno }"> <img
									src="/contents/storage/${dto.filename }" class="img-thumbnail"
									width="236" height="306"></a>
							</p>
							<p>
								${dto.pname }<br> <b>가격 : ${dto.price }</b>
							</p>
							<div>
								<a href="javascript:cart('${dto.cateno }')"><i
									class="bi bi-cart"></i></a> <a
									href="javascript:order('${dto.cateno }')"><i
									class="bi bi-bag-heart-fill"></i></a>
							</div>

						</div>
					</c:forEach>
				</div>
				<div class="row">
					<c:forEach var="dto" begin="4" end="7" items="${list}">
						<div class="col-sm-3">
							<c:choose>
								<c:when test="${cateno==1 }">
									<h3>Vintage Skinny</h3>
								</c:when>
								<c:when test="${cateno==2 }">
									<h3>Classy BAG</h3>
								</c:when>
							</c:choose>
							<p>
								<a href="/contents/detail/${dto.contentsno }"> <img
									src="/contents/storage/${dto.filename }" class="img-thumbnail"
									width="236" height="306"></a>
							</p>
							<p>
								${dto.pname }<br> <b>가격 : ${dto.price }</b>
							</p>
							<div>
								<a href="javascript:cart('${dto.cateno }')"> <i class="bi bi-cart4 fs-5"
									title="장바구니 담기"></i>
								</a> <a href="javascript:order('${dto.cateno }')"> <i
									class="bi bi-bag-heart-fill fs-5" title="주문하기"></i>
								</a>
							</div>
						</div>
					</c:forEach>
				</div>
 ${paging}
</c:otherwise>
		</c:choose>
	</div> --%>
	<nav class="navbar navbar-expand-lg">
		<div class="container ps-5 pe-5 justify-content-center">
			<ul class="navbar-nav" id="pmenu">
				<li><a class="nav-link " href="${root}/contents/mainlist">전체</a></li>
			</ul>
		</div>
	</nav>
	
	<div class="container mt-5 col-9">
		<c:choose>
			<c:when test="${empty list}">
				<div class="d-flex justify-content-center">
					<div class="mt-5 mb-5 justify-content-center">
						<div class="fs-4 text-center">상품 준비중 입니다.</div>
						<p>
							<img src="/contents/storage/default.jpg" class="img-thumbnail"
								width="300" height="300">
						</p>
					</div>
				</div>

			</c:when>
			<c:otherwise>
				<c:set var="list" value="${list}" />
				<div class="row">
					<c:forEach var="dto" begin="0" end="6" items="${list}">
						<div class="col-2 m-4">
							<div class="img-area d-flex align-items-center" style="height: 180px">
								<a href="/contents/detail/${dto.contentsno }" >
									<img src="/contents/storage/${dto.filename }" class="img-fluid" width="200" height="200">
								</a>
							</div>
							<div class="text-start mt-5 mb-5">
								<a style="text-decoration: none;" class="text-black" href="/contents/detail/${dto.contentsno }" ><span>${dto.pname }<br>${dto.price }원</span></a>
							</div>
							<div>
								<a href="javascript:cart('${dto.cateno }')"><i
									class="bi bi-cart"></i></a> <a
									href="javascript:order('${dto.cateno }')"><i
									class="bi bi-bag-heart-fill"></i></a>
							</div>

						</div>
					</c:forEach>
				</div>
				
 				${paging}
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
