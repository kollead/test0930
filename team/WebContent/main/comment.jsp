<%@page import="sns.board.db.CommentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sns.board.db.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script> 
<script type="text/javascript">

function commLoad(boardNum, getNum){//b_num, showmore 횟수
	
	alert("CommLoad");
	
	var bNum=boardNum; 
	var comment_HTML; //코멘트 html
	var getNum=getNum;
	
	var role;//email 세션값!!!->수정삭제 보여줄지 말지 정하기 위해서 
	
	
	if($("#role").val()!=null){//email 세션 
		role=$("#role").val();
	}else{role="";}
	alert(role);
	
	alert("loadMore getNum: "+getNum);
	
	$("#showMoreLi"+bNum).remove();
	
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
										
					comment_HTML +='<li class="post-comment post-reComment'+data[i].c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="reCommText'+data[i].c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commReInsert('+data[i].c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">게시</button></form></div></li>';
					comment_HTML +='<li class="post-comment post-updateComment'+data[i].c_num+'" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="upCommText'+data[i].c_num+'" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commUpdate('+data[i].c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">수정</button></form></div></li><div id="replyDiv'+data[i].c_num+'"></div>';					
					
					if(data[i].re_lev>0){
						comment_HTML +='</ul>';
					}
										
					$(".commentUl"+bNum).prepend(comment_HTML);					
				}
			
		},
		error: function(data){
				alert("error");
		}
	});
			
	
		
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
				comment_HTML='<li id="showMoreLi"'+bNum'><a href="javascript:commLoad('+bNum+','+(+getNum+1)+');" title="" class="showmore underline">more comments</a>'
				$(".commentUl"+bNum).prepend(comment_HTML);				
			}
		},
		error: function(data){
			alert("error");
		}
	});
		
}

</script>
</head>
<body>


<%
	String email="ann"; //(String)request.getAttribute("email");
	CommentDAO cdao= new CommentDAO();
	int cLength=cdao.commentLength(1);//1=boardnum
	ArrayList<CommentDTO> arr= new ArrayList<CommentDTO>();
	arr=cdao.commentRead(1, 0);//1=boardnum 0 초기 시작
			
%>
	
	<input type="hidden" value="<%=email %>" name="role">
	
	<div class="coment-area" id="commarea1">
		<ul class="we-comet commentUl<%=1%>"><!-- 추가로 로드된 코멘트들이 commentUl1에 prepend -->
		
		<%if(cLength-5>0){ %>
				<li id="showMoreLi<%=1 %>"><a href="javascript:commLoad(1,1);" title="" class="showmore underline">more comments</a></li>
				<!-- //javascript:commLoad(1,1) //bNum, 초기 showmoreNum1 -->
		<%}
		for(int i = 0; i < arr.size(); i++){						
										
					if(arr.get(i).getRe_lev()>0){ %>
						<ul id="commPara<%=arr.get(i).getC_num()%>"><li style="margin-left:<%=arr.get(i).getRe_lev()*2%>%;">
					<%}else{ %>
						<li id="commPara<%=arr.get(i).getC_num()%>">
					<%}%>
					
					<div class="comet-avatar"><img src="images/resources/comet-1.jpg" alt=""></div><div class="we-comment"><div class="coment-head"><h5><a href="time-line.html" title=""><%=arr.get(i).getL_name()+" "+arr.get(i).getF_name()%></a></h5><span><%=arr.get(i).getC_date()%></span><a class="we-reply" href="javascript:toggleReply(<%=arr.get(i).getC_num()%>);" title="Reply"><i class="fa fa-reply"></i></a>
					
					<%if(email.equals(arr.get(i).getEmail())){ %>
						<div class="more"><span class="more-optns"><i class="ti-more-alt"></i><ul><li onclick="toggleUpdate(<%=arr.get(i).getC_num()%>)"> 수정 </li><li onclick="commDelete(<%=arr.get(i).getC_num()%>)"> 삭제 </li></ul></span></div></div>
					<%} %>
					
					<p id="commContentP<%=arr.get(i).getC_num()%>"><%=arr.get(i).getC_content()%></p></div></li>';
										
					<li class="post-comment post-reComment<%=arr.get(i).getC_num()%>" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="reCommText<%=arr.get(i).getC_num()%>" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commReInsert('+data[i].c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">게시</button></form></div></li>
					<li class="post-comment post-updateComment<%=arr.get(i).getC_num()%>" style="display:none; margin-left: 3%;"><div class="comet-avatar"><img src="./images/resources/comet-1.jpg" alt=""></div><div class="post-comt-box"><form method="post"><textarea id="upCommText<%=arr.get(i).getC_num()%>" placeholder="Post your comment"></textarea><button id="formButton" type="button" onclick="javascript:commUpdate('+data[i].c_num+');" style="float: right; margin-bottom:5px; margin-right:5px;">수정</button></form></div></li><div id="replyDiv<%=arr.get(i).getC_num()%>"></div>					
					
					<%if(arr.get(i).getRe_lev()>0){ %>
						</ul>
					<%}
					} %>
			<div id="newCommt<%=1%>"></div><!--  새로 insert 될 코멘트가 newCommt1 에 toPrepend -->
			<li class="post-comment">
				<div class="comet-avatar">
					<img src="./images/resources/comet-1.jpg" alt="">
				</div> 
				
				<!-- 답글 작성란 -->
								
				<div class="post-comt-box">
					<form method="post">
						<textarea id="commText<%=1%>" placeholder="Post your comment"></textarea>
						<button id="formButton" type="button"
							onclick="javascript:commInsert(<%=1%>);"
							style="float: right; margin-bottom: 5px; margin-right: 5px;">게시</button>
					</form>
				</div> 

			</li>
		</ul>
	</div>

</body>
</html>