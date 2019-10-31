<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="" />
<meta name="keywords" content="" />

<title>Winku Social Network Toolkit</title>

<link rel="icon" href="./images/fav.png" type="image/png" sizes="16x16">
<link rel="stylesheet" href="./css/main.min.css">
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/color.css">
<link rel="stylesheet" href="./css/responsive.css">

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script> 
<script type="text/javascript">
$(document).ready(function(){

	//댓글 로드
	commLoad();	

});

//jQuery(".post-comt-box textarea").on("keydown", function(event) {scriptjs 삭제

function commLoad(){//코멘트를 로딩하는 펑션. post를 로딩할 때 commLoad() / commLoad(b_num)달아주시면 됩니다!
	
				
	var bNum=1/* $().attr(post의 숨겨진 input의 bName).val();/data  보드넘버!!!*/ 
	var comment_HTML; //코멘트 html
	var getNum;	//더 불러올 코멘트의 갯수
	var role;//email 세션값!!!
	
	
	if($("#role").val()!=null){//email 세션 
		role=$("#role").val();
	}else{role="";}
	alert(role);
	
	
	if($("#showMoreNum").val()!=null){
		getNum=$("#showMoreNum").val();
	}else{
		getNum=0;
	}
	alert("loadMore getNum: "+getNum);
	
	//기본 post comm 로딩(5개)
	$.ajax({
		url:"./CommentReadServlet",
		type: "POST",
		data: {bNum:bNum, getNum:getNum},
		dataType: "json",
		success: function(data){	
			alert("success");
			
				for(var i = 0; i < data.length; i++){						
					
					
					if(+data[i].re_lev>0){
						comment_HTML ='<ul id="commPara'+data[i].c_num+'"><li style="margin-left:'+(+data[i].re_lev*2)+'%;"';
					}else{
					comment_HTML = '<li id="commPara'+data[i].c_num+'"';}
					
					comment_HTML +='><div class="comet-avatar"><img src="images/resources/comet-1.jpg" alt=""></div><div class="we-comment"><div class="coment-head"><h5><a href="time-line.html" title="">'+data[i].l_name+' '+data[i].f_name+'</a></h5><span>'+data[i].c_date+'</span><a class="we-reply" href="javascript:toggleReply('+data[i].c_num+');" title="Reply"><i class="fa fa-reply"></i></a>';
					
					if(role==data[i].email){
						comment_HTML+='<div class="more"><span class="more-optns"><i class="ti-more-alt"></i><ul><li onclick="toggleUpdate('+data[i].c_num+')"> 수정 </li><li onclick="commDelete('+data[i].c_num+')"> 삭제 </li></ul></span></div></div>';
					}
					
					comment_HTML +='<p id="commContentP'+data[i].c_num+'">'+data[i].c_content+'</p></div></li>';
					//.we-comet p {
					//word-break: break-all;
					//} style.css
					
					/* .we-comet .more {
						float: right;
						box-sizing: border-box;
					}
					
					.we-comet .more ul{
						width: 50px;
						height: 50px;
					}
					
					.we-comet .more ul li{
						display: inline-block;
					    font-size: 11px;
					    line-height: 5px;
					    width: 100%;
					} */
					
					
					comment_HTML +='<li class="post-comment post-reComment'+data[i].c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="reCommText'+data[i].c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commReInsert('+data[i].c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">게시</button></form></div></li>';
					comment_HTML +='<li class="post-comment post-updateComment'+data[i].c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="upCommText'+data[i].c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commUpdate('+data[i].c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">수정</button></form></div></li><div id="replyDiv'+data[i].c_num+'"></div>';					
					
					if(data[i].re_lev>0){
						comment_HTML +='</ul>';
					}
										
					$(".we-comet").prepend(comment_HTML);	//.we-comet에 보드넘버 붙여주기				
				}
			
		},
		error: function(data){
			// 에러 메세지
			if (jqXHR.status === 0) {
				alert('commLoad - Not connect.\n Verify Network.');
			} else if (jqXHR.status == 400) {
				alert('commLoad - Server understood the request, but request content was invalid. [400]');
			} else if (jqXHR.status == 401) {
				alert('commLoad - Unauthorized access. [401]');
			} else if (jqXHR.status == 403) {
				alert('commLoad - Forbidden resource can not be accessed. [403]');
			} else if (jqXHR.status == 404) {
				alert('commLoad - Requested page not found. [404]');
			} else if (jqXHR.status == 500) {
				alert('commLoad - Internal server error. [500]');
			} else if (jqXHR.status == 503) {
				alert('commLoad - Service unavailable. [503]');
			} else if (exception === 'parsererror') {
				alert('commLoad - Requested JSON parse failed. [Failed]');
			} else if (exception === 'timeout') {
				alert('commLoad - Time out error. [Timeout]');
			} else if (exception === 'abort') {
				alert('commLoad - Ajax request aborted. [Aborted]');
			} else {
				alert('commLoad - Uncaught Error.n' + jqXHR.responseText);
			}
		}
	});
			
	$("#showMoreLi").remove();
	alert("remove!!!");	
	
	//추가 로딩이 필요할 때 more comment 
	$.ajax({
		url:"./CommentLengthServlet",
		type: "POST",
		data: {bNum:bNum},
		dataType: "json",
		success: function(data){	
			alert("success");
			var lengthNum=data.number;
			alert(lengthNum);
			alert("loadMore getNum: "+getNum);//getNum=1
			alert(+getNum+1);//11???>getNum이 String으로 인식되므로 앞에 +를 붙여주면 된다 
			alert(5*(+getNum+1))//55
			if((lengthNum-(5*(+getNum+1)))>0){
				comment_HTML='<li id="showMoreLi"><a href="javascript:commLoad();" title="" class="showmore underline">more comments</a><input type="hidden" value="'+(+getNum+1)+'" id="showMoreNum"></li>'
				$(".we-comet").prepend(comment_HTML);				
			}
		},
		error: function(data){
			// 에러 메세지
			if (jqXHR.status === 0) {
				alert('commLoad2 - Not connect.\n Verify Network.');
			} else if (jqXHR.status == 400) {
				alert('commLoad2 - Server understood the request, but request content was invalid. [400]');
			} else if (jqXHR.status == 401) {
				alert('commLoad2 - Unauthorized access. [401]');
			} else if (jqXHR.status == 403) {
				alert('commLoad2 - Forbidden resource can not be accessed. [403]');
			} else if (jqXHR.status == 404) {
				alert('commLoad2 - Requested page not found. [404]');
			} else if (jqXHR.status == 500) {
				alert('commLoad2 - Internal server error. [500]');
			} else if (jqXHR.status == 503) {
				alert('commLoad2 - Service unavailable. [503]');
			} else if (exception === 'parsererror') {
				alert('commLoad2 - Requested JSON parse failed. [Failed]');
			} else if (exception === 'timeout') {
				alert('commLoad2 - Time out error. [Timeout]');
			} else if (exception === 'abort') {
				alert('commLoad2 - Ajax request aborted. [Aborted]');
			} else {
				alert('commLoad2 - Uncaught Error.n' + jqXHR.responseText);
			}
		}
	});
		
}



