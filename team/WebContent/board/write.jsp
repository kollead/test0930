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
								<label class="fileContainer">
									<input type="file">
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
</body>
</html>