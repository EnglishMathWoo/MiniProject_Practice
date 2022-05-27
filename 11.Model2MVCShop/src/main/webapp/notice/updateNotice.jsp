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
	
	
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
	
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
				 
		$(function() {
		     $('#summernote').summernote({
		             height: 300,                 // set editor height
		             minHeight: null,             // set minimum height of editor
		             maxHeight: null,             // set maximum height of editor
		             focus: true,                  // set focus to editable area after initializing summernote
		             callbacks: {	//이미지 첨부하는 부분
	    	               onImageUpload : function(files) {
	    	                    uploadSummernoteImageFile(files[0],this);
	    	                },
	    	                onPaste: function (e) {
	    						var clipboardData = e.originalEvent.clipboardData;
	    						if (clipboardData && clipboardData.items && clipboardData.items.length) {
	    							var item = clipboardData.items[0];
	    							if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
	    								e.preventDefault();
	    							}
	    						}
	    					}
	    	  	  
	    	            }
		     
		     });
	
		 }); 
		 
		 function uploadSummernoteImageFile(file, editor) {
				data = new FormData();
				data.append("file", file);
				$.ajax({
					data : data,
					type : "POST",
					url : "/notice/json/uploadSummernoteImageFile",
					contentType : false,
					processData : false,
					success : function(data) {
						console.log(data.url);
		            	//항상 업로드된 파일의 url이 있어야 한다.
						$(editor).summernote('insertImage', data.url);
					}
				});
			}
		 
	
		 $(function() {
				$( "#edit" ).on("click" , function() {
					$("form").attr("method", "POST").attr("action", "/notice/updateNotice").submit();
				});
			});
		 
	 
		 $(function() {
				$( "#previous" ).on("click" , function() {
					history.go(-1);
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
	       <h3>공지사항수정 </h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm"  enctype="multipart/form-data" >
	    
	    <input type="hidden" class="form-control" id="noticeNo" name="noticeNo"  value="${notice.noticeNo}" />
	    
	    <input type="text" class="form-control" id="noticeTitle" name="noticeTitle"  value="${notice.noticeTitle}" />
	    
	    <br>
	    
	    <div class="container">
 		 <textarea class="summernote" id ="summernote" name="noticeContent">${notice.noticeContent}</textarea>    
		</div>
		
		 <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="edit">수 &nbsp;정</button>
			  <a class="btn btn-primary btn" role="button" id="previous">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		
		
</body>

</html>