function commInsert(){//script.js의 Post a Comment 수정
	alert("commButton");
	var content=$("#commText").val();
	var bNum=1/* $().attr(숨겨진 input의 bName).val(); */	
	var newComment_HTML;
	alert(content);
	if(content!=null){//json 가져와 댓글 번호/댓글 시간/댓글쓴이 모두 뿌리기 
		$.ajax({
			url:"./CommentInsertServlet",
			type: "POST",
			data: {content:content, bNum:bNum},
			dataType: "json",
			success: function(data){
				alert("success");
				/*  newComment_HTML = '<ul><li><div class="comet-avatar"><img src="images/resources/comet-1.jpg" alt=""></div><div class="we-comment"><div class="coment-head"><h5><a href="time-line.html" title="">'+data+'</a></h5><span>now</span><a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a></div><p>'+content+'</p></div></li></ul>';
				 */
				 newComment_HTML ='<ul><li id="commPara'+data.c_num+'"><div class="comet-avatar"><img src="images/resources/comet-1.jpg" alt=""></div><div class="we-comment"><div class="coment-head"><h5><a href="time-line.html" title="">'+data.l_name+' '+data.f_name+'</a></h5><span>'+data.c_date+'</span><a class="we-reply" href="javascript:toggleReply('+data.c_num+');" title="Reply"><i class="fa fa-reply"></i></a>';
				 newComment_HTML +='<div class="more"><span class="more-optns"><i class="ti-more-alt"></i><ul><li onclick="toggleUpdate('+data.c_num+')"> 수정 </li><li onclick="commDelete('+data.c_num+')"> 삭제 </li></ul></span></div></div>';
				 newComment_HTML +='<p id="commContentP'+data.c_num+'">'+data.c_content+'</p></div></li>';				 
				 
				 newComment_HTML +='<li class="post-comment post-reComment'+data.c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="reCommText'+data.c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commReInsert('+data.c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">게시</button></form></div></li>';
				 newComment_HTML +='<li class="post-comment post-updateComment'+data.c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="upCommText'+data.c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commUpdate('+data.c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">수정</button></form></div></li><div id="replyDiv'+data.c_num+'"></div></ul>';		
				 
				 $(newComment_HTML).prependTo("#newCommt<%-- <%=보드넘버달기 %> --%>");//<li class="post-comment"> 위에 새 div인 newCommt를 추가했습니다
								
				 $(".post-comt-box textarea").val('');
			}, 
			error: function(data){
				// 에러 메세지
				if (jqXHR.status === 0) {
					alert('commInsert - Not connect.\n Verify Network.');
				} else if (jqXHR.status == 400) {
					alert('commInsert - Server understood the request, but request content was invalid. [400]');
				} else if (jqXHR.status == 401) {
					alert('commInsert - Unauthorized access. [401]');
				} else if (jqXHR.status == 403) {
					alert('commInsert - Forbidden resource can not be accessed. [403]');
				} else if (jqXHR.status == 404) {
					alert('commInsert - Requested page not found. [404]');
				} else if (jqXHR.status == 500) {
					alert('commInsert - Internal server error. [500]');
				} else if (jqXHR.status == 503) {
					alert('commInsert - Service unavailable. [503]');
				} else if (exception === 'parsererror') {
					alert('commInsert - Requested JSON parse failed. [Failed]');
				} else if (exception === 'timeout') {
					alert('commInsert - Time out error. [Timeout]');
				} else if (exception === 'abort') {
					alert('commInsert - Ajax request aborted. [Aborted]');
				} else {
					alert('commInsert - Uncaught Error.n' + jqXHR.responseText);
				}
			}
		});			
	}
}

