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
		$("#currentPage").val(currentPage);
	  	$("form").attr("method" , "POST").attr("action", "/product/listProduct").submit();
	}

	
	//===== ����Code �ּ� ó�� ��  jQuery ���� ======//
	 $(function() {
		$( "button.btn.btn-default" ).on("click" , function() {
			fncGetList(1); 
		});
	 });
	
	
	 $(function() {
			
			$("#addNotice").on("click" , function() {
						
				self.location = "/notice/addNotice.jsp";
			});
		});
	
			
	 $(function() {
			
			$("button.delete").on("click" , function() {
				
				 var noticeNo = $(this).val();
						
				//Debug..
				console.log(noticeNo);
				self.location = "/notice/deleteNotice?noticeNo="+noticeNo;
			});
		});
	

	$(function() {
	
		$("td[name='manageNoticeTitle']").on("click", function() {
			
			//Debug..
			console.log($(this).find("[name='noticeNo']").val());
			self.location = "/notice/updateNotice?noticeNo="+$(this).find("[name='noticeNo']").val();
		});
		
	});	
		
	$(function() {
		$("td[name='searchNoticeTitle']").on("click", function() {
			
			console.log($(this).find("[name='noticeNo']").val());
		
			self.location = "/notice/getNotice?noticeNo="+$(this).find("[name='noticeNo']").val();
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
			<c:if test = "${menu == 'manage'}">
				<h3>�������װ���</h3>
			</c:if>
			<c:if test = "${menu == 'search'}">
				<h3>�������׸��</h3>
			</c:if>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    <form class="form-inline" name="detailForm">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    <c:if test = "${menu == 'manage'}">
				  <button type="button" class="btn btn-primary" id="addNotice">�� &nbsp;��</button>
			</td>
			</c:if>
		    </div>
		    
		</div>
		
		
		
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		
		<!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
          	<c:if test = "${menu == 'manage'}">
          	<th align="center"></th>
          	</c:if>
            <th align="center">������ȣ</th>
            <th align="center"></th>
            <th align="left" >��������</th>
            <th align="center"></th>
            <th align="left">�����ð�</th>
          </tr>
        </thead>
       
		<tbody>
		
		<c:set var="i" value="0" />
	<c:forEach var="notice" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<c:if test = "${menu == 'manage'}">
				<td align="left"><input type="checkbox"></td>
				<td align="left"> ${notice.noticeNo}</td>
				<td></td>
				<td align="left" name="manageNoticeTitle" id="manageNoticeTitle">
				${notice.noticeTitle}
				<input type="hidden" id="noticeNo" name="noticeNo" value="${notice.noticeNo}"/>
				</td>
				<td></td>
				<td align="left"> ${notice.noticeDate} </td>
				<td></td>
				<td align="left"><button type="button" class="btn btn-primary delete" value="${notice.noticeNo}" >����</button></td>
				<td></td>
			</c:if>
			<c:if test = "${menu == 'search'}">
				<td align="left"> ${notice.noticeNo}</td>
				<td></td>
				<td align="left" name="searchNoticeTitle" id="searchNoticeTitle">${notice.noticeTitle}
				<input type="hidden" name="noticeNo" value="${notice.noticeNo }">
				</td>
				<td></td>
				<td align="left"> ${notice.noticeDate} </td>
				<td></td>
			</c:if>
			
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

</form>	
</body>

</html>