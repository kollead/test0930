 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script> 
<script type="text/javascript">

	//이미지 정보들을 담을 배열
	var sel_files = [];
	var sel_video;
	
	$(document).ready(function() {
	    $("#imageFile").on("change", handleImgFileSelect);
	}); 
	
	function fileUploadAction() {
	    console.log("fileUploadAction");
	    $("#imageFile").trigger('click');
	}
	
	function handleImgFileSelect(e) {

        // 이미지 정보들을 초기화
        sel_files = [];
        $(".imgs_wrap").empty();
        
        // 파일 갯수 제한
        var x = document.getElementById("imageFile");
        var txt = "";
        if ('files' in x) {
            if (x.files.length > 5) {
                alert("파일 개수가 초과되었습니다. 5개까지 업로드가 가능 합니다.");
                document.getElementById("imageFile").value = "";
                return;
            }
        }

        var files = e.target.files;
        var filesArr = Array.prototype.slice.call(files);

        var index = 0;
        filesArr.forEach(function(f) {
			sel_files.push(f);

			var reader = new FileReader();
			reader.onload = function(e) {
				var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\">"
							+ "<img src=\"" + e.target.result + "\" data-file='" + f.name + "' class='imgFiles' width='80px' height='80px' class='selProductFile' title='Click to remove'>"
							+ "</a>";
				$(".imgs_wrap").append(html);
				
				index++;
            }
			
            reader.readAsDataURL(f);
        });
    }
	
	function deleteImageAction(index) {
	    console.log("index : "+index);
	    console.log("sel length : "+sel_files.length);
	
	    sel_files.splice(index, 1);
	    alert("delete files: " + sel_files);
	    
	    var img_id = "#img_id_"+index;
	    $(img_id).remove(); 
	}

	function insertBoard() {
 	
 		alert("업로드 파일 갯수 : "+sel_files.length);
		var data = new FormData();

        for(var i=0, len=sel_files.length; i<len; i++) {
            var name = "image_"+i;
            data.append(name, sel_files[i]);
        }
        data.append("content", $("#content").val());
        data.append("imgCnt", sel_files.length);
        data.append("video", document.getElementByID("vidInput").files[0]);
        
        var xhr = new XMLHttpRequest();
        xhr.open("POST","./BoardInsertServlet");
        xhr.onload = function(e) {
            if(this.status == 200) {
                console.log("Result : "+e.currentTarget.responseText);
            }
        }
        xhr.send(data);
	}
	
	function preview_video () {
        var video = $("video");
        var thumbnail = $("canvas");
        var input = $("#vidInput");
        var ctx = thumbnail.get(0).getContext("2d");
        var duration = 0;
        var img = $("#vid_preview");

        
            var file = event.target.files[0];
            sel_video=event.target.files[0];
            alert("sel: "+URL.createObjectURL(sel_video));
            
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
</script>
	<div class="central-meta new-pst">
		<div class="new-postbox">
			<figure>
				<img src="./images/resources/admin2.jpg" alt="">
			</figure>
			<div class="newpst-input">
				<form id="writeBoard" enctype="multipart/form-data">
					
					<textarea rows="2" placeholder="무슨 일이 일어나고 있나요?" id="content" name="content"></textarea>
					<div>
						<div class="imgs_wrap">
							<img id="img" />
						</div>
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
								<i class="fa fa-image" ></i>
								<label class="fileContainer">
									<input type="file" id="imageFile" name="imageFile[]" accept=".gif, .jpg, .png" onclick="fileUploadAction();" multiple />
								</label>
							</li>
							<li>
								<i class="fa fa-video-camera"></i>
								<label class="fileContainer">
									<input type="file" name="file" id="vidInput" accept="video/mp4" onchange="preview_video();"/>
								</label>
							</li>
							<li>
								<button type="submit" onclick="javascript : insertBoard();">게시</button>
								<!-- <button type="button" onclick="write();">게시</button> -->
							</li>
						</ul>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script src="../js/main.min.js"></script>
	<script src="../js/script.js"></script>