<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
	<%@ include file="../layout/header.jsp" %>

    <!--사진 업로드페이지 중앙배치-->
        <main class="uploadContainer">
           <!--사진업로드 박스-->
            <section class="upload">
               
               <!--사진업로드 로고-->
                <div class="upload-top">
                    <a href="${pageContext.request.contextPath}/insta/feed" class="">
                        <img src="${pageContext.request.contextPath}/resources/images/junsta.png" alt="">
                    </a>
                    <p>사진 업로드</p>
                </div>
                <!--사진업로드 로고 end-->
                
                <!--사진업로드 Form-->
                <form class="upload-form" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/insta/feed"> <!-- 타입이 하나가 아니다. 2가지 이상 타입 -->
                    <input type="file" name="file" accept="image/*1" id="input_img">
                    
                    <div class="upload-img">
                        <img alt="" id="img-preview" >
                    </div>
                    
       
                    <!--사진설명 + 업로드버튼-->
                    <div class="upload-form-detail">
                        <input type="text" placeholder="사진설명" name="caption" id="caption">
                        <input type="text" placeholder="#태그" name="tags">
                        <button class="cta blue">업로드</button>
                    </div>
                    <!--사진설명end-->
                    
                </form>
                <!--사진업로드 Form-->
            </section>
            <!--사진업로드 박스 end-->
        </main>      
<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous">
</script>
 <script>
           $("#input_img").on("change" ,(e) => {
              let files = e.target.files;
              let filesArr = Array.prototype.slice.call(files);
              filesArr.forEach((f) => {
                 /* 이미지로 시작하는게 아니라면 */
                 if(!f.type.match("image.*")){
                    alert("이미지를 등록해야 합니다.");
                    return;
                 }
                 
                 let reader = new FileReader();
                 reader.onload = (e) => {
                    console.log("e.target:"+e.target);
                    $("#img-preview").attr("src",e.target.result);
                 }
                 reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
              });
              
           });

$(document).ready(function(){
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;	// 5MB
	
	function checkExtension(filename, filesize) {
		if(filesize > maxSize) {			// 파일의 크기 제한
			alert("파일 크기 초과");
			return false;
		}
		if(regex.test(filename)) {		// 확장자 제한
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}

	var cloneObj = $(".uploadDiv").clone();	// 첨부파일을 추가하는 Div 요소를 복사
	$("#uploadBtn").on("click", function(e){
		var formData = new FormData();		// 가상의 <form> 태그
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log(files);
		//add filedate to formdata
		for(var i = 0; i < files.length; i++){
		  if(!checkExtension(files[i].name, files[i].size)) {
			  return false;
		  }
		  formData.append("uploadFile", files[i]);
		}
		$.ajax({
		  url: '/insta/uploadAjaxAction',
		  processData: false,
		  contentType: false,
		  data: formData,
		  type: 'POST',
		  dataType: 'json',
		  success: function(result){	// result : 첨부파일 정보가 실림
			  console.log(result);
			  showUploadedFile(result);
			  $(".uploadDiv").html(cloneObj.html());	// 다시 초기화
			  	// input type="file" 을 다시 초기화 (이전에 첨부한 파일에 대한 정보를 제거)
			  // <input type="text" name="name" value="${board.name}">
			  // 파일(type="file")인 경우는 value에 다른 값을 넣는 것으로 초기화 할 수 없다.
			  // 그래서 요소를 새로 만든다.
		  }
		/*,
		  error: function(error) {
			  alert("Uploaded");
		  }
		*/
		}); //$.ajax
	});
	
	var uploadResult = $(".uploadResult ul");
	function showUploadedFile(uploadResultArr) {
		var str = "";
		$(uploadResultArr).each(function(i, obj) {	// 첨부파일(obj)별로
		  // str += "<li>" + obj.fileName + "</li>";	// AttachFileDTO fileName
		  if(!obj.image) {	// 일반 파일은 대표 아이콘을 사용해서 표시
			  var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" +
					  obj.fileName);
			  str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
					  "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" + 
			  		  "<span data-file=\'" + fileCallPath + "\' data-type='file'></span>" +
					  "</div></li>";
		  } else {			// 이미지 파일
			  // str += "<li>" + obj.fileName + "</li>";
			  // 파일 이름에 한글이 있을 경우 인코딩 처리 : encodeURIComponent()
			  var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" +
						obj.uuid + "_" + obj.fileName);
			  var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
			  originPath = originPath.replace(new RegExp(/\\/g), "/");
			  str += "<li><a href=\"javascript:showImage(\'" + originPath +
				"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>" + 
				"<span data-file=\'" + fileCallPath + "\' data-type='image'></span>" +	
				"</li>";
		  }
		});
		uploadResult.append(str);
	}
	
/* 	// 원본이미지를 클릭하면 원래화면으로 돌아가도록 처리
	$(".bigPictureWrapper").on("click", function(e){
		$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		setTimeout(function() {
			$(".bigPictureWrapper").hide();
		}, 1000);
	}); */

	$(".uploadResult").on("click","span", function(e){
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		  
		/* $.ajax({
		    url: '/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		      success: function(result){
		         alert(result);
		      }
		}); //$.ajax   */
	});

});
</script>
</body>
</html>