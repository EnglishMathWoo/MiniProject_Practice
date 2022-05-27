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
	
	<link rel="stylesheet" href="resources/css/plugin/datepicker/bootstrap-datepicker.css">
	<script src="resources/js/plugin/datepicker/bootstrap-datepicker.js"></script>
	<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>
	
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
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">				
		$(function(){
     	   $("#startDate").datepicker({ dateFormat: 'yy-mm-dd' });
		});
	
	
		$(function(){
   		    $("#endDate").datepicker({ dateFormat: 'yy-mm-dd' });
		});
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
		}
		
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetList(1);
			});
		 });
		
		 $(function() {
				
			$("#giveCoupon").on("click" , function() {
						
			$("form").attr("method", "POST").attr("action", "/coupon/issueCoupon").submit();
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
	       <h3>쿠폰발급</h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm"  enctype="multipart/form-data" >
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
	    <input type="hidden" id="issueStatus" name="issueStatus" value="사용가능"/>
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		   <div class="form-group">
		    <label for="startDate" class="col-sm-offset-1 col-sm-3 control-label">쿠폰시작일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="startDate"  name="startDate" placeholder="쿠폰시작일자">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="endDate" class="col-sm-offset-1 col-sm-3 control-label">쿠폰만료일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="endDate"  name="endDate" placeholder="쿠폰만료일자">
		    </div>
		   </div>
		    
		    <div class="form-group">
		    <label for="couponList" class="col-sm-offset-1 col-sm-3 control-label">쿠폰종류</label>
		     <div class="col-sm-2">
		        <select class="form-control" name="couponNo" id="couponNo">
		     <c:forEach var="coup" items="${couponList}">
		       <c:choose>
         		<c:when test = "${coup.couponName != null}">
         			<option value="${coup.couponNo}"> ${coup.couponName}</option>
         		</c:when>
         		<c:otherwise>
				   <option>쿠폰 없음</option>
				</c:otherwise>
      		  </c:choose>
      		  </c:forEach>
         	</select>
		    </div>
		  </div>
		  
		  <button type="button" class="btn btn-primary" id="giveCoupon">발 &nbsp;급</button>
		    
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >회원 ID</th>
            <th align="left">회원명</th>
            <th align="left">이메일</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="user" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="left"><input type="checkbox" name="userId" id="userId" value = "${user.userId}" ></td>
			  <td align="center">${ i }</td> 
			  <td align="left">${user.userId}</td>
			  <td align="left">${user.userName}</td>
			  <td align="left">${user.email}</td>
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
			  	<input type="hidden" value="${user.userId}">
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