function toggleReply(data){//reply 창
	var c_num=data;
	alert("reply");
	alert(c_num);
		
	$(".post-reComment"+c_num).toggle();
	
}

function commReInsert(data){//reply 창 내용물 입력하기  //reInsert 대댓글 텍스트 아레아  안 밀리게 
		
	alert("commButton");
	var c_num=data;
	var content=$("#reCommText"+c_num).val();	//reCommText'+data[i].c_num+
	var newComment_HTML;
	var c_num=data;
	
	alert(content);
	
	if(content!=null){//json 가져와 댓글 번호/댓글 시간/댓글쓴이 모두 뿌리기 
		$.ajax({
			url:"./CommentReInsertServlet",
			type: "POST",
			data: {content:content, c_num:c_num},
			dataType: "json",
			success: function(data){
				alert("success");
				
				newComment_HTML ='<ul id="commPara'+data.c_num+'"><li style="margin-left:'+(+data.re_lev*2)+'%;"';
				newComment_HTML +='><div class="comet-avatar"><img src="images/resources/comet-1.jpg" alt=""></div><div class="we-comment"><div class="coment-head"><h5><a href="time-line.html" title="">'+data.l_name+' '+data.f_name+'</a></h5><span>'+data.c_date+'</span><a class="we-reply" href="javascript:toggleReply('+data.c_num+');" title="Reply"><i class="fa fa-reply"></i></a>';
				newComment_HTML+='<div class="more"><span class="more-optns"><i class="ti-more-alt"></i><ul><li onclick="toggleUpdate('+data.c_num+')"> 수정 </li><li onclick="commDelete('+data.c_num+')"> 삭제 </li></ul></span></div></div>';
				newComment_HTML +='<p id="commContentP'+data.c_num+'">'+data.c_content+'</p></div></li>';
				
				newComment_HTML +='<li class="post-comment post-reComment'+data.c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="reCommText'+data.c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commReInsert('+data.c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">게시</button></form></div></li>';
				newComment_HTML +='<li class="post-comment post-updateComment'+data.c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="upCommText'+data.c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commUpdate('+data.c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">수정</button></form></div></li><div id="replyDiv'+data.c_num+'"></div></ul>';		
				 
				/*   newComment_HTML = '<ul><li style="margin-left:'+(+re_lev*2)+'%;"><div class="comet-avatar"><img src="images/resources/comet-1.jpg" alt=""></div><div class="we-comment"><div class="coment-head"><h5><a href="time-line.html" title="">'+name+'</a></h5><span>now</span><a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a></div><p>'+content+'</p></div></li><div></div></ul>';
				 */$(newComment_HTML).prependTo("#replyDiv"+c_num);//div id="replyDiv'+data[i].c_num+'"
				
				 
				 $("#reCommText"+c_num).val('');
			},
			error: function(data){
				// 에러 메세지
				if (jqXHR.status === 0) {
					alert('commReInsert - Not connect.\n Verify Network.');
				} else if (jqXHR.status == 400) {
					alert('commReInsert - Server understood the request, but request content was invalid. [400]');
				} else if (jqXHR.status == 401) {
					alert('commReInsert - Unauthorized access. [401]');
				} else if (jqXHR.status == 403) {
					alert('commReInsert - Forbidden resource can not be accessed. [403]');
				} else if (jqXHR.status == 404) {
					alert('commReInsert - Requested page not found. [404]');
				} else if (jqXHR.status == 500) {
					alert('commReInsert - Internal server error. [500]');
				} else if (jqXHR.status == 503) {
					alert('commReInsert - Service unavailable. [503]');
				} else if (exception === 'parsererror') {
					alert('commReInsert - Requested JSON parse failed. [Failed]');
				} else if (exception === 'timeout') {
					alert('commReInsert - Time out error. [Timeout]');
				} else if (exception === 'abort') {
					alert('commReInsert - Ajax request aborted. [Aborted]');
				} else {
					alert('commReInsert - Uncaught Error.n' + jqXHR.responseText);
				}
			}
		});			
	}
			
	toggleReply(c_num);
	
}


//onclick="commUpdate('+data[i].c_num+')"> 수정 </li><li onclick="commDelete('+data[i].c_num+')"> 삭제

function commDelete(data){	
	var c_num=data;	
	$.ajax({
		url:"./CommentDeleteServlet",
		type: "POST",
		data: {c_num:c_num},
		dataType: "text",
		success: function(data){	
			alert("삭제가 완료되었습니다");	
			// id="commPara'+data[i].c_num+'"
			//class="post-comment post-reComment'+data[i].c_num+'"
			$("#commPara"+c_num).remove();
			$(".post-reComment"+c_num).remove();
			$(".post-updateComment"+c_num).remove(); 	
			
		},
		error: function(data){
			// 에러 메세지
			if (jqXHR.status === 0) {
				alert('commDelete - Not connect.\n Verify Network.');
			} else if (jqXHR.status == 400) {
				alert('commDelete - Server understood the request, but request content was invalid. [400]');
			} else if (jqXHR.status == 401) {
				alert('commDelete - Unauthorized access. [401]');
			} else if (jqXHR.status == 403) {
				alert('commDelete - Forbidden resource can not be accessed. [403]');
			} else if (jqXHR.status == 404) {
				alert('commDelete - Requested page not found. [404]');
			} else if (jqXHR.status == 500) {
				alert('commDelete - Internal server error. [500]');
			} else if (jqXHR.status == 503) {
				alert('commDelete - Service unavailable. [503]');
			} else if (exception === 'parsererror') {
				alert('commDelete - Requested JSON parse failed. [Failed]');
			} else if (exception === 'timeout') {
				alert('commDelete - Time out error. [Timeout]');
			} else if (exception === 'abort') {
				alert('commDelete - Ajax request aborted. [Aborted]');
			} else {
				alert('commDelete - Uncaught Error.n' + jqXHR.responseText);
			}
		}
	});
	
}

