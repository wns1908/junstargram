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
        

   var cloneObj = $(".upload-from").clone();   // 첨부파일을 추가하는 Div 요소를 복사
   $("#cta blue").on("click", function(e){
      var formData = new FormData();      // 가상의 <form> 태그
      var inputFile = $("input[name='file']");
      var files = inputFile[0].files;
      console.log(files);
      //add filedate to formdata
   /*    for(var i = 0; i < files.length; i++){
        if(!checkExtension(files[i].name, files[i].size)) {
           return false;
        }
        formData.append("uploadFile", files[i]);
      } */
      $.ajax({
        url: 'insta/uploadAjaxAction',
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        dataType: 'json',
        success: function(result){   // result : 첨부파일 정보가 실림
           console.log(result);
           showUploadedFile(result);
           $(".upload-from").html(cloneObj.html());   // 다시 초기화
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
      $(uploadResultArr).each(function(i, obj) {   // 첨부파일(obj)별로
        // str += "<li>" + obj.fileName + "</li>";   // AttachFileDTO fileName
        if(!obj.image) {   // 일반 파일은 대표 아이콘을 사용해서 표시
         alert("이미지파일만 올릴수있습니다.");
        } else {         // 이미지 파일
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
          
        </script>
    <%@ include file="../layout/footer.jsp" %>