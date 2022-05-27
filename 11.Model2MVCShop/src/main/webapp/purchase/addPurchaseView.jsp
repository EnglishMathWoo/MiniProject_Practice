<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
        $("#divyDate").datepicker({ dateFormat: 'yy-mm-dd' });
	});


	$(function() {
		
		$("#purchase").on("click" , function() {
			
			//휴대폰 번호 입력
			var value = "";	
			
			var value = $("#phone1 option:selected").val() + "-" 
			+ $("input[name='phone2']").val() + "-" 
			+ $("input[name='phone3']").val();
			
			$("input:hidden[name='receiverPhone']").val( value );
			
			//주소 입력
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
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('divyAddr1').value = data.zonecode;
                document.getElementById("divyAddr2").value = roadAddr;
                document.getElementById("divyAddr3").value = data.jibunAddress;
                

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
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

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">상 품 구 매</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm"  enctype="multipart/form-data" >
		
		<input type="hidden" name="prodNo" value="${product.prodNo}">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품번호 </label>
		     <h5>&nbsp;${product.prodNo}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <h5>&nbsp;${product.prodName}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <h5>&nbsp;${product.prodDetail}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <h5>&nbsp;${product.manuDate}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가 격</label>
		    <h5>&nbsp;${product.price}</h5>
		    <input type="hidden" name="price" value="${product.price}">
		  </div>
		  
		  <div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">등록일자</label>
		    <h5>&nbsp;${product.regDate}</h5>
		  </div>
		  
		  <div class="form-group">
		    <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자ID</label>
		    <h5>&nbsp;${user.userId}</h5>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="구매자이름">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
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
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		    <input type="hidden" name="receiverPhone"  />
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="paymentOption" id="paymentOption">
				  <option value="1" selected="selected">현금구매</option>
				  <option value="2">신용구매</option>
			  </select>
		    </div>
		  </div>
		 
		  <div class="form-group">
		    <label for="couponUse" class="col-sm-offset-1 col-sm-3 control-label">쿠폰적용</label>
		     <div class="col-sm-2">
		     <select class="form-control" name="issueNo" id="issueNo">
		     <c:forEach var="coup" items="${coupon}">
		       <c:choose>
         		<c:when test = "${coup.couponName != null}">
         			<option value="${coup.issueNo}", value2="${coup.couponNo}"> ${coup.couponName}</option>
         			<option value="noUse">사용안함</option>
         		</c:when>
         		<c:otherwise>
				   <option>쿠폰 없음</option>
				</c:otherwise>
      		  </c:choose>
      		  </c:forEach>
         	</select>
         	
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" name="divyAddr1" id="divyAddr1" placeholder="우편번호">
			  <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			  <input type="text" name="divyAddr2" id="divyAddr2" placeholder="도로명주소">
			  <input type="text" name="divyAddr3" id="divyAddr3" placeholder="지번주소">
			  <span id="guide" style="color:#999;display:none"></span>
			  <input type="text" name="divyAddr4" id="divyAddr4" placeholder="상세주소">
			  <input type="hidden" name="divyAddr"  />
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate"  name="divyDate" placeholder="제조일자">
		    </div>
		  </div>
		  
		  
		 
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="purchase">구 &nbsp;매</button>
			  <a class="btn btn-primary btn" role="button" id="previous">취&nbsp;소</a>
		    </div>
		  </div>
	
		</form>
 	</div>
</body>

</html>