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
		$("#currentPage").val(currentPage);
	  	$("form").attr("method" , "POST").attr("action", "/product/listProduct").submit();
	}

	
	//===== 기존Code 주석 처리 후  jQuery 변경 ======//
	 $(function() {
		$( "button.btn.btn-default" ).on("click" , function() {
			fncGetList(1); 
		});
	 });
	
	 $(function() {
		$( "#lowPrice" ).on("click" , function() {
			$("#orderCondition").val("1").prop("selected", true);
			console.log($("#orderCondition").val())
			fncGetList(1);
		});
	 });
	
	 $(function() {
		$( "#highPrice" ).on("click" , function() {
			$("#orderCondition").val("2").prop("selected", true);
			fncGetList(1);
		});
	 });
		
		
	$(function() {
		$("td[name='briefInfo']").on("click", function() {
			 
			var prodNo = $(this).find("[name='prodNo']").val();
			
			$.ajax( 
					{
						url : "/product/json/getProduct/"+prodNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
						
							fileList = JSONData.fileName.split("/");
							
							var displayValue = "<td><h6>"
												+"상품번호 : "+JSONData.prodNo+"<br/><br/>"
												+"상품명 : "+JSONData.prodName+"<br/><br/>"
												+"상품이미지 : "
												+"<img src= '/images/uploadFiles/"+fileList[0]+"' width='300' height='300' align='absmiddle'/>"
												+"<br/><br/>"
												+"상품상세정보 : "+JSONData.prodDetail+"<br/><br/>"
												+"제조일자 : "+JSONData.manuDate+"<br/><br/>"
												+"가격 : "+JSONData.price+"<br/><br/>"
												+"</h6></td>";
							//Debug...									
							//alert(displayValue);
							$("h6").remove();
							$( "#"+prodNo+"" ).html(displayValue);
						}
				});
					
		});
		
		$("#hide").css("display","none")
		
	});	
	
	$(function() {
	
		$("td[name='manageProdNo']").on("click", function() {
			//Debug..
			console.log($(this).find("[name='prodNo']").val());
			self.location = "/product/updateProduct?prodNo="+$(this).find("[name='prodNo']").val();
		});
		
		$( ".ct_list_pop td:nth-child(2)" ).css("color" , "red");
		
	});	
		
	$(function() {
		$("td[name='searchProdNo']").on("click", function() {
		
		
			//Debug..
			console.log($(this).find("[name='prodNo']").val());
			self.location = "/product/getProduct?prodNo="+$(this).find("[name='prodNo']").val();
		});
		
		$( "td[name='searchProdNo']" ).css("color" , "red");
	
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
	       <c:if test = "${menu == 'manage'}">
				<h3>판매상품관리</h3>
			</c:if>
			<c:if test = "${menu == 'search'}">
				<h3>상 품 검 색</h3>
			</c:if>
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
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
		  
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
			<div class="row">
		    <div class="col-md-6 text-left">
		    	<div style="float:left" id="lowPrice">
		    	<p class="text-secondary">
				*낮은 가격순 &emsp;
				</p>
				</div>
				<div style="float:left" id="highPrice">
				<p class="text-secondary" >
				*높은 가격순
				</p>
				</div>
		    </div>
		    <div class="col-md-6 text-right">
			</div>
			</div>
			<div id="hide">
			<select name="orderCondition" id = "orderCondition">
				<option value="0"  ${ empty search.orderCondition ? "selected" : "" }></option>
				<option value="1"  ${ ! empty search.orderCondition && search.orderCondition==1 ? "selected" : "" }></option>
				<option value="2"  ${ ! empty search.orderCondition && search.orderCondition==2 ? "selected" : "" }></option>
			</select>
			</div>
	
		
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
       
		<tbody>
		
		<c:set var="i" value="0" />
		<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<c:if test = "${menu == 'manage' && product.proTranCode == null}">
			<td align="left" name="manageProdNo">
			<input type="hidden" name="prodNo" value="${product.prodNo }">
			${product.prodName}			
			</td>
			</c:if>
			<c:if test = "${menu == 'manage' && product.proTranCode != null}">
			<td align="left">${product.prodName}</a></td>
			</c:if>
			<c:if test = "${menu == 'search'}">
			<td align="left" name="searchProdNo">
			<input type="hidden" name="prodNo" value="${product.prodNo }">
			${product.prodName}
			</td>
			</c:if>
		<td align="left">${product.price}</td>
		<td align="left">${product.regDate}</td>
		<c:choose>
			<c:when test = "${product.proTranCode == null}">
			<td>
			판매중
			</td>
			</c:when>
			<c:otherwise>
			<td align="left">판매완료</a></td>
			</c:otherwise>
		</c:choose>
		<td align="left" name="briefInfo">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  	<input type="hidden" name="prodNo" value="${product.prodNo}">
		</td>
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