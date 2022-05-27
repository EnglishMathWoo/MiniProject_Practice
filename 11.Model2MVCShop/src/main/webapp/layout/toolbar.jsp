<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Lego Land</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!--  회원관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >회원관리</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">개인정보조회</a></li>
	                         <li><a href="#">공지사항목록</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'admin'}">
	                         	<li><a href="#">회원정보조회</a></li>
	                         	<li><a href="#">공지사항관리</a></li>
	                         	<li><a href="#">쿠폰관리</a></li>
	                         	<li><a href="#">쿠폰생성</a></li>
	                           	<li><a href="#">쿠폰발급</a></li>
	                           	<li><a href="#">생성쿠폰목록조회</a></li>
	                           	<li><a href="#">쿠폰발급목록조회</a></li>
	                         </c:if>
	                     </ul>
	                 </li>
	                 
	              <!-- 판매상품관리 DrowDown  -->
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >판매관리</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">판매상품등록</a></li>
		                         <li><a href="#">판매상품관리</a></li>
		                         <li><a href="#">판매목록조회</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	              <!-- 구매관리 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span >상품구매</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">상 품 검 색</a></li>
	                         
	                         <c:if test="${sessionScope.user.role == 'user'}">
	                           <li><a href="#">구매이력조회</a></li>
	                         </c:if>
	                         
	                         <li><a href="#">최근 본 상품</a></li>
	                     </ul>
	                 </li>

	             </ul>
	             
	             <ul class="nav navbar-nav navbar-right">
	                <li><a href="#">로그아웃</a></li>
	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	    
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
		//============= logout Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회 Event  처리 =============	
	 	$( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
			
	 	 $(function() {
	 		//=============  판매상품등록 Event  처리 =============
		 	$("a:contains('판매상품등록')").on("click" , function() {
				self.location = "/product/addProductView.jsp"
			}); 			 		
		 });
	 	 
	 	$(function() {
	 	//=============  판매상품관리 Event  처리 =============
		 	$("a:contains('판매상품관리')").on("click" , function() {
				self.location = "/product/listProduct?menu=manage"
			}); 
	 	 });
	 	
	 	$(function() {
		//=============  상 품 검 색 Event  처리 =============
			$("a:contains('상 품 검 색')").on("click" , function() {
				self.location = "/product/listProduct?menu=search"
			}); 
		});
	 	
	 	$(function() {
		 //=============  판매목록조회 Event  처리 =============
		 	$("a:contains('판매목록조회')").on("click" , function() {
				self.location = "/purchase/listSale?menu=manage"
			}); 
		});
	 	
	 	$(function() {
		//=============  구매이력조회 Event  처리 =============
		 	$("a:contains('구매이력조회')").on("click" , function() {
				self.location = "/purchase/listPurchase"
			}); 
		});
	 	
	 	$(function() {
		 	$("a:contains('공지사항관리')").on("click" , function() {
		 		self.location = "/notice/listNotice?menu=manage"
			}); 
		});
	 	
	 	$(function() {
		 	$("a:contains('공지사항목록')").on("click" , function() {
		 		self.location = "/notice/listNotice?menu=search"
			}); 
		});
	 	
	 	$(function() {
		 	$("a:contains('쿠폰관리')").on("click" , function() {
		 		self.location = "/coupon/manageCoupon.jsp"
			}); 
		});
	 	
	 	$(function() {
		 	$("a:contains('쿠폰생성')").on("click" , function() {
		 		self.location = "/coupon/addCouponView.jsp"
			}); 
		});
	 	
		$(function() {
		 	$("a:contains('쿠폰발급')").on("click" , function() {
		 		self.location = "/coupon/addCouponView"
			}); 
		});
		
		$(function() {
		 	$("a:contains('생성쿠폰목록조회')").on("click" , function() {
		 		self.location = "/coupon/listCoupon"
			}); 
		});
		
		$(function() {
		 	$("a:contains('쿠폰발급목록조회')").on("click" , function() {
		 		self.location = "/coupon/listIssuedCoupon"
			}); 
		});
	 	
	 	$( "a:contains('최근 본 상품')" ).bind("click" , function() {
	 		popWin = window.open("/history.jsp", "popWin",
	 		"left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
		}); 
	 	
		
		
	</script>  