function toggleUpdate(data){
	var c_num=data;
	alert("tryUpdate");
	
	$(".post-updateComment"+c_num).toggle();
	$("#upCommText"+c_num).val($("#commContentP"+c_num).text());
		
}

function commUpdate(data){
	//jQuery(".post-comt-box textarea").on("keydown", function(event) {
	//script.js 확인	
	var c_num=data;
	var content=$("#upCommText"+c_num).val();
	
	$.ajax({
		url:"./CommentUpdateServlet",
		type: "POST",
		data: {c_num:c_num, content:content},
		dataType: "text",
		success: function(data){	
			alert("변경이 완료되었습니다");				
			$("#commContentP"+c_num).text(content);
			$(".post-updateComment"+c_num).toggle();
		},
		error: function(data){
			// 에러 메세지
			if (jqXHR.status === 0) {
				alert('commUpdate - Not connect.\n Verify Network.');
			} else if (jqXHR.status == 400) {
				alert('commUpdate - Server understood the request, but request content was invalid. [400]');
			} else if (jqXHR.status == 401) {
				alert('commUpdate - Unauthorized access. [401]');
			} else if (jqXHR.status == 403) {
				alert('commUpdate - Forbidden resource can not be accessed. [403]');
			} else if (jqXHR.status == 404) {
				alert('commUpdate - Requested page not found. [404]');
			} else if (jqXHR.status == 500) {
				alert('commUpdate - Internal server error. [500]');
			} else if (jqXHR.status == 503) {
				alert('commUpdate - Service unavailable. [503]');
			} else if (exception === 'parsererror') {
				alert('commUpdate - Requested JSON parse failed. [Failed]');
			} else if (exception === 'timeout') {
				alert('commUpdate - Time out error. [Timeout]');
			} else if (exception === 'abort') {
				alert('commUpdate - Ajax request aborted. [Aborted]');
			} else {
				alert('commUpdate - Uncaught Error.n' + jqXHR.responseText);
			}
		}
	});
	
}
	


 /* function date(data){
	//날짜 차이 구해주기
	alert(data);
	
	  var time1=Math.floor(data/1000);
	var time2=Math.floor(+ new Date()/ 1000);
	
	var time1=data;
	var time2=targetDate.getTime();
	var time3=time2-time1; 
	
	var time3=Math.floor(data/1000);
	
	
	alert(time3);
	
	var minute=60*60;
	var hour=minute*60;
	var day=hour*24;
	var year=day*365;
	
	if(time3>year){
		time3=Math.ceil(time3/year)+"년 전";
	}else if(time3>day){
		time3=Math.ceil(time3/day)+"일 전";
	}else if(time3>hour){
		time3=Math.ceil(time3/hour)+"시간 전";
	}else if(time3>minute){
		time3=Math.ceil(time3/minute)+"분 전";
	}else {
		time3=time3+"초 전";
	}
	
	alert("시간차"+time3);
	
	return time3;
} */

</script>

