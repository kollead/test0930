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
				<form id="mediaForm" action="" method="post" method="post" enctype="multipart/form-data">
					
					<textarea rows="2" placeholder="무슨 일이 일어나고 있나요?" id="content"></textarea>
					<div id="image_preview">
					</div>
					
					<!-- 비디오 프리뷰 -->
					<div id="video_preview">
					<img id="vid_preview"/>
					<video style="display: none;" controls>
    					<source type="video/mp4" >
					</video>
					<canvas style="display: none;"></canvas>					
					</div>
					<!-- 비디오 프리뷰 -->
					
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
									<input type="file" name="file" id="vidInput" accept="video/mp4" onchange="preview_video();"/>
								</label>
							</li>
							<li>
								<button type="submit">게시</button>
								<!-- <button type="button" onclick="write();">게시</button> -->
							</li>
						</ul>
					</div>
					
					
				</form>
			</div>
		</div>
		
	</div>
	
	
	<script>
    //image preview
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
  //image preview
  
  
  //video preview
    function preview_video () {
	  
    	document.getElementById('mediaForm').action = './WriteBoard';
        var video = $("video");
        var thumbnail = $("canvas");
        var input = $("#vidInput");
        var ctx = thumbnail.get(0).getContext("2d");
        var duration = 0;
        var img = $("#vid_preview");

        
            var file = event.target.files[0];
            if (["video/mp4"].indexOf(file.type) === -1) {
                alert("Only 'MP4' video format allowed.");
                return;
            }
            
            video.find("source").attr("src", URL.createObjectURL(file));
            
            video.get(0).load();
            // Load metadata of the video to get video duration and dimensions
            video.on("loadedmetadata", function(e) {
                duration = video.get(0).duration;
                // Set canvas dimensions same as video dimensions
                thumbnail[0].width = video[0].videoWidth;
                thumbnail[0].height = video[0].videoHeight;
                // Set video current time to get some random image
                video[0].currentTime = Math.ceil(duration / 2);
                // Draw the base-64 encoded image data when the time updates
                video.one("timeupdate", function() {
                    ctx.drawImage(video[0], 0, 0, video[0].videoWidth, video[0].videoHeight);
                    img.attr('width', 100).attr('height', 100).attr("src", thumbnail[0].toDataURL());
                });
            });
          
    }
  //video preview
	
    </script>
	
</body>
</html>