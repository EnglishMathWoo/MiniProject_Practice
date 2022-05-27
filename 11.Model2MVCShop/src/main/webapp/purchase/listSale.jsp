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
	  body {
            padding-top : 50px;
        }
    </style>
    
    
	<script type="text/javascript">

	function fncGetList(currentPage) {
		//document.getElementById("currentPage").value = currentPage;
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/purchase/listSale").submit();
	}
	
	
	$(function() {
		
		$("td[name='getDetail']").on("click", function() {
			console.log($(this).find("input[name='tranNo']").val());
			self.location = "/purchase/getPurchase?tranNo="+$(this).find("input[name='tranNo']").val();
		});
		
	});
		
	$(function() {
		$("#deliver").on("click", function() {
			self.location = "/purchase/updateTranCode?tranNo="+$(this).find("[name='tranNo']").val()+"&menu=manage&currentPage=${resultPage.currentPage}&tranCode=배송중"			
		});
	
	});
		

</script>

</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>판매목록조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
		  
				</form>
	    	</div>
	    	
		</div>
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">주문번호</th>
            <th align="center"></th>
            <th align="left" >상품명</th>
            <th align="center"></th>
            <th align="left">구매자 ID</th>
            <th align="center"></th>
            <th align="left">전화번호</th>
            <th align="center"></th>
            <th align="left">배송현황</th>
            <th align="left">배송하기</th>
          </tr>
        </thead>
       
		<tbody>
		
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align=center name="getDetail">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
				<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${purchase.tranNo}
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			${purchase.tranNo}
			</td>
			<td></td>
			<td align="left">${purchase.purchaseProd.prodName}</a></td>
			<td></td>
			<td align="left">${purchase.buyer.userId}</td>
			<td></td>
			<td align="left">${purchase.receiverPhone}</td>
			<td></td>
			<td align="left">${purchase.tranCode}</td>
			
			<c:if test = "${purchase.tranCode == '구매완료'}">
			<td align="left" id="deliver">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
				<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&menu=manage&
				currentPage=${resultPage.currentPage}&tranCode=배송중">배송하기</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			배송하기
			</c:if>
			</td>
			<td></td>
		</tr>
	</c:forEach>			
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>