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
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	
	$(function() {

	
		$("#userId").on("click", function() {
			//Debug..
			console.log($(this).find("[name='userId']").val());
			self.location = "/user/updateUser?userId="+$(this).find("[name='userId']").val();
		});
		
		$("#receiveComplete").on("click", function() {
			self.location = "/purchase/updateTranCode?tranNo="+$(this).find("[name='tranNo']").val()+"&currentPage=${resultPage.currentPage}&tranCode=수령완료&menu=search"
		});
		
		
		$("td[name='getDetail']").on("click", function() {
			
			var tranCode=$(this).find("input[name='tranCode']").val();
			
			console.log(tranCode)
			
			//Debug..
			console.log($(this).find("[name='tranNo']").val());
			self.location = "/purchase/getPurchase?tranNo="+$(this).find("[name='tranNo']").val();
		});
		
		
		$("td[name='updatePurchase']").on("click", function() {
			
			var tranCode=$(this).find("input[name='tranCode']").val();
			
			console.log(tranCode)
			
			if(tranCode != '수령완료'){
				self.location = "/purchase/updatePurchase?tranNo="+$(this).find("[name='tranNo']").val();
			}
			
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
				<h3>구매이력조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		</div>
		
		<form class="form-inline" name="detailForm">
		
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="center"></th>
            <th align="left" >회원ID</th>
            <th align="center"></th>
            <th align="left">회원명</th>
            <th align="center"></th>
            <th align="left">배송현황</th>
            <th align="center"></th>
            <th align="left">정보수정</th>
            <th align="center"></th>
            <th align="left">상세보기</th>
            <th align="center"></th>
            <th align="left">수정하기</th>
          </tr>
        </thead>
       
		<tbody>
		
		<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left" name="userId" id="userId">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
				<a href="/user/getUser?userId=${user.userId}">${user.userId}</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			${user.userId}
			</td>
			<td></td>
			<td align="left">${user.userName}</td>
			<td></td>
			<td align="left"> ${purchase.tranCode} </td>
			<td></td>
			<c:if test = "${purchase.tranCode == '배송중'}">
			<td align="left" name="receiveComplete" id="receiveComplete">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			수령완료
			</td>
			</c:if>
			<c:if test = "${purchase.tranCode != '배송중'}">
			<td align="left"></td>
			</c:if>
			<td></td>
			<td align="left" name="getDetail" id="getDetail">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
				<a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">상세보기</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			상세보기
			&nbsp;
			</td>
			<td></td>
			<td align="left" name="updatePurchase" id="updatePurchase">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			<input type="hidden" name="tranCode" value="${purchase.tranCode }">
			<!-- ////////////////// jQuery Event 처리로 변경됨 /////////////////////////
				<a href="/purchase/updatePurchase?tranNo=${purchase.tranNo}">수정하기</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			수정하기
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

</form>	
</body>

</html>