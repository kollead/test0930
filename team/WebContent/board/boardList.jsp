<%@page import="java.util.Vector"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sns.member.db.MemberDTO"%>
<%@page import="sns.member.db.MemberDAO"%>
<%@page import="sns.board.db.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="sns.board.db.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" href="./css/style.css">
<link rel="stylesheet" href="./css/jquery.modal.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	
	// 게시글 수정
	function updateBoard(b_num) {
		
	}
	
	// 게시글 삭제
	function deleteBoard(b_num) {
		$.ajax({
			type : "post",
			url : "././BoardDeleteServlet",
			data : {b_num : b_num},
			dataType : "text",
			success : function(data) {
				alert("success");
				$('body').css('overflow', 'auto');
				$(".deleteModal").hide();
				$(".menuoverlay").fadeOut(500);
				location.reload();	// 삭제 후 새로고침
			},
			 error: function(jqXHR, exception) {

				// 에러 메세지
				if (jqXHR.status === 0) {
					alert('Not connect.\n Verify Network.');
				} else if (jqXHR.status == 400) {
					alert('Server understood the request, but request content was invalid. [400]');
				} else if (jqXHR.status == 401) {
					alert('Unauthorized access. [401]');
				} else if (jqXHR.status == 403) {
					alert('Forbidden resource can not be accessed. [403]');
				} else if (jqXHR.status == 404) {
					alert('Requested page not found. [404]');
				} else if (jqXHR.status == 500) {
					alert('Internal server error. [500]');
				} else if (jqXHR.status == 503) {
					alert('Service unavailable. [503]');
				} else if (exception === 'parsererror') {
					alert('Requested JSON parse failed. [Failed]');
				} else if (exception === 'timeout') {
					alert('Time out error. [Timeout]');
				} else if (exception === 'abort') {
					alert('Ajax request aborted. [Aborted]');
				} else {
					alert('Uncaught Error.n' + jqXHR.responseText);
				}
			        
			        $(".deleteModal").hide();
					$(".menuoverlay").fadeOut(500);
			    }
		});
	 }
</script>

