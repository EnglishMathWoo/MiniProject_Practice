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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
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
			self.location = "/purchase/updateTranCode?tranNo="+$(this).find("[name='tranNo']").val()+"&menu=manage&currentPage=${resultPage.currentPage}&tranCode=�����"			
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
	
		<div class="page-header text-info">
	       <h3>�ǸŸ����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
		  
				</form>
	    	</div>
	    	
		</div>
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">�ֹ���ȣ</th>
            <th align="center"></th>
            <th align="left" >��ǰ��</th>
            <th align="center"></th>
            <th align="left">������ ID</th>
            <th align="center"></th>
            <th align="left">��ȭ��ȣ</th>
            <th align="center"></th>
            <th align="left">�����Ȳ</th>
            <th align="left">����ϱ�</th>
          </tr>
        </thead>
       
		<tbody>
		
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align=center name="getDetail">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
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
			
			<c:if test = "${purchase.tranCode == '���ſϷ�'}">
			<td align="left" id="deliver">
			<input type="hidden" name="tranNo" value="${purchase.tranNo }">
			<!-- ////////////////// jQuery Event ó���� ����� /////////////////////////
				<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&menu=manage&
				currentPage=${resultPage.currentPage}&tranCode=�����">����ϱ�</a>
			////////////////////////////////////////////////////////////////////////////////////////////////// -->
			����ϱ�
			</c:if>
			</td>
			<td></td>
		</tr>
	</c:forEach>			
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>