</head>
<body>

	<% String email="";	
		email=request.getSession().getAttribute("email").toString();%>
		
	<input type="hidden" id="role" value=<%=email %> />

	<!--<div class="se-pre-con"></div>-->
	<div class="theme-layout">
		<div class="postoverlay"></div>

		<!-- 웹페이지 상단 -->
		<jsp:include page="../inc/webTop.jsp" />
		<!-- /웹페이지 상단 -->

		<!-- 웹페이지 오른쪽 채팅 바 -->
		<div class="fixed-sidebar right">
			<div class="chat-friendz">
				<ul class="chat-users">
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend1.jpg" alt="">
							<span class="status f-online"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend2.jpg" alt="">
							<span class="status f-away"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend3.jpg" alt="">
							<span class="status f-online"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend4.jpg" alt="">
							<span class="status f-offline"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend5.jpg" alt="">
							<span class="status f-online"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend6.jpg" alt="">
							<span class="status f-online"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend7.jpg" alt="">
							<span class="status f-offline"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend8.jpg" alt="">
							<span class="status f-online"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend9.jpg" alt="">
							<span class="status f-away"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend10.jpg" alt="">
							<span class="status f-away"></span>
						</div>
					</li>
					<li>
						<div class="author-thmb">
							<img src="./images/resources/side-friend8.jpg" alt="">
							<span class="status f-online"></span>
						</div>
					</li>
				</ul>
				<div class="chat-box">
					<div class="chat-head">
						<span class="status f-online"></span>
						<h6>Bucky Barnes</h6>
						<div class="more">
							<span class="more-optns"><i class="ti-more-alt"></i>
								<ul>
									<li>block chat</li>
									<li>unblock chat</li>
									<li>conversation</li>
								</ul>
							</span>
							<span class="close-mesage"><i class="ti-close"></i></span>
						</div>
					</div>
					<div class="chat-list">
						<ul>
							<li class="me">
								<div class="chat-thumb">
									<img src="./images/resources/chatlist1.jpg" alt="">
								</div>
								<div class="notification-event">
									<span class="chat-message-item">
										Hi James! Please
										remember to buy the food for tomorrow! I’m gonna be handling
										the gifts and Jake’s gonna get the drinks
									</span>
									<span class="notification-date">
										<time datetime="2004-07-24T18:18" class="entry-date updated">
											Yesterday at 8:10pm
										</time>
									</span>
								</div>
							</li>
							<li class="you">
								<div class="chat-thumb">
									<img src="./images/resources/chatlist2.jpg" alt="">
								</div>
								<div class="notification-event">
									<span class="chat-message-item">
										Hi James! Please
										remember to buy the food for tomorrow! I’m gonna be handling
										the gifts and Jake’s gonna get the drinks
									</span>
									<span class="notification-date">
										<time datetime="2004-07-24T18:18" class="entry-date updated">
											Yesterday at 8:10pm
										</time>
									</span>
								</div>
							</li>
							<li class="me">
								<div class="chat-thumb">
									<img src="./images/resources/chatlist1.jpg" alt="">
								</div>
								<div class="notification-event">
									<span class="chat-message-item">
										Hi James! Please
										remember to buy the food for tomorrow! I’m gonna be handling
										the gifts and Jake’s gonna get the drinks
									</span>
									<span class="notification-date">
										<time datetime="2004-07-24T18:18" class="entry-date updated">
										Yesterday at 8:10pm
										</time>
									</span>
								</div>
							</li>
						</ul>
						<form class="text-box">
							<textarea placeholder="Post enter to post..."></textarea>
							<div class="add-smiles">
								<span title="add icon" class="em em-expressionless"></span>
							</div>
							<div class="smiles-bunch">
								<i class="em em---1"></i>
								<i class="em em-smiley"></i>
								<i class="em em-anguished"></i>
								<i class="em em-laughing"></i>
								<i class="em em-angry"></i>
								<i class="em em-astonished"></i>
								<i class="em em-blush"></i>
								<i class="em em-disappointed"></i>
								<i class="em em-worried"></i>
								<i class="em em-kissing_heart"></i>
								<i class="em em-rage"></i>
								<i class="em em-stuck_out_tongue"></i>
							</div>
							<button type="submit"></button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<section>
		<div class="gap2 gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="row merged20" id="page-contents">
							<!-- 왼쪽 사이드 -->
							<div class="col-lg-3">
								<aside class="sidebar static left">
								
									<!-- Shortcuts -->
									<jsp:include page="../inc/shortcuts.jsp" />
									<!-- /Shortcuts -->
									
									<!-- Who's follownig -->
									<div class="widget stick-widget">
										<h4 class="widget-title">Who's follownig</h4>
										<ul class="followers">
											<li>
												<figure>
													<img src="./images/resources/friend-avatar2.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Kelly Bill</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar4.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Issabel</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar6.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Andrew</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar8.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Sophia</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar3.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Allen</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
										</ul>
									</div>
									<!-- /who's following -->
								</aside>
							</div>
							<!-- /왼쪽 사이드 -->
							
							<!-- 중간 -->
							<div class="col-lg-6">
								<!-- 글 작성 -->
								<jsp:include page="../board/write.jsp" />
								<!-- /글 작성 -->

								<!-- 뉴스피드 -->
								<div class="loadMore">
									<!-- 게시글1 -->
									<div class="central-meta item">
										<div class="user-post">
											<div class="friend-info">
												<!-- 게시글의 작성자 사진 -->
												<figure>
													<img src="./images/resources/friend-avatar10.jpg" alt="">
												</figure>
												<!-- /게시글의 작성자 사진 -->

												<!-- 게시글의 작성자 이름/날짜정보 -->
												<div class="friend-name">
													<ins>
														<a href="time-line.html" title="">Janice Griffith</a>
													</ins>
													<span>published: june,2 2018 19:PM</span>
												</div>
												<!-- /게시글의 작성자 이름/날짜정보 -->

												<!-- 게시글 내용 -->
												<div class="post-meta">
													<img src="./images/resources/user-post.jpg" alt="">
													<!-- 조회수, 답글수, 좋아요, 싫어요, 공유 -->
													<div class="we-video-info">
														<ul>
															<li>
																<span class="views" data-toggle="tooltip" title="views">
																	<i class="fa fa-eye"></i> <ins>1.2k</ins>
																</span>
															</li>
															<li>
																<span class="comment" data-toggle="tooltip" title="Comments">
																	<i class="fa fa-comments-o"></i> <ins>52</ins>
																</span>
															</li>
															<li>
																<span class="like" data-toggle="tooltip" title="like">
																<i class="ti-heart"></i> <ins>2.2k</ins>
																</span>
															</li>
															<!-- <li>
																<span class="dislike" data-toggle="tooltip" title="dislike">
																	<i class="ti-heart-broken"></i>
																	<ins>200</ins>
																</span>
															</li> -->
															<li class="social-media">
																<div class="menu">
																	<div class="btn trigger">
																		<i class="fa fa-share-alt"></i>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-html5"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-facebook"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-google-plus"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-twitter"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-css3"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-instagram"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-dribbble"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-pinterest"></i></a>
																		</div>
																	</div>

																</div>
															</li>
														</ul>
													</div>
													<!-- /조회수, 답글수, 좋아요, 싫어요, 공유 -->
													<div class="description">
														<p>
															World's most beautiful car in Curabitur <a href="#"
																title="">#test drive booking !</a> the most beatuiful
															car available in america and the saudia arabia, you can
															book your test drive by our official website
														</p>
													</div>
												</div>
												<!-- /게시글 내용 -->
											</div>

											<!-- 댓글 -->
											<div class="coment-area" id="commarea1"><!-- boardNum 달아줘야 -->
												<ul class="we-comet<%-- <%=보드넘버달기%> --%>">
												
												
												
														
												<div id="newCommt"></div>
												<li class="post-comment">
													<div class="comet-avatar">
														<img src="./images/resources/comet-1.jpg" alt="">
														</div>														
														<!-- 답글 작성란 -->
														<div class="post-comt-box">
															<form method="post">
																<textarea id="commText" placeholder="Post your comment"></textarea>																										
																<button id="formButton" type="button" onclick="javascript:commInsert(<%-- <%=보드넘버달기 %> --%>);" style="float: right; margin-bottom:5px; margin-right:5px;">게시</button>																
															</form>															
														</div>
														<!-- /답글 작성란 -->
												<!-- 	.post-comt-box form textarea {
												    background: #f3f3f3 none repeat scroll 0 0;
												    border-color: transparent;
												    border-radius: 3px;
												    color: #696969;
												    font-size: 13px;
												    font-weight: 400;
												    height: 40px;
												    line-height: 16px;
												    display: inline-block;수
												    max-width: 80%;정
												} -->
														
													</li>
												</ul>
											</div>
										</div>
									</div>
									<!-- /게시글1 -->
									
									<div class="central-meta item">
										<div class="user-post">
											<div class="friend-info">
												<figure>
													<img src="./images/resources/nearly1.jpg" alt="">
												</figure>
												<div class="friend-name">
													<ins>
														<a href="time-line.html" title="">Sara Grey</a>
													</ins>
													<span>published: june,2 2018 19:PM</span>
												</div>
												<div class="post-meta">
													<iframe width="" height="285"
														src="https://www.youtube.com/embed/_-StQsHSTz0"
														frameborder="0" allowfullscreen>
													</iframe>
													<div class="we-video-info">
														<ul>
															<li>
																<span class="views" data-toggle="tooltip" title="views">
																	<i class="fa fa-eye"></i> <ins>1.2k</ins>
																</span>
															</li>
															<li>
																<span class="comment" data-toggle="tooltip" title="Comments">
																	<i class="fa fa-comments-o"></i> <ins>52</ins>
																</span>
															</li>
															<li>
																<span class="like" data-toggle="tooltip" title="like">
																	<i class="ti-heart"></i> <ins>2.2k</ins>
																</span>
															</li>
															<li>
																<span class="dislike" data-toggle="tooltip" title="dislike">
																	<i class="ti-heart-broken"></i> <ins>200</ins>
																</span>
															</li>
															<li class="social-media">
																<div class="menu">
																	<div class="btn trigger">
																		<i class="fa fa-share-alt"></i>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-html5"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-facebook"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-google-plus"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-twitter"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-css3"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-instagram"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-dribbble"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-pinterest"></i></a>
																		</div>
																	</div>

																</div>
															</li>
														</ul>
													</div>
													<div class="description">

														<p>
															Lonely Cat Enjoying in Summer Curabitur
															<a href="#" title="">#mypage</a> ullamcorper ultricies nisi. Nam
															eget dui. Etiam rhoncus. Maecenas tempus, tellus eget
															condimentum rhoncus, sem quam semper libero, sit amet
															adipiscing sem neque sed ipsum. Nam quam nunc,
														</p>
													</div>
												</div>
											</div>
											<div class="coment-area">
												<ul class="we-comet">
													<li>
														<div class="comet-avatar">
															<img src="./images/resources/comet-1.jpg" alt="">
														</div>
														<div class="we-comment">
															<div class="coment-head">
																<h5>
																	<a href="time-line.html" title="">Jason borne</a>
																</h5>
																<span>1 year ago</span>
																<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
															</div>
															<p>
																we are working for the dance and sing songs. this
																video is very awesome for the youngster. please vote
																this video and like our channel
															</p>
														</div>
													</li>
													<li>
														<div class="comet-avatar">
															<img src="./images/resources/comet-2.jpg" alt="">
														</div>
														<div class="we-comment">
															<div class="coment-head">
																<h5>
																	<a href="time-line.html" title="">Sophia</a>
																</h5>
																<span>1 week ago</span>
																<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
															</div>
															<p>
																we are working for the dance and sing songs. this video
																is very awesome for the youngster.
																<i class="em em-smiley"></i>
															</p>
														</div>
													</li>
													<li>
														<a href="#" title="" class="showmore underline">more comments</a>
													</li>
													<li class="post-comment">
														<div class="comet-avatar">
															<img src="./images/resources/comet-2.jpg" alt="">
														</div>
														<div class="post-comt-box">
															<form method="post">
																<textarea placeholder="Post your comment"></textarea>
																<div class="add-smiles">
																	<span class="em em-expressionless" title="add icon"></span>
																</div>
																<div class="smiles-bunch">
																	<i class="em em---1"></i>
																	<i class="em em-smiley"></i>
																	<i class="em em-anguished"></i>
																	<i class="em em-laughing"></i>
																	<i class="em em-angry"></i>
																	<i class="em em-astonished"></i>
																	<i class="em em-blush"></i>
																	<i class="em em-disappointed"></i>
																	<i class="em em-worried"></i>
																	<i class="em em-kissing_heart"></i>
																	<i class="em em-rage"></i>
																	<i class="em em-stuck_out_tongue"></i>
																</div>
																<button id="formButton" type="submit"></button>
															</form>
														</div>
													</li>
												</ul>
											</div>
										</div>
									</div>
									<div class="central-meta item">
										<div class="user-post">
											<div class="friend-info">
												<figure>
													<img src="./images/resources/nearly6.jpg" alt="">
												</figure>
												<div class="friend-name">
													<ins>
														<a href="time-line.html" title="">Sophia</a>
													</ins>
													<span>published: january,5 2018 19:PM</span>
												</div>
												<div class="post-meta">
													<div class="post-map">
														<div class="nearby-map">
															<div id="map-canvas"></div>
														</div>
													</div>
													<!-- near by map -->
													<div class="we-video-info">
														<ul>
															<li>
																<span class="views" data-toggle="tooltip" title="views">
																	<i class="fa fa-eye"></i> <ins>1.2k</ins>
																</span>
															</li>
															<li>
																<span class="comment" data-toggle="tooltip" title="Comments">
																	<i class="fa fa-comments-o"></i> <ins>52</ins>
																</span>
															</li>
															<li>
																<span class="like" data-toggle="tooltip" title="like">
																<i class="ti-heart"></i> <ins>2.2k</ins>
																</span>
															</li>
															<li>
																<span class="dislike" data-toggle="tooltip" title="dislike">
																	<i class="ti-heart-broken"></i> <ins>200</ins>
																</span>
																</li>
															<li class="social-media">
																<div class="menu">
																	<div class="btn trigger">
																		<i class="fa fa-share-alt"></i>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-html5"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-facebook"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-google-plus"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-twitter"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-css3"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-instagram"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-dribbble"></i></a>
																		</div>
																	</div>
																	<div class="rotater">
																		<div class="btn btn-icon">
																			<a href="#" title=""><i class="fa fa-pinterest"></i></a>
																		</div>
																	</div>
																</div>
															</li>
														</ul>
													</div>
													
													<div class="description">
														<p>
															Curabitur Lonely Cat Enjoying in Summer
															<a href="#" title="">#mypage</a> ullamcorper ultricies nisi. Nam
															eget dui. Etiam rhoncus. Maecenas tempus, tellus eget
															condimentum rhoncus, sem quam semper libero, sit amet
															adipiscing sem neque sed ipsum. Nam quam nunc,
														</p>
													</div>
												</div>
											</div>
											
											<div class="coment-area">
												<ul class="we-comet">
													<li>
														<div class="comet-avatar">
															<img src="./images/resources/comet-1.jpg" alt="">
														</div>
														<div class="we-comment">
															<div class="coment-head">
																<h5>
																	<a href="time-line.html" title="">Jason borne</a>
																</h5>
																<span>1 year ago</span>
																<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
															</div>
															<p>
																we are working for the dance and sing songs. this
																video is very awesome for the youngster. please vote
																this video and like our channel
															</p>
														</div>
													</li>
													<li>
														<div class="comet-avatar">
															<img src="./images/resources/comet-2.jpg" alt="">
														</div>
														<div class="we-comment">
															<div class="coment-head">
																<h5>
																	<a href="time-line.html" title="">Sophia</a>
																</h5>
																<span>1 week ago</span>
																<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
															</div>
															<p>
																we are working for the dance and sing songs. this video
																is very awesome for the youngster.
																<i class="em em-smiley"></i>
															</p>
														</div>
													</li>
													<li>
														<a href="#" title="" class="showmore underline">more comments</a>
													</li>
													<li class="post-comment">
														<div class="comet-avatar">
															<img src="./images/resources/comet-2.jpg" alt="">
														</div>
														<div class="post-comt-box">
															<form method="post">
																<textarea placeholder="Post your comment"></textarea>
																<div class="add-smiles">
																	<span class="em em-expressionless" title="add icon"></span>
																</div>
																<div class="smiles-bunch">
																	<i class="em em---1"></i>
																	<i class="em em-smiley"></i>
																	<i class="em em-anguished"></i>
																	<i class="em em-laughing"></i>
																	<i class="em em-angry"></i>
																	<i class="em em-astonished"></i>
																	<i class="em em-blush"></i>
																	<i class="em em-disappointed"></i>
																	<i class="em em-worried"></i>
																	<i class="em em-kissing_heart"></i>
																	<i class="em em-rage"></i>
																	<i class="em em-stuck_out_tongue"></i>
																</div>
																<button type="submit" value="submit"></button>
															</form>
														</div>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<!-- 뉴스피드 -->
							</div>
							<!-- /중간 -->

							<!-- 오른쪽  -->
							<div class="col-lg-3">
								<aside class="sidebar static right">
									<div class="widget">
										<h4 class="widget-title">Your page</h4>
										<div class="your-page">
											<figure>
												<a href="#" title="">
													<img src="./images/resources/friend-avatar9.jpg" alt="">
												</a>
											</figure>
											<div class="page-meta">
												<a href="#" title="" class="underline">My page</a>
												<span>
													<i class="ti-comment"></i>
													<a href="insight.html" title="">Messages<em>9</em></a>
												</span>
												<span>
													<i class="ti-bell"></i>
													<a href="insight.html" title="">Notifications <em>2</em></a>
												</span>
											</div>
											<div class="page-likes">
												<ul class="nav nav-tabs likes-btn">
													<li class="nav-item">
														<a class="active" href="#link1"data-toggle="tab">likes</a>
													</li>
													<li class="nav-item">
														<a class="" href="#link2" data-toggle="tab">views</a>
													</li>
												</ul>
												<!-- Tab panes -->
												<div class="tab-content">
													<div class="tab-pane active fade show " id="link1">
														<span>
															<i class="ti-heart"></i>884
														</span>
														<a href="#" title="weekly-likes">35 new likes this week</a>
														<div class="users-thumb-list">
															<a href="#" title="Anderw" data-toggle="tooltip">
																<img src="./images/resources/userlist-1.jpg" alt="">
															</a>
															<a href="#" title="frank" data-toggle="tooltip">
																<img src="./images/resources/userlist-2.jpg" alt="">
															</a>
															<a href="#" title="Sara" data-toggle="tooltip">
																<img src="./images/resources/userlist-3.jpg" alt="">
															</a>
															<a href="#" title="Amy" data-toggle="tooltip">
																<img src="./images/resources/userlist-4.jpg" alt="">
															</a>
															<a href="#" title="Ema" data-toggle="tooltip">
																<img src="./images/resources/userlist-5.jpg" alt="">
															</a>
															<a href="#" title="Sophie" data-toggle="tooltip">
																<img src="./images/resources/userlist-6.jpg" alt="">
															</a>
															<a href="#" title="Maria" data-toggle="tooltip">
																<img src="./images/resources/userlist-7.jpg" alt="">
															</a>
														</div>
													</div>
													<div class="tab-pane fade" id="link2">
														<span>
															<i class="ti-eye"></i>440
														</span>
														<a href="#" title="weekly-likes">440 new views this week</a>
														<div class="users-thumb-list">
															<a href="#" title="Anderw" data-toggle="tooltip">
																<img src="./images/resources/userlist-1.jpg" alt="">
															</a> <a href="#" title="frank" data-toggle="tooltip">
																<img src="./images/resources/userlist-2.jpg" alt="">
															</a>
															<a href="#" title="Sara" data-toggle="tooltip">
																<img src="./images/resources/userlist-3.jpg" alt="">
															</a>
															<a href="#" title="Amy" data-toggle="tooltip">
																<img src="./images/resources/userlist-4.jpg" alt="">
															</a> <a href="#" title="Ema" data-toggle="tooltip">
																<img src="./images/resources/userlist-5.jpg" alt="">
															</a> <a href="#" title="Sophie" data-toggle="tooltip">
																<img src="./images/resources/userlist-6.jpg" alt="">
															</a> <a href="#" title="Maria" data-toggle="tooltip">
																<img src="./images/resources/userlist-7.jpg" alt="">
															</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- page like widget -->
									<div class="widget">
										<div class="banner medium-opacity bluesh">
											<div class="bg-image"
												style="background-image: url(./images/resources/baner-widgetbg.jpg)"></div>
											<div class="baner-top">
												<span><img alt="" src="./images/book-icon.png"></span>
												<i class="fa fa-ellipsis-h"></i>
											</div>
											<div class="banermeta">
												<p>create your own favourit page.</p>
												<span>like them all</span>
												<a data-ripple="" title="" href="#">start now!</a>
											</div>
										</div>
									</div>
									<div class="widget stick-widget">
										<h4 class="widget-title">Profile intro</h4>
										<ul class="short-profile">
											<li>
												<span>about</span>
												<p>Hi, i am jhon kates, i am 32 years old and worked as a web developer in microsoft</p>
											</li>
											<li>
												<span>fav tv show</span>
												<p>Sacred Games, Spartcus Blood, Games of Theron</p>
											</li>
											<li>
												<span>favourit music</span>
												<p>Justin Biber, Shakira, Nati Natasah</p>
											</li>
										</ul>
									</div>
								</aside>
							</div>
							<!-- /오른쪽 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		</section>
		
		<!-- bottom -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- /bottom -->
	</div>
	
	<!-- 웹페이지 쇼핑백 메뉴 -->
	<div class="side-panel">
		<jsp:include page="../inc/webTopRightSidePanel.jsp" />
	</div>
	<!-- 웹페이지 쇼핑백 메뉴 -->

	<script src="./js/main.min.js"></script>
	<script src="./js/script.js"></script>
	<script src="./js/map-init.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA8c55_YHLvDHGACkQscgbGLtLRdxBDCfI"></script>

</body>
</html>