<%
	String email = (String) session.getAttribute("email");
	int m_num = (int) session.getAttribute("m_num");
	
	if (email == null) {
		response.sendRedirect("./Login.me");
	}

	// 글정보, 글에 해당하는 회원정보 가져오기
	BoardDAO bdao = new BoardDAO();
	Vector vec = bdao.selectMainBoardList(m_num);
	
	List<BoardDTO> boardList = (List) vec.get(0);
	List<MemberDTO> memberList = (List) vec.get(1);

	if (boardList.size() == 0) {
%>
	<div id="noneBoard">
		<br>
		<h2>환영합니다!</h2><br>
		<p>친구를 추가하여 시작해보세요.<br>친구의 동영상, 사진 및 게시물이 여기에 표시됩니다.</p>
		<br>
	</div>
<%
	} else {
		for (int i = 0; i < boardList.size(); i++) {
			BoardDTO bdto = boardList.get(i);
			MemberDTO mdto = memberList.get(i);
			
			// 링크 처리를 위한 정규식 표현. 링크는 http://로 시작
			String regex = "([\\p{Alnum}]+)://([a-z0-9.\\-&/%=?:@#$(),.+;~\\_]+)";
			
			Pattern p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
			Matcher m = p.matcher(bdto.getB_content());
			
			// 글 내용중 링크에 하이퍼링크 처리한 결과를 담음
			String content = m.replaceAll("<a href='http://$2' target=_blank>http://$2</a>");
			content.replace("\r\n", "<br>");
			
			// 이미지 리스트
			String[] imgs = null;
			
			// 넘어온 이미지, 동영상 수
			int imgCnt = 0;
			int videoCnt = 0;
			
			if (bdto.getImg() != null) {
				imgs = new String[5];
				imgs = bdto.getImg().split(",");
				imgCnt = imgs.length;
			}
			
			if (bdto.getVideo() != null) {
				videoCnt = 1;
			}
%>
<div class="central-meta item">
	<div class="user-post">
		<div class="friend-info">
			<!-- 게시글의 작성자 사진 -->
			<figure>
				<img class="boardImg" src="./upload/member/<%=mdto.getProfile() %>" alt="">
			</figure>
			<!-- /게시글의 작성자 사진 -->

			<!-- 게시글의 작성자 이름/날짜정보 -->
			<div class="friend-name">
				<ins>
					<a href="time-line.html" title=""><%=mdto.getF_name() %><%=mdto.getL_name() %></a>
				</ins>
				
			<% 
				if (bdto.getB_m_num() == m_num) {
			%>
				<div class="board-more">
					<span class="board-more-optns"><i class="ti-more-alt"></i>
						<ul>
							<li><a href="#" class="updateBoard<%=bdto.getB_num() %>">게시물 수정</a></li>
							<li><a href="#deleteModal<%=bdto.getB_num() %>" class="deleteBoard<%=bdto.getB_num() %>" >게시물 삭제</a></li>
						</ul>
					</span>
				</div>
				
				<!-- 수정 Modal popup -->
				<div id="updateModal<%=bdto.getB_num() %>" class="updateModal">
					<a class="close-modal"></a>
					<p>
					<%-- 	<jsp:include page="./update.jsp?b_num=<%=bdto.getB_num() %>" /> --%>
					</p>
				</div>
				<!-- /수정 Modal popup -->
				
				<!-- 삭제 Modal popup -->
				<div id="deleteModal<%=bdto.getB_num() %>" class="deleteModal">
					<a class="close-modal"></a>
					<p>
						<form method="post">
							글번호 : <%=bdto.getB_num() %><br>
							게시물을 삭제하시겠습니까? <br>
							변경해야 할 사항이 있는 경우 수정할 수 있습니다.
							<hr>
							<div style="float: right;">
								<button type="button" class="delBoardBtn" style="font-size: 0.8em;" onclick="deleteBoard(<%=bdto.getB_num() %>);">삭제</button>
							</div>
						</form>
					</p>
				</div>
				<!-- /삭제 Modal popup -->
				
			<%
				}
			%>	
				<span id="fs"><%=bdto.getB_date() %></span>
				
			</div>
			<!-- /게시글의 작성자 이름/날짜정보 -->
			<!-- 게시글 내용 -->
			<!-- 게시글 content -->
			<div class="description">
				<!-- 게시물 번호 저장 -->
				<input type="hidden" name="b_num" value="<%=bdto.getB_num() %>">
				<pre><%=content %> / i:<%=i %> / b_num:<%=bdto.getB_num() %></pre>
			<%
				if (bdto.getB_content().contains("youtu.be")) {
			%>
					<div class="youtube">
						<iframe width="560" height="315" src="https://www.youtube.com/embed/<%=content.split("/")[3].substring(0, content.split("/")[3].indexOf("'")) %>?amp;autoplay=1" 
							frameborder="0" 
							allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" >
						</iframe>
					</div>
			<%
					}
			%>
			</div>
			<!-- /게시글 content -->
			<!-- 사진, vedio -->
			<div class="post-meta boardImg<%=imgCnt %> boardVideo">
		<%
			if (imgs != null) {
				for (int j = 0; j < imgCnt; j++) {
		%>
				<img src="./upload/board_img/<%=imgs[j] %>" alt="">
		<%				
				}
			} else {
				
			}
		
			if (bdto.getVideo() != null) {
		%>
				<div class="boardVideo<%=videoCnt %>">
					<video src="./upload/board_img/<%=bdto.getVideo() %>" 
							width="500px" height="500px" autoplay controls>
					
					</video>
				</div>
		<%
			}
		%>
				<!-- 조회수, 답글수, 좋아요, 싫어요, 공유 -->
				<div class="we-video-info">
					<ul>
						<li>
							<span class="comment" data-toggle="tooltip" title="Comments">
								<i class="fa fa-comments-o"></i> <ins><%=bdto.getCommCount() %></ins>
							</span>
						</li>
						<li>
							<span class="like" data-toggle="tooltip" title="like">
								<i class="ti-heart"></i> <ins><%=bdto.getB_like() %></ins>
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
					<!-- /조회수, 답글수, 좋아요, 싫어요, 공유 -->
				</div>
				<!-- /게시글 내용 -->
			</div>
			<!-- 댓글 -->
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
								we are working for the dance and sing songs.
								this car is very awesome for the youngster.
								please vote this car and like our post
							</p>
						</div>
						<ul>
							<li>
								<div class="comet-avatar">
									<img src="./images/resources/comet-2.jpg" alt="">
								</div>
								<div class="we-comment">
									<div class="coment-head">
										<h5>
											<a href="time-line.html" title="">alexendra dadrio</a>
										</h5>
										<span>1 month ago</span>
										<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
									</div>
									<p>
										yes, really very awesome car i see the features of
										this car in the official website of
										<a href="#" title="">#Mercedes-Benz</a> and really impressed :-)
									</p>
								</div>
							</li>
							<li>
								<div class="comet-avatar">
									<img src="./images/resources/comet-3.jpg" alt="">
								</div>
								<div class="we-comment">
									<div class="coment-head">
										<h5>
											<a href="time-line.html" title="">Olivia</a>
										</h5>
										<span>16 days ago</span>
										<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
									</div>
									<p>
										i like lexus cars, lexus cars are most beautiful
										with the awesome features, but this car is really
										outstanding than lexus
									</p>
								</div>
							</li>
						</ul>
					</li>
					<li>
						<div class="comet-avatar">
							<img src="./images/resources/comet-4.jpg" alt="">
						</div>
						<div class="we-comment">
							<div class="coment-head">
								<h5>
									<a href="time-line.html" title="">Donald Trump</a>
								</h5>
								<span>1 week ago</span>
								<a class="we-reply" href="#" title="Reply"><i class="fa fa-reply"></i></a>
							</div>
							<p>
								we are working for the dance and sing songs. this video
								is very awesome for the youngster. please vote this
								video and like our channel <i class="em em-smiley"></i>
							</p>
						</div>
					</li>
					<li>
						<a href="#" title="" class="showmore underline">more comments</a>
					</li>
					<li class="post-comment">
						<div class="comet-avatar">
							<img src="./images/resources/comet-1.jpg" alt="">
						</div>
														
						<!-- 답글 작성란 -->
						<div class="post-comt-box">
							<form method="post">
								<textarea placeholder="Post your comment"></textarea>
								<button type="submit"></button>
							</form>
						</div>
						<!-- /답글 작성란 -->
					</li>
				</ul>
			</div>
		</div>
	</div>
<%
		}
	}
%>