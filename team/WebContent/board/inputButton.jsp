<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.4.1.min.js"></script>

    <script type="text/javascript">

       
    var form_data=new FormData();
    var lastValue;
    
    if(lastValue==null){
    	lastValue=0;
    }else {
    	 lastValue = document.getElementById("image_preview").lastChild.getAttribute("dataNum");
    }
    
    function preview_image() 
    {         
     var total_file=document.getElementById("image").files.length;     
     alert("lastValue: "+lastValue);
     
     for(var i=0;i<total_file;i++)
     {        	
    	
    	var j=lastValue+1;
    	
    	lastValue=j;
    	alert("i: "+i);
    	alert("j: "+j);
    	var html="<img src='"+URL.createObjectURL(event.target.files[i])+"' dataNum='"+ j +"' onclick='deleteImageAction("+ j +")' class='preview"+j+"' width='80px' height='80px'>"
      	$('#image_preview').append(html);
      	alert(URL.createObjectURL(event.target.files[i]));  
      	form_data.append("files["+j+"]", document.getElementById('image').files[i]);
      	alert("files["+j+"] form data에 files[i] 값 넣음");
      	
     }
     
     
    }
    
    function deleteImageAction(dataNum) {
              
        var preview = ".preview"+dataNum;
        alert(preview);
        form_data.delete("files["+dataNum+"]");
        $(preview).remove(); 
    }
    
    function changeProfile() {
        $('#image').click();
    }
       
    
    function writeSomething() {	
		if(form_data!=null){
			$.ajax({
				url: "./InputForm",
				type: "POST",
				data: {data:"1"},
				dataType: "text",
				success: function(data){
					alert("success");
				},
				error: function(data){
					alert("error");
				}
			});
		}
	}
    
    
    function preview_video(){
    	  
    	 alert("VIDEOONCHANGE");
    	 var video = document.getElementById('video');
    	 var obj_url = URL.createObjectURL(event.target.files[0]);
    	 alert("obj_url: "+obj_url);
    	 
    	 video.src = obj_url;  
    	 video.play();
    	 
    	 var $image = $("#video_preview");        	 
    	 var canvas = document.createElement("canvas");
    	 canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

    	 var img = document.createElement("img");
    	 img.src = canvas.toDataURL();
    	 $image.prepend(img);
    	    
    	   
    }
    
    function delete_vidPreview(){
    	
    }
    
    </script>    
</head>
<body>
	
    <input type="button" value="click" id="preview" onclick="javascript:changeProfile();">
    <input type="file" id="image" style="display: none;" onchange="preview_image();" multiple/>
    <input type="button" id="submit" onclick="javascript: writeSomething();" value="upload">
    <div id="image_preview"></div>
    <hr>
    <input type="file" id="video" onchange="preview_video();">
    <div id="video_preview"></div>
     

    
    

</body>
</html>