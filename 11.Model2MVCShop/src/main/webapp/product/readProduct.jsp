<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>

  <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	$(function() {
		
		$( "#OK" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('���')" ).html() );
			self.location = "/product/listProduct?menu=manage";
		});
		
		
		$( "#registerMore" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('���')" ).html() );
			self.location = "/product/addProductView.jsp";
		});
		
	});	
		
	</script>
	
</head>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ��ϰ��</h3>
	    </div>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ǰ ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-4">
		<c:forEach var="listFile" items="${listFile}">
			<img src="/images/uploadFiles/${listFile}" width="300" height="300" align="absmiddle"/>
		</c:forEach>
		</div>
		</div>
		
		<hr/>
		
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" id="OK" class="btn btn-primary">Ȯ��</button>
				<button type="button" id="registerMore" class="btn btn-primary">�߰����</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</body>

</html>