<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="resources/css/plugin/datepicker/bootstrap-datepicker.css">
	<script src="resources/js/plugin/datepicker/bootstrap-datepicker.js"></script>
	<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>
	
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
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">				
	$(function(){
        $("#divyDate").datepicker({ dateFormat: 'yy-mm-dd' });
	});


	$(function() {
		
		$("#purchase").on("click" , function() {
			
			//�޴��� ��ȣ �Է�
			var value = "";	
			
			var value = $("#phone1 option:selected").val() + "-" 
			+ $("input[name='phone2']").val() + "-" 
			+ $("input[name='phone3']").val();
			
			$("input:hidden[name='receiverPhone']").val( value );
			
			//�ּ� �Է�
			var address = "";	
			
			var address = '('+$("input[name='divyAddr1']").val()+')'
			+ $("input[name='divyAddr2']").val()
			+ '('+$("input[name='divyAddr3']").val()+') '
			+$("input[name='divyAddr4']").val();
			
			$("input:hidden[name='divyAddr']").val( address );
			
			
			var couponName = $("#issueNo option:selected").attr("value2");
			if(couponName == '19') {
				var price = $("input[name='price']").val();
				$("input[name='price']").val(price*0.5);
			} else if(couponName == '20'){
				var price = $("input[name='price']").val();
				$("input[name='price']").val(price-5000);
			}
			
			console.log($("input[name='price']").val());
			
			$("form").attr("method", "POST").attr("action", "/kakaoPay").submit();
			
		});
		
		
		$( "#previous" ).on("click" , function() {
			history.go(-1);
		});
		
	});
	
	
	function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� ǥ���Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var roadAddr = data.roadAddress; // ���θ� �ּ� ����
                var extraRoadAddr = ''; // ���� �׸� ����

                // ���������� ���� ��� �߰��Ѵ�. (�������� ����)
                // �������� ��� ������ ���ڰ� "��/��/��"�� ������.
                if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // ǥ���� �����׸��� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
                document.getElementById('divyAddr1').value = data.zonecode;
                document.getElementById("divyAddr2").value = roadAddr;
                document.getElementById("divyAddr3").value = data.jibunAddress;
                

                var guideTextBox = document.getElementById("guide");
                // ����ڰ� '���� ����'�� Ŭ���� ���, ���� �ּҶ�� ǥ�ø� ���ش�.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(���� ���θ� �ּ� : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(���� ���� �ּ� : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        
        }).open();
    }

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

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">�� ǰ �� ��</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm"  enctype="multipart/form-data" >
		
		<input type="hidden" name="prodNo" value="${product.prodNo}">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ </label>
		     <h5>&nbsp;${product.prodNo}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <h5>&nbsp;${product.prodName}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <h5>&nbsp;${product.prodDetail}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <h5>&nbsp;${product.manuDate}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">�� ��</label>
		    <h5>&nbsp;${product.price}</h5>
		    <input type="hidden" name="price" value="${product.price}">
		  </div>
		  
		  <div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">�������</label>
		    <h5>&nbsp;${product.regDate}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">������ID</label>
		    <h5>&nbsp;${user.userId}</h5>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="�������̸�">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="��ȣ">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="��ȣ">
		    </div>
		    <input type="hidden" name="receiverPhone"  />
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="paymentOption" id="paymentOption">
				  <option value="1" selected="selected">���ݱ���</option>
				  <option value="2">�ſ뱸��</option>
			  </select>
		    </div>
		  </div>
		 
		  <div class="form-group">
		    <label for="couponUse" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		     <div class="col-sm-2">
		     <select class="form-control" name="issueNo" id="issueNo">
		     <c:forEach var="coup" items="${coupon}">
		       <c:choose>
         		<c:when test = "${coup.couponName != null}">
         			<option value="${coup.issueNo}", value2="${coup.couponNo}"> ${coup.couponName}</option>
         			<option value="noUse">������</option>
         		</c:when>
         		<c:otherwise>
				   <option>���� ����</option>
				</c:otherwise>
      		  </c:choose>
      		  </c:forEach>
         	</select>
         	
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-4">
		      <input type="text" name="divyAddr1" id="divyAddr1" placeholder="�����ȣ">
			  <input type="button" onclick="sample4_execDaumPostcode()" value="�����ȣ ã��"><br>
			  <input type="text" name="divyAddr2" id="divyAddr2" placeholder="���θ��ּ�">
			  <input type="text" name="divyAddr3" id="divyAddr3" placeholder="�����ּ�">
			  <span id="guide" style="color:#999;display:none"></span>
			  <input type="text" name="divyAddr4" id="divyAddr4" placeholder="���ּ�">
			  <input type="hidden" name="divyAddr"  />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="���ſ�û����">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate"  name="divyDate" placeholder="��������">
		    </div>
		  </div>
		  
		  
		 
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="purchase">�� &nbsp;��</button>
			  <a class="btn btn-primary btn" role="button" id="previous">��&nbsp;��</a>
		    </div>
		  </div>
	
		</form>
 	</div>
</body>

</html>