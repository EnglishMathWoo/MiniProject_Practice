<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <!-- jQuery UI toolTip 사용 JS-->
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">		
	
	$(function(){	
		$( "#previous" ).on("click" , function() {
			history.go(-1);
		});
	});
	
	$(function() {
			
		$("#giveCoupon").on("click" , function() {
		
			var discountRate = $("input[name='discountRate']").val();
			var discountValue = $("input[name='discountValue']").val();
			if(discountRate == "") {
				$("input[name='discountRate']").val(0);
			}
			if(discountValue == "") {
				$("input[name='discountValue']").val(0);
			}
			

		$("form").attr("method", "POST").attr("action", "/coupon/addCoupon/").submit();
		});
	});
	

	</script>		
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Lego Land</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">쿠 폰 생 성</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm"  enctype="multipart/form-data" >
		
		<input type="hidden" name="userId" value="${user.userId}">
		  
		  <div class="form-group">
		    <label for="couponName" class="col-sm-offset-1 col-sm-3 control-label">쿠폰이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="couponName"  name="couponName" placeholder="쿠폰이름">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="discountRate" class="col-sm-offset-1 col-sm-3 control-label">할인율</label>
		    <div class="col-sm-4">
		      <input type="number" step="0.01" class="form-control" id="discountRate"  name="discountRate" placeholder="할인율">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="discountValue" class="col-sm-offset-1 col-sm-3 control-label">할인금액</label>
		    <div class="col-sm-4">
		      <input type="number" class="form-control" id="discountValue"  name="discountValue" placeholder="할인금액">
		    </div>
		  </div>
		  
		 
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="giveCoupon">생 &nbsp;성</button>
			  <a class="btn btn-primary btn" role="button" id="previous">취&nbsp;소</a>
		    </div>
		  </div>
	
		</form>
 	</div>
</body>

</html>