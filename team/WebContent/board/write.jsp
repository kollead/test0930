<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function writeSomething() {
		var content = $("#content").val();		
		alert("content: " + content);		
		if(content!=""){
			$.ajax({
				url: "./WriteBoard",
				type: "POST",
				data: {content:content},
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
	
	
</script>
</head>
<body>
	

	<div class="central-meta new-pst">
		<div class="new-postbox">
			<figure>
				<img src="./images/resources/admin2.jpg" alt="">
			</figure>
			
			<div class="newpst-input">
				<form action="./Login.me" method="post" onsubmit="return write();">
					
					<textarea rows="2" placeholder="무슨 일이 일어나고 있나요?" id="content"></textarea>
					<div id="image_preview">
					</div>
					<div class="attachments">
						<ul>
							<li>
								<i class="fa fa-music"></i>
								<label class="fileContainer">
									<input type="file">
								</label>
							</li>
							<li>
								<i class="fa fa-image"></i>
								<label class="fileContainer" onclick="javascript:changeProfile()">
									<input type="file" id="image"  onchange="preview_image();" accept="image/*" multiple>
								</label>
							</li>
							<li>
								<i class="fa fa-video-camera"></i>
								<label class="fileContainer">
									<input type="file">
								</label>
							</li>
							<li>
								<button type="button" onclick="javascript: writeSomething();">게시</button>
								<!-- <button type="button" onclick="write();">게시</button> -->
							</li>
						</ul>
					</div>
					
					
				</form>
			</div>
		</div>
		
	</div>
	
	
	<script>
    
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
    	var html="<img src='"+URL.createObjectURL(event.target.files[i])+"' dataNum='"+ j +"' onclick='deleteImageAction("+ j +")' class='preview"+j+"' style='width:80px; height:80px;''>"
      	$('#image_preview').append(html);
      	alert(URL.createObjectURL(event.target.files[i]));      
     }
     window.URL.revokeObjectURL(objectURL);
    }
    
    function deleteImageAction(dataNum) {
              
        var preview = ".preview"+dataNum;
        alert(preview);
        
        $(preview).remove(); 
    }
    
    function changeProfile() {
        $('#image').click();
    }
	
    </script>
	
</body>
</html>